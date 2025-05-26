import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:dependencies/google_fonts/google_fonts.dart';
import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_cubit.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:flutter_pos/ui/app_drawer.dart';
import 'package:flutter_pos/ui/date_time_header.dart';
import 'package:resources/enum/routes.dart';

class MainContainerScreen extends StatelessWidget {
  final Widget child;

  const MainContainerScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        switch (state.currentRoute) {
          case Routes.home:
            router.go(Routes.home.route);
            break;
          case Routes.transactions:
            router.go(Routes.transactions.route);
            break;
          case Routes.report:
            router.go(Routes.report.route);
            break;
          case Routes.login:
            router.go(Routes.login.route);
          case Routes.register:
            router.go(Routes.register.route);
          case Routes.forgotPassword:
            router.go(Routes.forgotPassword.route);
        }
      },
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context, state.currentRoute.title),
            drawer: const AppDrawer(),
            body: child,
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context, String title) => AppBar(
        toolbarHeight: 57.4,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.6),
          child: Container(color: Colors.grey, height: 0.6),
        ),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: GoogleFonts.urbanist().fontFamily,
        ),
        iconTheme: const IconThemeData(
          opticalSize: 36,
        ),
        actions: [
          const DateTimeHeader(),
          const SizedBox(width: 24),
          IconButton(
            onPressed: () {},
            icon: const Iconify(
              Ph.sign_out_light,
              color: Colors.redAccent,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
}
