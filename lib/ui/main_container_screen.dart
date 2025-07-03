import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_cubit.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:home/presentation/ui/home/home_screen.dart';
import 'package:home/presentation/ui/productmanagement/product_management_screen.dart';

class MainContainerScreen extends StatelessWidget {
  const MainContainerScreen({super.key});

  Widget _buildChild(int index) {
    switch (index) {
      case 0: return const HomeScreen();
      case 1: return Container();
      case 2: return Container();
      case 3: return const ProductManagementScreen();
      default: return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        // switch (state.selectedIndex) {
        //   case 0:
        //     context.read<MainCubit>().setCurrentChild(const HomeScreen());
        //     break;
        //   case 1:
        //     context.read<MainCubit>().setCurrentChild(Container());
        //     break;
        //   case 2:
        //     context.read<MainCubit>().setCurrentChild(Container());
        //     break;
        //   case 3:
        //     context
        //         .read<MainCubit>()
        //         .setCurrentChild(const ProductManagementScreen());
        //     break;
        //   default:
        //     context.read<MainCubit>().setCurrentChild(const HomeScreen());
        //     break;
        // }
      },
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: 124,
                  child: NavigationRail(
                    indicatorColor: Colors.white24,
                    backgroundColor: Colors.blue[700],
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.white70),
                    selectedLabelTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    unselectedLabelTextStyle:
                        const TextStyle(color: Colors.white70),
                    selectedIndex: state.selectedIndex,
                    onDestinationSelected: (int index) {
                      context.read<MainCubit>().setSelectedIndex(index);
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: state.sideMenu
                        .map((e) => NavigationRailDestination(
                              icon: Icon(e.icon),
                              label: Text(
                                e.title,
                                textAlign: TextAlign.center,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(child: _buildChild(state.selectedIndex)),
              ],
            ),
          );
        },
      ),
    );
  }
}
