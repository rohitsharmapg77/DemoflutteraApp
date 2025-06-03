import 'package:flutter/material.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/user_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginScreen(),
    '/UserScreen': (context) => UserScreen(),

  };
}