import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/detail/details_screen.dart';
import 'package:movie_app/screen/home/bloc/home_bloc.dart';
import 'package:movie_app/utils/enum/tabs.dart';

import '../di/injector_container.dart';
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
            return BlocProvider(
              create:
                  (create) =>
                      getIt<HomeBloc>()
                        ..add(OnTabSwitch(tabs: Tabs.popular, isNew: true))
                        ..add(FetchGenre()),
              child: const HomeScreen(),
            );
          },
        );

      case Routes.detail:
        return MaterialPageRoute(
          builder: (context) {
            return DetailsScreen(movieModel: arguments!["args"]);
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
