// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      gamesPlayed: json['gamesPlayed'] as int,
      gamesWon: json['gamesWon'] as int,
      currStreak: json['currStreak'] as int,
      maxStreak: json['maxStreak'] as int,
      guessDistribution:
          Map<String, int>.from(json['guessDistribution'] as Map),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'currStreak': instance.currStreak,
      'maxStreak': instance.maxStreak,
      'guessDistribution': instance.guessDistribution,
    };
