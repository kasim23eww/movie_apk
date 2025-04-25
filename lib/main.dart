import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/route/app_router.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'di/injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Hive.openBox(Constants.boxName);

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
