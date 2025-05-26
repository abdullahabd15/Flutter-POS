import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_cubit.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:resources/enum/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jelly Grande',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cashier',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DrawerItem(
              route: Routes.home.route,
              icon: Ph.storefront_light,
              label: Routes.home.title,
            ),
            DrawerItem(
              route: Routes.transactions.route,
              icon: Ph.table_light,
              label: Routes.transactions.title,
            ),
            DrawerItem(
              route: Routes.report.route,
              icon: Ph.presentation_chart_light,
              label: Routes.report.title,
            ),
            const Spacer(),
            ListTile(
              leading: const Iconify(Ph.sign_out_light, color: Colors.redAccent),
              title: const Text(
                'Log Out',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                // Add logout logic here
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      }),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String icon;
  final String label;
  final String route;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      final isSelected = state.currentRoute.route == route;
      return ListTile(
        leading: Iconify(
          icon,
          color: isSelected ? Colors.blueAccent : Colors.black87,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blueAccent : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        tileColor: isSelected ? Colors.blue.shade50 : Colors.transparent,
        onTap: () {
          Scaffold.of(context).closeDrawer();
          mainCubit.setCurrentRoute(route);
        },
      );
    });
  }
}
