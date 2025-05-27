import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';

class Buzzer extends StatefulWidget {
  const Buzzer({super.key});

  @override
  State<Buzzer> createState() => _BuzzerState();
}

class _BuzzerState extends State<Buzzer> {
  int x = 1; // Variable to store the value of "x"

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
                    AnimationButton(
                      NeonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Neon(
                            glowing: false,
                            text: 'SOUND',
                            color: Colors.red,
                            fontSize: 20,
                            font: NeonFont.Beon,
                          ),
                          Text(
                            ' _3 ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.yellow),
                          )
                        ],
                      ),
                      function: () {
                        setState(() {
                          // x = 3; // Update x value to 3 when the button is pressed
                          AppPreferences.BuzzerSet = 3;
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.yellow,
                            size: 39,
                          ),
                          Row(
                            children: [
                              Neon(
                                glowing: false,
                                text: 'Sound',
                                color: Colors.red,
                                fontSize: 25,
                                font: NeonFont.Monoton,
                              ),
                              Text(
                                ' _${AppPreferences.BuzzerSet} ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimationButton(
                      NeonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Neon(
                            glowing: false,
                            text: 'SOUND',
                            color: Colors.red,
                            fontSize: 20,
                            font: NeonFont.Beon,
                          ),
                          Text(
                            ' _1 ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.yellow),
                          )
                        ],
                      ),
                      function: () {
                        setState(() {
                          // x = 1; // Update x value to 1 when the button is pressed
                          AppPreferences.BuzzerSet = 1;
                        });
                      },
                    ),
                    AnimationButton(
                      NeonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Neon(
                            glowing: false,
                            text: 'SOUND',
                            color: Colors.red,
                            fontSize: 20,
                            font: NeonFont.Beon,
                          ),
                          Text(
                            ' _2 ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.yellow),
                          )
                        ],
                      ),
                      function: () {
                        setState(() {
                          // x = 2; // Update x value to 2 when the button is pressed
                          AppPreferences.BuzzerSet = 2;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                AnimationButton(
                  NeonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neon(
                        glowing: false,
                        text: 'SOUND',
                        color: Colors.red,
                        fontSize: 20,
                        font: NeonFont.Beon,
                      ),
                      Text(
                        ' _1 ',
                        style: TextStyle(fontSize: 20, color: Colors.yellow),
                      )
                    ],
                  ),
                  function: () {
                    setState(() {
                      // x = 1; // Update x value to 1 when the button is pressed
                      AppPreferences.BuzzerSet = 1;
                    });
                  },
                ),
                AnimationButton(
                  NeonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neon(
                        glowing: false,
                        text: 'SOUND',
                        color: Colors.red,
                        fontSize: 20,
                        font: NeonFont.Beon,
                      ),
                      Text(
                        ' _2 ',
                        style: TextStyle(fontSize: 20, color: Colors.yellow),
                      )
                    ],
                  ),
                  function: () {
                    setState(() {
                      // x = 2; // Update x value to 2 when the button is pressed
                      AppPreferences.BuzzerSet = 2;
                    });
                  },
                ),
                AnimationButton(
                  NeonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neon(
                        glowing: false,
                        text: 'SOUND',
                        color: Colors.red,
                        fontSize: 20,
                        font: NeonFont.Beon,
                      ),
                      Text(
                        ' _3 ',
                        style: TextStyle(fontSize: 20, color: Colors.yellow),
                      )
                    ],
                  ),
                  function: () {
                    setState(() {
                      // x = 3; // Update x value to 3 when the button is pressed
                      AppPreferences.BuzzerSet = 3;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.yellow,
                        size: 39,
                      ),
                      Row(
                        children: [
                          Neon(
                            glowing: false,
                            text: 'Sound',
                            color: Colors.red,
                            fontSize: 25,
                            font: NeonFont.Monoton,
                          ),
                          Text(
                            ' _${AppPreferences.BuzzerSet} ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.yellow),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class AnimationButton extends StatelessWidget {
  const AnimationButton(
      {super.key, required this.NeonChild, required this.function});
  final Widget NeonChild;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: AnimatedButton(
        height: 60,
        // width: 60,
        color: Colors.deepOrange,
        // shape: BoxShape.circle,
        child: NeonChild,
        onPressed: function,
      ),
    );
  }
}
