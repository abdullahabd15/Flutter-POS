import 'package:dependencies/equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pos/data/models/user.dart';
import 'package:resources/enum/routes.dart';

class MainState extends Equatable {
  final Routes currentRoute;
  final List<SideMenu> sideMenu;
  final int selectedIndex;
  final bool isLoggedIn;
  final String? currentDate;
  final User? user;
  final String? errorMessage;

  const MainState({
    required this.currentRoute,
    required this.sideMenu,
    required this.selectedIndex,
    required this.isLoggedIn,
    required this.currentDate,
    required this.user,
    this.errorMessage,
  });

  MainState copyWith({
    Routes? currentRoute,
    List<SideMenu>? sideMenu,
    int? selectedIndex,
    bool? isLoggedIn,
    String? currentDate,
    User? user,
    String? errorMessage,
  }) {
    return MainState(
      currentRoute: currentRoute ?? this.currentRoute,
      sideMenu: sideMenu ?? this.sideMenu,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentDate: currentDate ?? this.currentDate,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentRoute,
        sideMenu,
        selectedIndex,
        isLoggedIn,
        currentDate,
        user,
        errorMessage,
      ];
}

class SideMenu {
  final int index;
  final String title;
  final IconData icon;

  SideMenu({required this.index, required this.title, required this.icon});
}
