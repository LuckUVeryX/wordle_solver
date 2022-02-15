import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'core/repositories/word_repository.dart';
import 'core/router/router.dart';
import 'core/services/app_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Logger.level = Level.verbose;

  List<String> words =
      (await rootBundle.loadString('assets/words.txt')).split('\n');

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AppPreferences(), lazy: false),
        Provider(create: (_) => WordRepository(words)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wordle Solver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
          brightness: Brightness.dark,
        ),
      ),
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [RouterLoggingObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
