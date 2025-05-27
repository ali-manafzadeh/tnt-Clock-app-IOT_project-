import 'dart:convert';
import 'dart:io';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';
import 'package:tnt_bomb/widgets/GridCall.dart';

class AddLinkDialog extends StatefulWidget {
  // const AddLinkDialog({Key key}) : super(key: key);

  @override
  State<AddLinkDialog> createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<AddLinkDialog> {
  // Create a TextEditingController
  TextEditingController _urlController = TextEditingController();
  TextEditingController _urlNameController = TextEditingController();
  List<dynamic> data = [];
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(builder: (context, constraints) {
          if (orientation == Orientation.landscape &&
              constraints.maxWidth > 600) {
            return AlertDialog(
              title: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'Add Link',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: GridCall.customTextField(
                            controller: _urlController),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors
                                  .deepPurple; // You can set different colors based on states if needed
                            }),

                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 10)), // Add padding here
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'add link',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return AlertDialog(
              backgroundColor: AppPreferences.isModeDark == true
                  ? Colors.black
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: AppPreferences.isModeDark == true
                        ? Colors.deepPurple
                        : Colors.transparent,
                    width: 2.0),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_time.hour}:${_time.minute}:${_time.second} ${_time.period.name}"
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.clock,
                          size: 38, color: Colors.deepPurple))
                ],
              ),
              content: SingleChildScrollView(
                child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors
                                  .deepPurple; // You can set different colors based on states if needed
                            }),

                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 10)), // Add padding here
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            // DatabaseHandler.createItem({
                            //   "url": '${_urlController.text}',
                            //   "name": '${_urlNameController.text}',
                            //   "format": 'music',
                            // });
                            Navigator.of(context).push(
                              showPicker(
                                showSecondSelector: true,
                                context: context,
                                value: _time, disableAutoFocusToNextInput: true,

                                // iosStylePicker: true,
                                width: MediaQuery.of(context).size.width,
                                onChange: onTimeChanged,
                                minuteInterval: TimePickerInterval.FIVE,

                                // Optional onChange to receive value as DateTime
                                onChangeDateTime: (DateTime dateTime) {
                                  // print(dateTime);
                                  debugPrint("[debug datetime]:  $dateTime");
                                },
                              ),
                            );
                          },
                          child: Text(
                            'SET TIME',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // Container(
                        //     //     padding: EdgeInsets.symmetric(vertical: 5),
                        //     //     alignment: Alignment.topLeft,
                        //     //     child: Text("Put the link down Here ")),
                        //     IconButton(
                        //         onPressed: () async {
                        //           setState(() {
                        //             // urlParser
                        //             //     .pasteClipboard()
                        //             //     .then((clipboardText) {
                        //             //   _urlController.text = clipboardText ?? '';
                        //             //   _urlNameController.text = urlParser
                        //             //       .getFileName(_urlController.text);
                        //             //   if (urlParser
                        //             //       .getFileName(_urlController.text)
                        //             //       .isEmpty) {
                        //             //     _urlNameController.text =
                        //             //         urlParser.getCurrentDateAsString();
                        //             //   }
                        //             // });

                        //             // print(urlParser.pasteClipboard());
                        //           });
                        //         },
                        //         icon: Icon(Icons.paste_rounded))
                        //   ],
                        // ),
                        // GridCall.customTextField(
                        //     controller: _urlController,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         if (value.isNotEmpty) {
                        //           // _urlNameController.text = urlParser
                        //           //     .getFileName(_urlController.text);
                        //         }
                        //       });
                        //     }),

                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text('Name : ')),
                        GridCall.customTextField(
                            controller: _urlNameController),
                      ],
                    )),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 12),
              actions: [
                TextButton(
                  onPressed: () {
                    print(_urlController.text);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () async {
                    DatabaseHandler.createItem({
                      "url": '${_time.hour}:${_time.minute}:${_time.second} ',
                      "name": 'Time Time',
                      "format": 'music',
                      "mode": "ON",
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('SET TIME'),
                )
              ],
            );
          }
        });
      });
    });
  }
}
