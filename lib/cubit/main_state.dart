import 'package:dependencies/equatable/equatable.dart';
import 'package:resources/enum/routes.dart';

class MainState extends Equatable {
  final bool isLoggedIn;
  final Routes currentRoute;
  final String selectedItemDrawer;

  const MainState({
    required this.currentRoute,
    required this.selectedItemDrawer,
    this.isLoggedIn = false,
  });

  MainState copyWith({
    Routes? currentRoute,
    String? selectedItemDrawer,
    bool? isLoggedIn,
  }) {
    return MainState(
      currentRoute: currentRoute ?? this.currentRoute,
      selectedItemDrawer: selectedItemDrawer ?? this.selectedItemDrawer,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [currentRoute, selectedItemDrawer, isLoggedIn];
}
