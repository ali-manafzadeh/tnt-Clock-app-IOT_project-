import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tnt_bomb/ClockPainter.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key? key, required this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer? timer;

  @override
  void initState() {
    this.timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}
