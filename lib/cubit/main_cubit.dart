import 'package:common/extension/extension.dart';
import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:dependencies/intl/intl.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:pos/data/models/user.dart';
import 'package:pos/domain/usecase/logout_use_case.dart';
import 'package:resources/enum/routes.dart';

List<SideMenu> sideMenu = [
  SideMenu(index: 0, title: 'Home', icon: Icons.home),
  SideMenu(index: 1, title: 'Orders', icon: Icons.receipt_long),
  SideMenu(index: 2, title: 'History', icon: Icons.history),
  SideMenu(index: 3, title: 'Products Management', icon: Icons.fastfood),
];

class MainCubit extends HydratedCubit<MainState> {
  final LogoutUseCase logoutUseCase;
  final bool isLoggedIn;

  MainCubit({
    required this.logoutUseCase,
    required this.isLoggedIn,
  }) : super(
          MainState(
            currentRoute: isLoggedIn ? Routes.home : Routes.login,
            sideMenu: sideMenu,
            selectedIndex: 0,
            isLoggedIn: isLoggedIn,
            currentDate: null,
            user: null,
          ),
        );

  void setUser(User? user) {
    emit(state.copyWith(user: user));
  }

  void setupCurrentDate() {
    try {
      final date = DateTime.now();
      final format = DateFormat('EEEE, dd MMMM yyyy');
      final formattedDate = format.format(date);
      emit(state.copyWith(currentDate: formattedDate));
    } catch (e) {
      emit(state.copyWith(currentDate: null));
    }
  }

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
    final token = prefs.getToken();
    final loggedIn = token != null && token.isNotEmpty;
    emit(
      state.copyWith(
        isLoggedIn: loggedIn,
        currentRoute: loggedIn ? Routes.home : Routes.login,
      ),
    );
  }

  Future<void> logout() async {
    final result = await logoutUseCase.execute();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.message)),
      (data) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.removeToken();
        emit(
          state.copyWith(
            isLoggedIn: false,
            currentRoute: Routes.login,
          ),
        );
      },
    );
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    final selectedIndex = json['selectedIndex'];
    final currentRoute = json['currentRoute'];
    final isLoggedIn = json['isLoggedIn'];
    final currentDate = json['currentDate'];
    final user = json['user'];
    return MainState(
      currentRoute: currentRoute,
      sideMenu: sideMenu,
      selectedIndex: selectedIndex,
      isLoggedIn: isLoggedIn,
      currentDate: currentDate,
      user: User.fromJson(user),
    );
  }

  @override
  Map<String, dynamic>? toJson(MainState state) => {
        'selectedIndex': state.selectedIndex,
        'currentRoute': state.currentRoute.route,
        'isLoggedIn': state.isLoggedIn,
        'currentDate': state.currentDate,
        'user': state.user?.toJson(),
      };
}
