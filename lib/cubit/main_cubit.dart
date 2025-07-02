import 'package:common/extension/extension.dart';
import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:resources/enum/routes.dart';

class MainCubit extends HydratedCubit<MainState> {
  final bool isLoggedIn;

  MainCubit({required this.isLoggedIn})
      : super(
          MainState(
            currentRoute: isLoggedIn ? Routes.home : Routes.login,
            selectedItemDrawer:
                isLoggedIn ? Routes.home.route : Routes.login.route,
          ),
        );

  void setCurrentRoute(String route) {
    emit(
      state.copyWith(
        currentRoute: Routes.values.firstWhere((e) => e.route == route),
        selectedItemDrawer: route,
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
        selectedItemDrawer: loggedIn ? Routes.home.route : Routes.login.route,
      ),
    );
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    final selectedItemDrawer = json['selectedItemDrawer'];
    final currentRoute = json['currentRoute'] ??
        Routes.values.firstWhere((e) => e.route == selectedItemDrawer);
    final isLoggedIn = json['isLoggedIn'];
    return MainState(
      currentRoute: currentRoute,
      selectedItemDrawer: selectedItemDrawer,
      isLoggedIn: isLoggedIn,
    );
  }

  @override
  Map<String, dynamic>? toJson(MainState state) => {
        'selectedItemDrawer': state.selectedItemDrawer,
        'currentRoute': state.currentRoute.route,
        'isLoggedIn': state.isLoggedIn,
      };
}
