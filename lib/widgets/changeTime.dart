import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:neon/neon.dart';
import 'package:tnt_bomb/Connection/connection.dart';
import 'package:tnt_bomb/classes/sideClasses.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/widgets/GridCall.dart';
import 'package:tnt_bomb/widgets/convert.dart';

class changeTime extends StatefulWidget {
  final int keyItem;
  final bool firstTime;

  const changeTime({super.key, required this.keyItem, required this.firstTime});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _changeTimeState createState() => _changeTimeState();
}

class _changeTimeState extends State<changeTime> {
  DateTime _dateTime = DateTime.now();
  TextEditingController _urlController = TextEditingController();
  TextEditingController TimeNameController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        variantDate = false;
      });
    }
  }

  bool? _isEveryDayChecked = false;
  bool variantDate = true;

  DateTime now = DateTime.now();
  late var items;

  int dateInt = 0;
  int hourInt = 0;
  int minuteInt = 0;
  String date = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = DatabaseHandler.readItem(widget.keyItem);
    // TimeNameController.text = items['name'];

    List<String> extractedTime =
        DateTimeFormatter.extractDateTime(items['url']);

    date = extractedTime.isNotEmpty ? extractedTime[0] : "";
    String hour = extractedTime.isNotEmpty ? extractedTime[1] : "";
    String minute = extractedTime.isNotEmpty ? extractedTime[2] : "";

// Convert strings to integers
    // dateInt = date.isNotEmpty ? int.parse(date) : 0;
    hourInt = hour.isNotEmpty ? int.parse(hour) : 0;
    minuteInt = minute.isNotEmpty ? int.parse(minute) : 0;

    print("time is   $hourInt $minuteInt $dateInt");

