import 'package:dependencies/equatable/equatable.dart';
import 'package:resources/enum/routes.dart';

class MainState extends Equatable {
  final Routes currentRoute;
  final String selectedItemDrawer;

  const MainState({
    required this.currentRoute,
    required this.selectedItemDrawer,
  });

  MainState copyWith({
    Routes? currentRoute,
    String? selectedItemDrawer,
  }) {
    return MainState(
      currentRoute: currentRoute ?? this.currentRoute,
      selectedItemDrawer: selectedItemDrawer ?? this.selectedItemDrawer,
    );
  }

  @override
  List<Object?> get props => [currentRoute, selectedItemDrawer];
}
