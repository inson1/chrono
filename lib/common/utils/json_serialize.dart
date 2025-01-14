import 'dart:convert';

import 'package:clock_app/alarm/types/alarm.dart';
import 'package:clock_app/alarm/types/alarm_task.dart';
import 'package:clock_app/common/types/time.dart';
import 'package:clock_app/clock/types/city.dart';
import 'package:clock_app/common/types/json.dart';
import 'package:clock_app/stopwatch/types/stopwatch.dart';
import 'package:clock_app/theme/types/color_scheme.dart';
import 'package:clock_app/theme/types/style_theme.dart';
import 'package:clock_app/timer/types/timer.dart';
import 'package:clock_app/timer/types/timer_preset.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/common/utils/time_of_day.dart';

final fromJsonFactories = <Type, Function>{
  Alarm: (Json json) => Alarm.fromJson(json),
  City: (Json json) => City.fromJson(json),
  ClockTimer: (Json json) => ClockTimer.fromJson(json),
  ClockStopwatch: (Json json) => ClockStopwatch.fromJson(json),
  TimerPreset: (Json json) => TimerPreset.fromJson(json),
  ColorSchemeData: (Json json) => ColorSchemeData.fromJson(json),
  StyleTheme: (Json json) => StyleTheme.fromJson(json),
  AlarmTask: (Json json) => AlarmTask.fromJson(json),
  Time: (Json json) => Time.fromJson(json),
  TimeOfDay: (Json json) => TimeOfDayUtils.fromJson(json),
  // AlarmTaskList: (Json json) => AlarmTaskList.fromJson(json),
};

// Json listToJson<T extends JsonSerializable>(List<T> items) => Json(
//       items.map<Json>((item) => item.toJson()).toList(),
//     );

String listToString<T extends JsonSerializable>(List<T> items) => json.encode(
      items.map<Json>((item) => item.toJson()).toList(),
    );

List<T> listFromString<T extends JsonSerializable>(String encodedItems) {
  if (!fromJsonFactories.containsKey(T)) {
    throw Exception("No fromJson factory for type '$T'");
  }

  return (json.decode(encodedItems) as List<dynamic>)
      .map<T>((json) => fromJsonFactories[T]!(json))
      .toList();
}
