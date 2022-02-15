// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../statistics/view/statistics_page.dart' as _i2;
import '../../wordle/view/wordle_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    WordleRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.WordlePage());
    },
    StatisticsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.StatisticsPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(WordleRoute.name, path: '/'),
        _i3.RouteConfig(StatisticsRoute.name, path: '/statistics-page')
      ];
}

/// generated route for
/// [_i1.WordlePage]
class WordleRoute extends _i3.PageRouteInfo<void> {
  const WordleRoute() : super(WordleRoute.name, path: '/');

  static const String name = 'WordleRoute';
}

/// generated route for
/// [_i2.StatisticsPage]
class StatisticsRoute extends _i3.PageRouteInfo<void> {
  const StatisticsRoute()
      : super(StatisticsRoute.name, path: '/statistics-page');

  static const String name = 'StatisticsRoute';
}
