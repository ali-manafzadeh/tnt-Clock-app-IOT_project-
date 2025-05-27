import 'package:flutter/material.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';

Future<void> saveTimeOfDay(TimeOfDay startTime, TimeOfDay endTime) async {
  String formattedStartTime =
      '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:00';
  String formattedEndTime =
      '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:00';
  String lightTimeSet = '${formattedStartTime}_${formattedEndTime}';

  print('the time is $lightTimeSet');
  AppPreferences.lightTimeSet = lightTimeSet;
}

TimeOfDay stringToTimeOfDay(String time) {
  final parts = time.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

void loadTimeOfDay() {
  String lightTimeSet = AppPreferences.lightTimeSet;
  if (lightTimeSet != null) {
    final times = lightTimeSet.split('_');
    final startTime = stringToTimeOfDay(times[0]);
    final endTime = stringToTimeOfDay(times[1]);

    // Now you can use startTime and endTime as needed
  }
}
