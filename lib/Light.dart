import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import 'package:tnt_bomb/Connection/connection.dart';
import 'package:tnt_bomb/classes/LightTimeSideClass.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';

class LightSetting extends StatefulWidget {
  const LightSetting({super.key});

  @override
  State<LightSetting> createState() => _LightSettingState();
}

class _LightSettingState extends State<LightSetting> {
  int x = 1; // Variable to store the value of "x"
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(AppPreferences.lightTimeSet);
    if (AppPreferences.lightTimeSet.isNotEmpty) {
      String lightTimeSet = AppPreferences.lightTimeSet;
      final times = lightTimeSet.split('_');
      startTime = stringToTimeOfDay(times[0]);
      endTime = stringToTimeOfDay(times[1]);
    }
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
    var _pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (_pickedTime != null) {
      onTimePicked(_pickedTime);
    }
  }

  Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
      Function(TimeOfDay) onTimePicked) {
    return AnimationButton(
      NeonChild: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neon(
            glowing: false,
            text: '$title',
            color: Colors.purple,
            fontSize: 20,
            font: NeonFont.Monoton,
          ),
          Text(
            ' _(${currentTime.format(context)})',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      ),
      function: () {
        setState(() {
          // x = 2; // Update x value to 2 when the button is pressed
          selectedTime(context, ifPickedTime, currentTime, onTimePicked);

          // AppPreferences.LightSet = 3;
        });
        connectUrls();
      },
    );
  }

  List<String> colorsName = [
    'mix_1',
    'mix_2',
    'mix_3',
    'red',
    'green',
    'blue',
    'purple',
    'pink',
    'yellow',
    'orange',
    'white'
  ];
  List<Color> colorsColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.yellow,
    Colors.orange,
    Colors.white
  ];
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(12),
                        child: Transform.scale(
                          scale: 1.8,
                          child: Switch(
                            onChanged: (bool value) {
                              print(value);
                              setState(() {
                                if (AppPreferences.LightSet == 0) {
                                  AppPreferences.LightSet = 1;
                                } else {
                                  AppPreferences.LightSet = 0;
                                  print('1');
                                }
                                connectUrls();
                              });
                            },
                            value: AppPreferences.LightSet == 0 ? false : true,
                            activeColor: Colors.blue,
                            focusColor: Colors.grey,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb_outline_sharp,
                                color: AppPreferences.LightSet == 0
                                    ? Colors.grey
                                    : Colors.lightBlue,
                                size: 39,
                              ),
                              Row(
                                children: [
                                  Neon(
                                    glowing: false,
                                    text: 'lamp',
                                    color: AppPreferences.LightSet == 1
                                        ? Colors.purple
                                        : Colors.grey,
                                    fontSize: 25,
                                    font: NeonFont.Monoton,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          ' _${AppPreferences.LightSet == 0 ? "off" : AppPreferences.LightSet == 1 ? "on" : AppPreferences.LightSet == 2 ? "buzzer" : AppPreferences.LightSet == 3 ? "midnight" : "off"} ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppPreferences.LightSet == 0
                                  ? Colors.grey
                                  : Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimePick("Start", true, startTime, (x) {
                      setState(() {
                        startTime = x;
                        // print("The picked time is: ${startTime}_${endTime}");

                        print("start ${startTime}_${endTime}");
                      });
                      saveTimeOfDay(startTime, endTime);
                    }),
                    const SizedBox(height: 10),
                    _buildTimePick("End", true, endTime, (x) {
                      setState(() {
                        endTime = x;
                        // print("The picked time is: ${startTime}_${endTime}");
                        print("start ${startTime}_${endTime}");
                      });
                      saveTimeOfDay(startTime, endTime);
                    }),
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
                    padding: EdgeInsets.all(12),
                    child: Transform.scale(
                      scale: 1.8,
                      child: Switch(
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            if (AppPreferences.LightSet == 0) {
                              AppPreferences.LightSet = 1;
                            } else {
                              AppPreferences.LightSet = 0;
                              print('1');
                            }
                            connectUrls();
                          });
                        },
                        value: AppPreferences.LightSet == 0 ? false : true,
                        activeColor: Colors.blue,
                        focusColor: Colors.grey,
                      ),
                    )),
                Container(
                  height: 76,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colorsName.length,
                    itemBuilder: (BuildContext, index) {
                      return AnimationColorButton(
                          NeonChild: AppPreferences.lightTimeColorSet ==
                                  colorsName[index]
                              ? Icon(
                                  Icons.check_circle_outline_sharp,
                                  color: Colors.white,
                                  size: 40,
                                )
                              :

                              // Container(),
                              Neon(
                                  glowing: true,
                                  text: '${colorsName[index]}',
                                  color: AppPreferences.LightSet == 1
                                      ? Colors.purple
                                      : Colors.grey,
                                  fontSize: 10,
                                  font: NeonFont.Beon,
                                  // flickeringText: true,
                                ),
                          function: () {
                            setState(() {
                              AppPreferences.lightTimeColorSet =
                                  colorsName[index];
                            });
                            connectUrls();
                          },
                          buttonColor: colorsColor[index]);
                    },
                  ),
                ),
                _buildTimePick("Start", true, startTime, (x) {
                  setState(() {
                    startTime = x;
                    print("start ${startTime}_${endTime}");
                    saveTimeOfDay(startTime, endTime);

                    // AppPreferences.lightTimeSet =
                  });
                }),
                const SizedBox(height: 10),
                _buildTimePick("End", true, endTime, (x) {
                  setState(() {
                    endTime = x;
                    print("start ${startTime}_${endTime}");
                    saveTimeOfDay(startTime, endTime);
                  });
                }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lightbulb_outline_sharp,
                        color: AppPreferences.LightSet == 0
                            ? Colors.grey
                            : Colors.lightBlue,
                        size: 39,
                      ),
                      Row(
                        children: [
                          Neon(
                            glowing: false,
                            text: 'lamp',
                            color: AppPreferences.LightSet == 1
                                ? Colors.purple
                                : Colors.grey,
                            fontSize: 25,
                            font: NeonFont.Monoton,
                          ),
                          Text(
                            ' _${AppPreferences.LightSet == 0 ? "off" : AppPreferences.LightSet == 1 ? "on" : "on"} ',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppPreferences.LightSet == 0
                                    ? Colors.grey
                                    : Colors.blue),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class AnimationButton extends StatelessWidget {
  const AnimationButton({
    super.key,
    required this.NeonChild,
    required this.function,
  });
  final Widget NeonChild;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: AnimatedButton(
        height: 60,
        // width: 60,
        color: AppPreferences.LightSet == 0
            ? Colors.grey
            : Color.fromARGB(192, 18, 91, 216),
        // shape: BoxShape.circle,
        child: NeonChild,
        onPressed: function,
      ),
    );
  }
}

class AnimationColorButton extends StatelessWidget {
  const AnimationColorButton(
      {super.key,
      required this.NeonChild,
      required this.function,
      required this.buttonColor});
  final Widget NeonChild;
  final Function() function;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: AnimatedButton(
        // shape: BoxShape.circle,
        // height: 60,
        width: 60,
        color: buttonColor,

        // shape: BoxShape.circle,
        child: NeonChild,
        onPressed: function,
      ),
    );
  }
}
