import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

Widget homePageButton(
    BuildContext context,
    Function() function,
    String text,
    String neonText,
    MaterialColor neonTextColor,
    Color textColor,
    Icon neonIcon) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      // height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(
        //     color: Colors.grey), // Set your desired border color here
      ),
      child: OutlinedButton.icon(
        onPressed: function,
        style: OutlinedButton.styleFrom(
          // padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
        ),
        icon: neonIcon,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Neon(
              glowing: false,
              text: neonText,
              color: neonTextColor,
              fontSize: 24,
              font: NeonFont.Monoton,
              // flickeringText: true,
              flickeringLetters: null,
              flickeringText: true,

              // glowingDuration: new Duration(seconds: 1),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 17, color: textColor),
            )
          ],
        ),
      ),
    ),
  );
}
