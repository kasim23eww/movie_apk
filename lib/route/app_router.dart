
import 'package:flutter/material.dart';
import 'package:movie_app/screen/detail/details_screen.dart';

import '../screen/home/home_screen.dart';


class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {

      case Routes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );

      case Routes.detail:
        return MaterialPageRoute(
          builder: (context) {
            return const DetailsScreen();
          },
        );

      default:
        return null;
    }
  }
}

abstract class Routes {
  static const String home = "home";
  static const String detail = "detail";
}