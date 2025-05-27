import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/widgets/convert.dart';

String formatedString(BuildContext context, Map<String, dynamic> value) {
  // var items = DatabaseHandler.readItem(widget.keyItem);

  List<String> extractedTime = DateTimeFormatter.extractDateTime(value['url']);
  String date = extractedTime.isNotEmpty ? extractedTime[0] : "";
  String hour = extractedTime.isNotEmpty ? extractedTime[1] : "";
  String minute = extractedTime.isNotEmpty ? extractedTime[2] : "";

// Convert strings to integers
  // dateInt = date.isNotEmpty ? int.parse(date) : 0;
  int hourInt = hour.isNotEmpty ? int.parse(hour) : 0;
  int minuteInt = minute.isNotEmpty ? int.parse(minute) : 0;
  DateTime selectedDate = DateTime.parse(date);
  print('the before Time ${extractedTime}');
  selectedDate = compareDateTimeMode(hourInt, minuteInt, selectedDate);

  timeMessage(context, hourInt, minuteInt, selectedDate);
  String formattedString = DateTimeFormatter.formatDateTime(
      hourInt.toString().padLeft(2, '0'),
      minuteInt.toString().padLeft(2, '0'),
      "${selectedDate.toLocal()}".split(' ')[0]);

  print('formated String : ${formattedString}');

  return formattedString;
}

// DateTime compareTimeEdit(int hour, int minute, DateTime selectedDate) {
//   DateTime now = DateTime.now();

//   if (selectedDate.day < now.day) {
//     // DateTime now = DateTime.now();
//     DateTime currentTime = DateTime(now.year, now.month, now.day, hour, minute);
//     selectedDate = currentTime;

//     if (currentTime.isBefore(now)) {
//       // TimeEdit is before current time, return tomorrow's date
//       return selectedDate.add(Duration(days: 1));
//     } else {
//       // TimeEdit is now or later, return today's date
//       return selectedDate;
//     }
//   } else {
//     return selectedDate;
//   }
// }

void ChangeAllformatedString() {
  // var items = DatabaseHandler.readItem(widget.keyItem);
  List<Map<String, dynamic>> result = DatabaseHandler.refreshItems();
  print('the result is $result');
  for (int i = 0; i < result.length; i++) {
    var value = result[i];

    List<String> extractedTime =
        DateTimeFormatter.extractDateTime(value['url']);
    String date = extractedTime.isNotEmpty ? extractedTime[0] : "";
    String hour = extractedTime.isNotEmpty ? extractedTime[1] : "";
    String minute = extractedTime.isNotEmpty ? extractedTime[2] : "";

    if (date != 'e') {
      // Convert strings to integers
      // dateInt = date.isNotEmpty ? int.parse(date) : 0;
      int hourInt = hour.isNotEmpty ? int.parse(hour) : 0;
      int minuteInt = minute.isNotEmpty ? int.parse(minute) : 0;
      DateTime selectedDate = DateTime.parse(date);
      print('the before Time ${extractedTime}');

      String formattedString = DateTimeFormatter.formatDateTime(
          hourInt.toString().padLeft(2, '0'),
          minuteInt.toString().padLeft(2, '0'),
          "${selectedDate.toLocal()}".split(' ')[0]);

      print('foramted Stringg : ${formattedString}');

      // return formattedString;
      DatabaseHandler.updateItem(value['key'], {
        "key": value['key'],
        "url": value['url'],
        "mode": compareTimeEditForMods(hourInt, minuteInt, selectedDate),
        "format": value['format'],
      });
      final dataIndex = DatabaseHandler.readItem(value['key']);

      print('selected date : ${dataIndex}');
    }
  }
}

String compareTimeEditForMods(int hour, int minute, DateTime selectedDate) {
  DateTime now = DateTime.now();

  if (selectedDate.isBefore(now)) {
    // DateTime now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, hour, minute);
    selectedDate = currentTime;

    if (currentTime.isBefore(now)) {
      // TimeEdit is before current time, return tomorrow's date
      // return selectedDate.add(Duration(days: 1));
      return "off";
    } else {
      // TimeEdit is now or later, return today's date
      return "on";
    }
  } else {
    return "on";
  }
}

// for update the time after the mode is ON
DateTime compareDateTimeMode(int hour, int minute, DateTime tempreryDate) {
  DateTime now = DateTime.now();

  DateTime currentTime = DateTime(
      tempreryDate.year, tempreryDate.month, tempreryDate.day, hour, minute);
  print('now date ${now}');
  print('current time ${currentTime}');
  if (currentTime.isBefore(now)) {
    // TimeEdit is before current time, return tomorrow's date
    return currentTime.add(Duration(days: 1));
  } else {
    // TimeEdit is now or later, return today's date
    return currentTime;
  }
}

// ScaffoldMessenger for time remain of now Time
void timeMessage(BuildContext context, int hour, int minute, DateTime date) {
  // Combine the provided hour and minute with the provided date
  DateTime providedDateTime =
      DateTime(date.year, date.month, date.day, hour, minute);
  print("provide time ${providedDateTime} the hour $hour the minute $minute");
  // Get the current date and time
  DateTime now = DateTime.now();
  print("now time ${now}");

  // Calculate the difference between the provided date and the current date
  Duration difference = providedDateTime.difference(now);

  // Variables to store the message
  String message;

  // Check if the provided date is before or after the current date
  if (difference.isNegative) {
    // Provided date is in the past
    message = "23 hours and 59 minutes left.";
  } else {
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (days > 0) {
      message = "$days days, $hours hours, and $minutes minutes left.";
    } else if (hours > 0) {
      message = "$hours hours and $minutes minutes left.";
    } else {
      message = "$minutes minutes left.";
    }
  }

  // Show a Snackbar with the calculated time difference
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white), // White text color
      ),
      backgroundColor: Color.fromARGB(255, 74, 19, 85),
// Purple background color
    ),
  );
}
