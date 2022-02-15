import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../statistics/models/statistics.dart';
import '../logs/app_logger.dart';

class AppPreferences {
  AppPreferences() {
    _log = getLogger(runtimeType.toString());
    _init();
  }

  late final Logger _log;
  late final SharedPreferences _pref;

  static const _kStatistics = 'kStatistics';
  Statistics get statistics {
    final jsonString = _pref.getString(_kStatistics);
    Statistics stats = Statistics.empty();
    if (jsonString != null) {
      stats = Statistics.fromJson(jsonDecode(jsonString));
    }

    _log.i(stats);
    return stats;
  }

  Future<void> saveStatistics(Statistics value) async {
    await _pref.setString(_kStatistics, jsonEncode(value.toJson()));
  }

  void _init() async {
    _pref = await SharedPreferences.getInstance();
  }
}
