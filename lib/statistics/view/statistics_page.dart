import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/app_preference.dart';
import '../models/statistics.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Statistics stats = context.read<AppPreferences>().statistics;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Text(stats.gamesPlayed.toString(), style: textTheme.headline4),
            Text('Played', style: textTheme.subtitle2),
            Text('${stats.winPercentage * 100}', style: textTheme.headline4),
            Text('Win %', style: textTheme.subtitle2),
            Text(stats.currStreak.toString(), style: textTheme.headline4),
            Text('Current Streak', style: textTheme.subtitle2),
            Text(stats.maxStreak.toString(), style: textTheme.headline4),
            Text('Max Streak', style: textTheme.subtitle2),
            const Text('GUESS DISTRIBUTION'),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: (stats.guessDistribution.values.toList()..add(1))
                      .reduce(max)
                      .toDouble(),
                  titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                          showTitles: true,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 1:
                                return '1';
                              case 2:
                                return '2';
                              case 3:
                                return '3';
                              case 4:
                                return '4';
                              case 5:
                                return '5';
                              case 6:
                                return '6';
                              case -1:
                                return 'Fail';
                              default:
                                return '';
                            }
                          })),
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      showingTooltipIndicators: [0],
                      barRods: [
                        BarChartRodData(
                            y: stats.guessDistribution['1']?.toDouble() ?? 0.0),
                      ],
                    ),
                    BarChartGroupData(x: 2, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['2']?.toDouble() ?? 0.0),
                    ]),
                    BarChartGroupData(x: 3, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['3']?.toDouble() ?? 0.0),
                    ]),
                    BarChartGroupData(x: 4, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['4']?.toDouble() ?? 0.0),
                    ]),
                    BarChartGroupData(x: 5, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['5']?.toDouble() ?? 0.0),
                    ]),
                    BarChartGroupData(x: 6, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['6']?.toDouble() ?? 0.0),
                    ]),
                    BarChartGroupData(x: -1, showingTooltipIndicators: [
                      0
                    ], barRods: [
                      BarChartRodData(
                          y: stats.guessDistribution['-1']?.toDouble() ?? 0.0),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