// String dateString = "2024-04-19";
    if (date != "e") {
      selectedDate = DateTime.parse(date);
      _isEveryDayChecked = false;
    } else {
      _isEveryDayChecked = true;
    }
  }

  DateTime compareTimeEdit(int hour, int minute) {
    if (variantDate == true && selectedDate.day - now.day < 1) {
      // DateTime now = DateTime.now();

      DateTime currentTime =
          DateTime(now.year, now.month, now.day, hour, minute);

      if (currentTime.isBefore(now)) {
        // TimeEdit is before current time, return tomorrow's date
        return selectedDate.add(Duration(days: 1));
      } else {
        // TimeEdit is now or later, return today's date
        return selectedDate;
      }
    } else {
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = new GlobalKey<SelectWeekDaysState>();
    return SafeArea(child: Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check the screen width to determine the layout
          if (constraints.maxWidth > 600) {
            // If screen width is greater than 600
            // Otherwise, if screen width is less than or equal to 600
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 74, 19, 85),
                    Color.fromARGB(255, 21, 8, 103)
                  ],
                ),
              ),
              child: new Column(
                children: <Widget>[
                  //            hourMinute12H(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neon(
                        glowing: false,
                        text: 'TNT',
                        color: Colors.purple,
                        fontSize: 20,
                        font: NeonFont.Monoton,
                        // flickeringText: true,
                        flickeringLetters: null,
                        flickeringText: false,

                        // glowingDuration: new Duration(seconds: 1),
                      ),
                      Container(
                          // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                        'alarm',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                    ],
                  ),

                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TimePickerSpinner(
                                spacing: 40,
                                minutesInterval: 1,
                                time: DateTime(2017, 9, 7, hourInt, minuteInt),
                                // highlightedTextStyle: textst,
                                normalTextStyle: TextStyle(
                                  color: Color.fromARGB(255, 193, 193, 193),
                                  fontSize: 25,
                                ),
                                onTimeChange: (time) {
                                  setState(() {
                                    _dateTime = time;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.only(top: 20),
                                child: new Text(
                                  _dateTime.hour.toString().padLeft(2, '0') +
                                      ':' +
                                      _dateTime.minute
                                          .toString()
                                          .padLeft(2, '0'),
                                  // ':' +
                                  // _dateTime.second.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 52, 27, 95)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(_isEveryDayChecked == true
                                        ? "every Day"
                                        : "${compareTimeEdit(_dateTime.hour, _dateTime.minute).toLocal()}"
                                            .split(' ')[0])),
                                IconButton(
                                    onPressed: () => _selectDate(context),
                                    icon: const Icon(Icons.calendar_month)),
                              ],
                            ),
                            CheckboxListTile(
                              contentPadding:
                                  EdgeInsets.zero, // Set contentPadding to zero
                              controlAffinity: ListTileControlAffinity
                                  .leading, // Put checkbox before the title

                              title: Text('Every Day'),
                              value: _isEveryDayChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isEveryDayChecked =
                                      value ?? false; // Handle null case
                                });
                              },
                            ),
                            Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(16),
                                      //   border: Border.all(
                                      //       color: Colors
                                      //           .green), // Set your desired border color here
                                      // ),
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          String formattedString =
                                              DateTimeFormatter.formatDateTime(
                                                  _dateTime.hour
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  _dateTime.minute
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  _isEveryDayChecked == true
                                                      ? "e"
                                                      : "${selectedDate.toLocal()}"
                                                          .split(' ')[0]);
                                          DatabaseHandler.updateItem(
                                              widget.keyItem, {
                                            "key": widget.keyItem,
                                            "url": formattedString,
                                            "mode": 'on',
                                            "format": 'music',
                                          });
                                          connectUrls();
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        style: OutlinedButton.styleFrom(
                                          // padding: const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        icon: Icon(CupertinoIcons.clock,
                                            color: Colors.amber),
                                        label: Text(
                                          " Save  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: Colors
                                                    .amber, // Set your desired text color here
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(16),
                                      //   border: Border.all(
                                      //       color: Colors
                                      //           .green), // Set your desired border color here
                                      // ),
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          String formattedString =
                                              DateTimeFormatter.formatDateTime(
                                                  _dateTime.hour
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  _dateTime.minute
                                                      .toString()
                                                      .padLeft(2, '0'),
                                                  _isEveryDayChecked == true
                                                      ? "e"
                                                      : "${selectedDate.toLocal()}"
                                                          .split(' ')[0]);
                                          DatabaseHandler.updateItem(
                                              widget.keyItem, {
                                            "key": widget.keyItem,
                                            "url": formattedString,
                                            "mode": "on",
                                            "format": 'music',
                                          });
                                          connectUrls();
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        style: OutlinedButton.styleFrom(
                                          // padding: const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        icon: Icon(CupertinoIcons.nosign,
                                            color: Colors.amber),
                                        label: Text(
                                          "cancel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: Colors
                                                    .amber, // Set your desired text color here
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ))
                      ],
                    ),
                  )),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 74, 19, 85),
                    Color.fromARGB(255, 21, 8, 103)
                  ],
                ),
              ),
              child: new Column(
                children: <Widget>[
                  //            hourMinute12H(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neon(
                        glowing: false,
                        text: 'TNT',
                        color: Colors.purple,
                        fontSize: 50,
                        font: NeonFont.Monoton,
                        // flickeringText: true,
                        flickeringLetters: null,
                        flickeringText: false,

                        // glowingDuration: new Duration(seconds: 1),
                      ),
                      Container(
                          // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                        'alarm',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                      // Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      //     child: GridCall.customTextField(
                      //         controller: TimeNameController)),
                    ],
                  ),

                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(_isEveryDayChecked == true
                                        ? "every Day"
                                        : "${compareTimeEdit(_dateTime.hour, _dateTime.minute).toLocal()}"
                                            .split(' ')[0])),
                                IconButton(
                                    onPressed: () => _selectDate(context),
                                    icon: const Icon(Icons.calendar_month)),
                              ],
                            ),
                            CheckboxListTile(
                              contentPadding:
                                  EdgeInsets.zero, // Set contentPadding to zero
                              controlAffinity: ListTileControlAffinity
                                  .leading, // Put checkbox before the title

                              title: Text('Every Day'),
                              value: _isEveryDayChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isEveryDayChecked =
                                      value ?? false; // Handle null case
                                });
                              },
                            ),
                          ],
                        ),
                        TimePickerSpinner(
                          spacing: 40,
                          minutesInterval: 1,
                          time: DateTime(2017, 9, 7, hourInt, minuteInt),
                          // highlightedTextStyle: textst,
                          normalTextStyle: TextStyle(
                            color: Color.fromARGB(255, 193, 193, 193),
                            fontSize: 25,
                          ),
                          onTimeChange: (time) {
                            setState(() {
                              _dateTime = time;
                            });
                          },
                        ),
                        new Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: new Text(
                            _dateTime.hour.toString().padLeft(2, '0') +
                                ':' +
                                _dateTime.minute.toString().padLeft(2, '0'),
                            // ':' +
                            // _dateTime.second.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 52, 27, 95)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(16),
                                //   border: Border.all(
                                //       color: Colors
                                //           .green), // Set your desired border color here
                                // ),
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    timeMessage(context, _dateTime.hour,
                                        _dateTime.minute, selectedDate);
                                    String formattedString =
                                        DateTimeFormatter.formatDateTime(
                                            _dateTime.hour
                                                .toString()
                                                .padLeft(2, '0'),
                                            _dateTime.minute
                                                .toString()
                                                .padLeft(2, '0'),
                                            _isEveryDayChecked == true
                                                ? "e"
                                                : "${selectedDate.toLocal()}"
                                                    .split(' ')[0]);
                                    DatabaseHandler.updateItem(widget.keyItem, {
                                      "key": widget.keyItem,
                                      "url": formattedString,
                                      "mode": 'on',
                                      "format": 'music',
                                    });
                                    connectUrls();
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  style: OutlinedButton.styleFrom(
                                    // padding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  icon: Icon(CupertinoIcons.clock,
                                      color: Colors.amber),
                                  label: Text(
                                    " Save  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors
                                              .amber, // Set your desired text color here
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(16),
                                //   border: Border.all(
                                //       color: Colors
                                //           .green), // Set your desired border color here
                                // ),
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    String formattedString =
                                        DateTimeFormatter.formatDateTime(
                                            _dateTime.hour
                                                .toString()
                                                .padLeft(2, '0'),
                                            _dateTime.minute
                                                .toString()
                                                .padLeft(2, '0'),
                                            _isEveryDayChecked == true
                                                ? "e"
                                                : "${selectedDate.toLocal()}"
                                                    .split(' ')[0]);
                                    DatabaseHandler.updateItem(widget.keyItem, {
                                      "key": widget.keyItem,
                                      "url": formattedString,
                                      "mode": "on",
                                      "format": 'music',
                                    });
                                    connectUrls();
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  style: OutlinedButton.styleFrom(
                                    // padding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  icon: Icon(CupertinoIcons.nosign,
                                      color: Colors.amber),
                                  label: Text(
                                    "cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors
                                              .amber, // Set your desired text color here
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            );
          }
        },
      ),
    ));
  }

  /// SAMPLE
  Widget hourMinute12H() {
    return new TimePickerSpinner(
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinuteSecond() {
    return new TimePickerSpinner(
      isShowSeconds: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  // Widget hourMinute15Interval() {
  //   return new TimePickerSpinner(

  //      spacing: 40,
  //     minutesInterval: 1,
  //     // highlightedTextStyle: textst,
  //     normalTextStyle: TextStyle(
  //       color: Color.fromARGB(255, 193, 193, 193),
  //       fontSize: 25,
  //     ),
  //     onTimeChange: (time) {
  //       setState(() {
  //         _dateTime = time;
  //       });
  //     },
  //   );
  // }

  Widget hourMinute12HCustomStyle() {
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      minutesInterval: 15,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
