import 'package:common/extension/extension.dart';
import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:resources/enum/routes.dart';

List<SideMenu> sideMenu = [
  SideMenu(index: 0, title: 'Home', icon: Icons.home),
  SideMenu(index: 1, title: 'Orders', icon: Icons.receipt_long),
  SideMenu(index: 2, title: 'History', icon: Icons.history),
  SideMenu(index: 3, title: 'Products Management', icon: Icons.fastfood),
];

class MainCubit extends HydratedCubit<MainState> {
  final bool isLoggedIn;

  MainCubit({required this.isLoggedIn})
      : super(
          MainState(
            currentRoute: isLoggedIn ? Routes.home : Routes.login,
            sideMenu: sideMenu,
            selectedIndex: 0,
            isLoggedIn: isLoggedIn,
          ),
        );

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void setCurrentRoute(String route) {
    emit(
      state.copyWith(
        currentRoute: Routes.values.firstWhere((e) => e.route == route),
      ),
    );
  }

  Future<void> checkAndSyncLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getToken();
    final loggedIn = token != null && token.isNotEmpty;
    emit(
      state.copyWith(
        isLoggedIn: loggedIn,
        currentRoute: loggedIn ? Routes.home : Routes.login,
      ),
    );
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    final selectedIndex = json['selectedIndex'];
    final currentRoute = json['currentRoute'];
    final isLoggedIn = json['isLoggedIn'];
    return MainState(
      currentRoute: currentRoute,
      sideMenu: sideMenu,
      selectedIndex: selectedIndex,
      isLoggedIn: isLoggedIn,
    );
  }

  @override
  Map<String, dynamic>? toJson(MainState state) => {
        'selectedIndex': state.selectedIndex,
        'currentRoute': state.currentRoute.route,
        'isLoggedIn': state.isLoggedIn,
      };
}
