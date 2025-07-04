import 'package:dependencies/equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:resources/enum/routes.dart';

class MainState extends Equatable {
  final Routes currentRoute;
  final List<SideMenu> sideMenu;
  final int selectedIndex;
  final bool isLoggedIn;

  const MainState({
    required this.currentRoute,
    required this.sideMenu,
    required this.selectedIndex,
    required this.isLoggedIn,
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
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [
        currentRoute,
        sideMenu,
        selectedIndex,
        isLoggedIn,
      ];
}

class SideMenu {
  final int index;
  final String title;
  final IconData icon;

  SideMenu({required this.index, required this.title, required this.icon});
}
