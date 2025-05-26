import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static getContext() => navigatorKey.currentState?.context;
}
