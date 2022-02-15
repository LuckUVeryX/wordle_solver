import 'package:auto_route/auto_route.dart';

import '../../statistics/view/statistics_page.dart';
import '../../wordle/view/wordle_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WordlePage, initial: true),
    AutoRoute(page: StatisticsPage),
  ],
)
class $AppRouter {}
