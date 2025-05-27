import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neon/neon.dart';
import 'package:o3d/o3d.dart';
import 'package:segment_display/segment_display.dart';
import 'package:tnt_bomb/AlarmScreen.dart';
import 'package:tnt_bomb/Buzzer.dart';
import 'package:tnt_bomb/ClockPainter.dart';
import 'package:tnt_bomb/Connection/connection.dart';
import 'package:tnt_bomb/Light.dart';
import 'package:tnt_bomb/changeTime.dart';
import 'package:tnt_bomb/classes/sideClasses.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/widgets/homePageButtons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController mainPageController = PageController();
  O3DController o3dController = O3DController();
  int page = 0;
  int page2change = 0;
  PageController textsPageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (DatabaseHandler.refreshItems().isNotEmpty) {
      ChangeAllformatedString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);

    return PopScope(
      canPop: page2change == 0,
      onPopInvoked: (didpop) {
        setState(() {
          page2change = 0;
          if (page2change == 0) {
            o3dController.cameraOrbit(0, 70, 180);
            o3dController.cameraTarget(0, -4, -20);
          }
        });
      },
      child: Scaffold(
        backgroundColor:
            Color(0xff2D2F41), // Set your desired app bar background color
        // backgroundColor:
        //     Color(0xff2D2F41), // Set your desired app bar background color
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  // checkUrlValidity();
                  // if (DatabaseHandler.refreshFolderItems().isNotEmpty) {
                  // ChangeAllformatedString();
                  // }

                  checkUrlValidity();
                },
                icon: Icon(Icons.refresh))
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Connected',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor:
              Color(0xff2D2F41), // Set your desired app bar background color
          elevation: 0, // Set elevation to 0 to remove the shadow
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(1), // Set the height of the bottom border
            child: Container(
              color: Colors.white, // Set the color of the bottom border
              height: 1, // Set the height of the bottom border
              child: Divider(
                color: Colors.grey, // Set the color of the divider line
                thickness: 1, // Set the thickness of the divider line
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 240),
                // alignment: Alignment.bottomCenter,
                child: O3D(
                  src: 'assets/disney_style_character.glb',
                  controller: o3dController,
                  ar: false,
                  autoPlay: true,
                  autoRotate: false,
                  cameraControls: false,
                  cameraTarget: CameraTarget(-.25, 4, 6),
                  cameraOrbit: CameraOrbit(0, 90, 1),
                ),
              ),
              PageView(
                // allowImplicitScrolling: false,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling

                controller: mainPageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [Container(), Container()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(),
                ],
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.all(12),
                child: PageView(
                  controller: textsPageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Neon(
                          glowing: false,
                          text: 'TNT Clock',
                          color: Colors.red,
                          fontSize: 40,
                          font: NeonFont.Monoton,
                          // flickeringText: true,
                          flickeringLetters: null,
                          flickeringText: false,
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            // Check the screen width to determine the layout
                            if (constraints.maxWidth > 600) {
                              // If screen width is greater than 600
                              // Otherwise, if screen width is less than or equal to 600
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   formattedTime,
                                            //   style: TextStyle(
                                            //       color: Colors.green, fontSize: 64),
                                            // ),
                                            SevenSegmentDisplay(
                                              value: formattedTime,
                                              size: 12.0,
                                              segmentStyle: HexSegmentStyle(
                                                enabledColor: Color.fromARGB(
                                                    255, 255, 0, 13),
                                                disabledColor: Color.fromARGB(
                                                        255, 255, 0, 0)
                                                    .withOpacity(0.15),
                                                segmentBaseSize:
                                                    const Size(1.0, 2.0),
                                              ),
                                            ),

                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 189, 0, 0),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                Icons.alarm,
                                                color: Colors.green,
                                                size: 33,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Neon(
                                                  glowing: true,
                                                  text:
                                                      '${DatabaseHandler.refreshItems().length}-ALARM',
                                                  color: Colors.green,
                                                  fontSize: 14,
                                                  font: NeonFont.Beon,
                                                  // flickeringText: true,
                                                  flickeringLetters: null,
                                                  flickeringText: false,
                                                  // glowingDuration: new Duration(seconds: 1),
                                                ),
                                                Text(
                                                  "set",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CustomPaint(
                                              painter: ClockPainter(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                Icons.online_prediction,
                                                color: Colors.purple,
                                                size: 33,
                                              ),
                                            ),
                                            Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Neon(
                                                  glowing: false,
                                                  text: 'TIME',
                                                  color: Colors.purple,
                                                  fontSize: 14,
                                                  font: NeonFont.Beon,
                                                  // flickeringText: true,
                                                  flickeringLetters: null,
                                                  flickeringText: false,
                                                  // glowingDuration: new Duration(seconds: 1),
                                                ),
                                                Text(
                                                  "ONLINE",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(Icons.cloud_outlined,
                                                  size: 33,
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                            Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Neon(
                                                  glowing: false,
                                                  text: '4°C',
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  font: NeonFont.Beon,
                                                  // flickeringText: true,
                                                  flickeringLetters: null,
                                                  flickeringText: false,
                                                  // glowingDuration: new Duration(seconds: 1),
                                                ),
                                                Text(
                                                  "TEMP",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.alarm,
                                              color: Colors.green,
                                              size: 33,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Neon(
                                                glowing: true,
                                                text:
                                                    '${DatabaseHandler.refreshItems().length}-ALARM',
                                                color: Colors.green,
                                                fontSize: 14,
                                                font: NeonFont.Beon,
                                                // flickeringText: true,
                                                flickeringLetters: null,
                                                flickeringText: false,
                                                // glowingDuration: new Duration(seconds: 1),
                                              ),
                                              Text(
                                                "set",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          CustomPaint(
                                            painter: ClockPainter(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.online_prediction,
                                              color: Colors.purple,
                                              size: 33,
                                            ),
                                          ),
                                          Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Neon(
                                                glowing: false,
                                                text: 'TIME',
                                                color: Colors.purple,
                                                fontSize: 14,
                                                font: NeonFont.Beon,
                                                // flickeringText: true,
                                                flickeringLetters: null,
                                                flickeringText: false,
                                                // glowingDuration: new Duration(seconds: 1),
                                              ),
                                              Text(
                                                "ONLINE",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(Icons.cloud_outlined,
                                                size: 33,
                                                color: Colors.lightBlueAccent),
                                          ),
                                          Column(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Neon(
                                                glowing: false,
                                                text: '4°C',
                                                color: Colors.blue,
                                                fontSize: 16,
                                                font: NeonFont.Beon,
                                                // flickeringText: true,
                                                flickeringLetters: null,
                                                flickeringText: false,
                                                // glowingDuration: new Duration(seconds: 1),
                                              ),
                                              Text(
                                                "TEMP",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   formattedTime,
                                          //   style: TextStyle(
                                          //       color: Colors.green, fontSize: 64),
                                          // ),
                                          SevenSegmentDisplay(
                                            value: formattedTime,
                                            size: 12.0,
                                            segmentStyle: HexSegmentStyle(
                                              enabledColor: Color.fromARGB(
                                                  255, 255, 0, 13),
                                              disabledColor:
                                                  Color.fromARGB(255, 255, 0, 0)
                                                      .withOpacity(0.15),
                                              segmentBaseSize:
                                                  const Size(1.0, 2.0),
                                            ),
                                          ),

                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 189, 0, 0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        )
                      ],
                    ),
                    page2change == 0
                        ? LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              // Check the screen width to determine the layout
                              if (constraints.maxWidth > 600) {
                                // If screen width is greater than 600
                                // Otherwise, if screen width is less than or equal to 600
                                return Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    homePageButton(context, () {
                                      {
                                        setState(() {
                                          page2change = 1;
                                          print('$page2change');
                                        });
                                        o3dController.cameraOrbit(0, 70, 180);
                                        o3dController.cameraTarget(3, -11, -34);
                                      }
                                    },
                                        " Time Handy",
                                        "change",
                                        Colors.green,
                                        Colors.blue,
                                        Icon(
                                          CupertinoIcons.clock,
                                          color: Colors.green,
                                        )),
                                    Row(
                                      children: [
                                        homePageButton(
                                          context,
                                          () {
                                            setState(() {
                                              page2change = 2;
                                            });
                                            o3dController.cameraOrbit(
                                                0, 70, 180);
                                            o3dController.cameraTarget(
                                                -3, -11, -34);
                                          },
                                          "",
                                          "LED",
                                          Colors.blue,
                                          Colors.black,
                                          Icon(Icons.lightbulb_outline_sharp,
                                              color: Colors.blue),
                                        ),
                                        homePageButton(
                                          context,
                                          () {
                                            setState(() {
                                              page2change = 3;
                                            });
                                            o3dController.cameraOrbit(
                                                0, 70, 180);
                                            o3dController.cameraTarget(
                                                0, -11, -34);
                                          },
                                          "",
                                          "Buzzer",
                                          Colors.red,
                                          Colors.black,
                                          Icon(CupertinoIcons.music_note,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        homePageButton(
                                          context,
                                          () {
                                            connectUrls();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text('the light changed'),
                                              ),
                                            );
                                          },
                                          " Set",
                                          'ONLINE',
                                          Colors.amber,
                                          Colors.blue,
                                          Icon(Icons.online_prediction,
                                              color: Colors.amber),
                                        ),
                                        homePageButton(
                                          context,
                                          () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlarmScreen()));
                                          },
                                          "",
                                          'ALARM',
                                          Colors.purple,
                                          Colors.blue,
                                          Icon(Icons.alarm,
                                              color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                // Otherwise, if screen width is less than or equal to 600
                                return Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    homePageButton(context, () {
                                      {
                                        setState(() {
                                          page2change = 1;
                                          print('$page2change');
                                        });
                                        o3dController.cameraOrbit(0, 70, 180);
                                        o3dController.cameraTarget(3, -11, -34);
                                      }
                                    },
                                        " Time Handy",
                                        "change",
                                        Colors.green,
                                        Colors.blue,
                                        Icon(
                                          CupertinoIcons.clock,
                                          color: Colors.green,
                                        )),
                                    homePageButton(
                                      context,
                                      () {
                                        setState(() {
                                          page2change = 2;
                                        });
                                        o3dController.cameraOrbit(0, 67.5, 180);
                                        o3dController.cameraTarget(
                                            -3, -11, -34);
                                      },
                                      "",
                                      "LED",
                                      Colors.blue,
                                      Colors.black,
                                      Icon(Icons.lightbulb_outline_sharp,
                                          color: Colors.blue),
                                    ),
                                    // homePageButton(
                                    //   context,
                                    //   () {
                                    //     setState(() {
                                    //       page2change = 3;
                                    //     });
                                    //     o3dController.cameraOrbit(0, 70, 180);
                                    //     o3dController.cameraTarget(0, -11, -34);
                                    //   },
                                    //   "",
                                    //   "Buzzer",
                                    //   Colors.red,
                                    //   Colors.black,
                                    //   Icon(CupertinoIcons.music_note,
                                    //       color: Colors.red),
                                    // ),
                                    homePageButton(
                                      context,
                                      () {
                                        connectUrls();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Neon(
                                              glowing: true,

                                              text: 'Time is Online now',
                                              color: Colors.yellow,
                                              fontSize: 20,
                                              font: NeonFont.Beon,
                                              // flickeringText: true,
                                              flickeringLetters: null,
                                              flickeringText: true,
                                            ),
                                          ),
                                        );
                                      },
                                      " Set",
                                      'ONLINE',
                                      Colors.amber,
                                      Colors.blue,
                                      Icon(Icons.online_prediction,
                                          color: Colors.amber),
                                    ),
                                    homePageButton(
                                      context,
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AlarmScreen()));
                                      },
                                      "",
                                      'ALARM',
                                      Colors.purple,
                                      Colors.blue,
                                      Icon(Icons.alarm, color: Colors.purple),
                                    ),
                                    Container(
                                      height: 220,
                                    )
                                  ],
                                );
                              }
                            },
                          )
                        : page2change == 1
                            ? Container(
                                child: ChangeTime(),
                              )
                            : page2change == 2
                                ? LightSetting()
                                : page2change == 3
                                    ? Buzzer()
                                    : Container(),
                    Container()
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: page,
            onTap: (page) {
              mainPageController.animateToPage(page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              textsPageController.animateToPage(page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);

              if (page == 0) {
                o3dController.cameraTarget(-.25, 4, 1);
                o3dController.cameraOrbit(0, 90, 30);
                setState(() {
                  page2change = 0;
                });
              } else if (page == 1) {
                // o3dController.cameraTarget(0, 1.8, 0);
                // o3dController.cameraOrbit(-180, 90, 1);
                page2change = 0;

                o3dController.cameraOrbit(0, 70, 180);
                o3dController.cameraTarget(0, -4, -20);
                // o3dController
              }

              //  else if (page == 2) {
              //   o3dController.cameraTarget(0, 3, 0);
              //   o3dController.cameraOrbit(0, 90, -3);
              // }

              setState(() {
                this.page = page;
              });
            },
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'home'),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.person_outline), label: 'home'),
            ]),
      ),
    );
  }
}
