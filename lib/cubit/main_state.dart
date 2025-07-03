import 'package:dependencies/equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:resources/enum/routes.dart';

class MainState extends Equatable {
  final Routes currentRoute;
  final List<SideMenu> sideMenu;
  final int selectedIndex;

  const MainState({
    required this.currentRoute,
    required this.sideMenu,
    required this.selectedIndex,
  });

  MainState copyWith({
    Routes? currentRoute,
    List<SideMenu>? sideMenu,
    int? selectedIndex,
    bool? isLoggedIn,
  }) {
    return MainState(
      currentRoute: currentRoute ?? this.currentRoute,
      sideMenu: sideMenu ?? this.sideMenu,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        currentRoute,
        sideMenu,
        selectedIndex,
      ];
}

class SideMenu {
  final int index;
  final String title;
  final IconData icon;

  SideMenu({required this.index, required this.title, required this.icon});
}
