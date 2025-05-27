import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segment_display/segment_display.dart';
import 'package:tnt_bomb/Connection/connection.dart';

class ChangeTime extends StatefulWidget {
  const ChangeTime({Key? key}) : super(key: key);

  @override
  State<ChangeTime> createState() => _ChangeTimeState();
}

class _ChangeTimeState extends State<ChangeTime> {
  late DateTime currentTime;
  var formattedTime = "";
  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();
    formattedTime = DateFormat('HH:mm').format(currentTime);
  }

  void incrementHour() {
    setState(() {
      currentTime = currentTime.add(Duration(hours: 1));
      formattedTime = DateFormat('HH:mm').format(currentTime);
      connectUrls(dateTime: currentTime);
    });
  }

  void incrementMinute() {
    setState(() {
      currentTime = currentTime.add(Duration(minutes: 1));
      formattedTime = DateFormat('HH:mm').format(currentTime);
      connectUrls(dateTime: currentTime);

      print('x');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check the screen width to determine the layout
        if (constraints.maxWidth > 600) {
          // If screen width is greater than 600
          // Otherwise, if screen width is less than or equal to 600
          return Container(
            // alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquareButton('hour', () {
                      incrementHour();
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SevenSegmentDisplay(
                        value: formattedTime,
                        size: 12.0,
                        segmentStyle: HexSegmentStyle(
                          enabledColor: Color.fromARGB(255, 255, 0, 13),
                          disabledColor:
                              const Color(0xFF00FF00).withOpacity(0.15),
                          segmentBaseSize: const Size(1.0, 2.0),
                        ),
                      ),
                    ),
                    SquareButton('minute', incrementMinute),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Otherwise, if screen width is less than or equal to 600
          return Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SevenSegmentDisplay(
                    value: formattedTime,
                    size: 12.0,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Color.fromARGB(255, 255, 0, 13),
                      disabledColor: const Color(0xFF00FF00).withOpacity(0.15),
                      segmentBaseSize: const Size(1.0, 2.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquareButton('hour', () {
                      incrementHour();
                      print('Hour');
                    }),
                    SquareButton('minute', incrementMinute),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class SquareButton extends StatelessWidget {
  final String text;
  final Function() function;

  SquareButton(this.text, this.function);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 127, 127, 127),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 20,
                child: AnimatedButton(
                  height: 60,
                  width: 60,
                  color: const Color.fromARGB(255, 31, 30, 30),
                  shape: BoxShape.circle,
                  child: Container(
                      // width: 12,
                      ),
                  onPressed: function,
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Change this color as needed
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Change this color as needed
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Change this color as needed
                  ),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Change this color as needed
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
