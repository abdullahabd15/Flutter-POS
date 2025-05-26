import 'package:dependencies/hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_pos/cubit/main_state.dart';
import 'package:resources/enum/routes.dart';

class MainCubit extends HydratedCubit<MainState> {
  MainCubit()
      : super(
          MainState(
            currentRoute: Routes.login,
            selectedItemDrawer: Routes.login.route,
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

  @override
  MainState? fromJson(Map<String, dynamic> json) {
    final selectedItemDrawer = json['selectedItemDrawer'];
    final currentRoute =
        Routes.values.firstWhere((e) => e.route == selectedItemDrawer);
    return MainState(
        currentRoute: currentRoute, selectedItemDrawer: selectedItemDrawer);
  }

  @override
  Map<String, dynamic>? toJson(MainState state) => {
        'selectedItemDrawer': state.selectedItemDrawer,
      };
}
