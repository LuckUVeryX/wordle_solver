import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class Statistics {
  int gamesPlayed;
  int gamesWon;
  int currStreak;
  int maxStreak;
  Map<String, int> guessDistribution;

  Statistics({
    required this.gamesPlayed,
    required this.gamesWon,
    required this.currStreak,
    required this.maxStreak,
    required this.guessDistribution,
  });

  factory Statistics.empty() {
    return Statistics(
      gamesPlayed: 0,
      gamesWon: 0,
      currStreak: 0,
      maxStreak: 0,
      guessDistribution: {},
    );
  }

  double get winPercentage => gamesWon / gamesPlayed;

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @override
  String toString() {
    return 'Statistics(gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, currStreak: $currStreak, maxStreak: $maxStreak, guessDistribution: $guessDistribution)';
  }

  Statistics copyWith({
    int? gamesPlayed,
    int? gamesWon,
    int? currStreak,
    int? maxStreak,
    Map<String, int>? guessDistribution,
  }) {
    return Statistics(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      currStreak: currStreak ?? this.currStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      guessDistribution: guessDistribution ?? this.guessDistribution,
    );
  }
}
