import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class GridCall {
  static String Hero_file_text = 'file_text';
  static String Hero_video_text = 'video_text';
  static String Hero_music_text = 'music_text';
  static String Hero_docs_text = 'docs_text';
  static String Hero_image_text = 'image_text';

  static String Hero_file_list = 'file_list';
  static String Hero_video_list = 'video_list';
  static String Hero_music_list = 'music_list';
  static String Hero_docs_list = 'docs_list';
  static String Hero_image_list = 'image_list';
  // ThemeData themeData = ThemeData();
  ThemeData themeData = ThemeData();

  static Widget customTextField({
    required TextEditingController controller,
    void Function(String)? onChanged,
    void Function()? onTap,
  }) {
    return TextField(
      controller: controller,
      onTap: onTap,
      style: TextStyle(
        color: Colors.grey[600],
      ),
      minLines: 1,
      // maxLines: 10,
      textAlignVertical: TextAlignVertical.center,
      // keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(2),
          ),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
        contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 0),
        filled: true,
        fillColor: Color(0xFFFFFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(2),
          ),
          borderSide: BorderSide(color: Colors.green, width: 1),
        ),
        hintText: 'put the Link ...',
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 131, 131, 131),
          fontSize: 14,
        ),
      ),
    );
  }
}

// In your widget class, you can use this GridCall.customTextField() like this:

// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App'),
//       ),
//       body: Center(
//         child: GridCall.customTextField(),
//       ),
//     );
//   }
// }
