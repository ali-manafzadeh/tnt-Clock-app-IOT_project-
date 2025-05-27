import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:tnt_bomb/mainExample.dart';

void main() {
  runApp(MaterialApp(
    home: LightEffect(),
  ));
}

class exampleApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return exampleAppState();
  }
}

class exampleAppState extends State<exampleApp> {
  @override
  Widget build(BuildContext context) {
    List<String> searchedResults = [
      "Flutter",
      "PubDev",
      "Package",
      "Library",
      "Widgets",
      "New"
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: neonAppBar(
            context: context,
            heading: "Example App",
            iconColor: Colors.white,
            backgroundColor: Colors.deepPurple.shade600,
            onTap: () {},
            appBarShadowColor: Colors.purple),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    NeonSearchBar(hint: "Search here..."),
                    const SizedBox(
                      height: 20,
                    ),
                    NeonContainer(
                        spreadColor: Colors.teal.shade200,
                        borderColor: Colors.teal.shade50,
                        containerColor: Colors.black,
                        lightBlurRadius: 20,
                        lightSpreadRadius: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              NeonLeftMsgCard(
                                  lightBlurRadius: 10,
                                  lightSpreadRadius: 5,
                                  msg:
                                      "Hi all, this is brand new library that provides most used widgets in neon and normal effect",
                                  time: "10:45"),
                              const SizedBox(
                                height: 20,
                              ),
                              NeonRightMsgCard(
                                  lightBlurRadius: 20,
                                  lightSpreadRadius: 10,
                                  backgroundColor: Colors.deepPurple,
                                  msg:
                                      "Hi all, this is brand new library that provides most used widgets in neon and normal effect",
                                  time: "10:45"),
                              const SizedBox(
                                height: 20,
                              ),
                              LeftMsgCard(
                                  msg:
                                      "Hi all, this is brand new library that provides most used widgets in neon and normal effect",
                                  time: "10:45"),
                              const SizedBox(
                                height: 20,
                              ),
                              RightMsgCard(
                                  msg:
                                      "Hi all, this is brand new library that provides most used widgets in neon and normal effect",
                                  time: "10:45"),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  ...(searchedResults.map((e) =>
                                      NeonAddItemButton(
                                          data: e,
                                          borderColor:
                                              Colors.deepOrange.shade50,
                                          spreadColor: Colors.deepOrange,
                                          lightSpreadRadius: 3,
                                          lightBlurRadius: 18))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  ...(searchedResults.map((e) =>
                                      NeonAddItemButton(
                                          data: e,
                                          borderColor: Colors.pink.shade50,
                                          spreadColor: Colors.pinkAccent,
                                          lightSpreadRadius: 3,
                                          lightBlurRadius: 18))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  ...(searchedResults.map((e) =>
                                      NeonAddItemButton(
                                          data: e,
                                          borderColor: Colors.blue.shade50,
                                          spreadColor: Colors.blue,
                                          lightSpreadRadius: 3,
                                          lightBlurRadius: 18))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              NeonSearchBar(),
                              const SizedBox(
                                height: 20,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  ...(searchedResults.map((e) =>
                                      NeonAddItemButton(
                                          data: e,
                                          borderColor:
                                              Colors.deepOrange.shade50,
                                          spreadColor: Colors.deepOrange,
                                          lightSpreadRadius: 3,
                                          lightBlurRadius: 18))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: CircumscribingIconButton(
                                    icon: Icons.keyboard_arrow_left_sharp,
                                    onTap: () {},
                                    backgroundColor: Colors.purple),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              NeonPoint(
                                pointSize: 00,
                                pointColor: Colors.red.shade100,
                                spreadColor: Colors.red,
                              ),
                              const SizedBox(
                                height: 86.6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeonPoint(
                                    pointSize: 00,
                                    pointColor: Colors.blue.shade100,
                                    spreadColor: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  NeonPoint(
                                    pointSize: 00,
                                    pointColor: Colors.green.shade100,
                                    spreadColor: Colors.green,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 400,
                              ),
                              NeonLine(
                                spreadColor: Colors.brown,
                                lightSpreadRadius: 30,
                                lightBlurRadius: 90,
                                lineWidth: 400,
                                lineHeight: 0.02,
                                lineColor: Colors.brown.shade100,
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: NeonContainer(
                    spreadColor: Colors.green.shade700,
                    child: CircumscribingIconButton(
                        icon: Icons.arrow_right_alt_sharp,
                        onTap: () {},
                        backgroundColor: Colors.green.shade700),
                    borderRadius: BorderRadius.circular(100),
                    lightBlurRadius: 100,
                    lightSpreadRadius: 50,
                    borderColor: Colors.green.shade100)),
          ],
        ),
      ),
    );
  }
}

class NeonWidet extends StatefulWidget {
  @override
  _NeonWidetState createState() => _NeonWidetState();
}

class _NeonWidetState extends State<NeonWidet> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  ispressed = !ispressed;
                });
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    ispressed
                        ? BoxShadow(
                            color: Colors.blue.withAlpha(225),
                            blurRadius: 45,
                            spreadRadius: 15,
                            offset: Offset(0, 0),
                          )
                        : BoxShadow(),
                  ],
                  gradient: LinearGradient(colors: [
                    Color(0xFFFF1000),
                    Color(0xFF2508FF),
                  ], begin: Alignment.centerRight, end: Alignment.centerLeft),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            SizedBox(
              height: 75,
            ),
            Neon(
              text: 'vijaycreations',
              color: Colors.blue,
              fontSize: 35,
              font: NeonFont.Beon,
              flickeringText: true,
              flickeringLetters: null,
              glowingDuration: new Duration(seconds: 1),
            ),
          ],
        ),
      ),
    );
  }
}
