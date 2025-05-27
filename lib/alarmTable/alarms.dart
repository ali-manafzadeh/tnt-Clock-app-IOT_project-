import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neon/neon.dart';
import 'package:tnt_bomb/animation/fade_in.dart';
import 'package:tnt_bomb/classes/sideClasses.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/themData.dart';
import 'package:tnt_bomb/widgets/ConfirmDialog.dart';
import 'package:tnt_bomb/widgets/changeTime.dart';
import 'package:tnt_bomb/widgets/convert.dart';
import 'package:tnt_bomb/widgets/firstTime_edit.dart';
import 'package:tnt_bomb/widgets/generalWidget.dart';

class FilesTable extends StatefulWidget {
  // Define the callback function type
  final void Function(List<int>) onSelectionChanged;
  final Function(int) callback;
  final String format;
  final Box<dynamic> databaseBox;

  const FilesTable({
    Key? key,
    required this.onSelectionChanged, // Update constructor to accept the callback
    required this.format,
    required this.callback,
    required this.databaseBox,
  }) : super(key: key);

  @override
  State<FilesTable> createState() => _FilesTableState();
}

class _FilesTableState extends State<FilesTable> {
  List<bool> selectedItems = [];

  ThemeData themeData = ThemeData();
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _itemsLength = [];

  // add folder and deleted key
  List<int> keys = [];
  Genral g = new Genral();

  // final _databaseBox = Hive.box('database_box');

  void refresh() {
    _items = DatabaseHandler.refreshItems();
    _itemsLength = _items.reversed
        .toList()
        .where((item) => widget.format == 'file_text'
            ? true
            : item['format'] ==
                '${widget.format == 'music_text' ? 'music' : widget.format == 'video_text' ? 'video' : widget.format == 'docs_text' ? 'docs' : widget.format == 'image_text' ? 'image' : 'other'}')
        .toList();
    selectedItems = List.generate(_itemsLength.length, (index) => false);
    // print('the lengh is ${selectedItems.length}');
  }

  @override
  void initState() {
    super.initState();
    ChangeAllformatedString();

    refresh(); // Load data when app starts
  }

  bool _deselectItemsOnBack() {
    setState(() {
      selectedItems = List.generate(_items.length, (index) => false);
    });
    return true;
  }

  List<int> getSelectedItemsList() {
    List<int> selectedItemsList = [];
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        selectedItemsList.add(i);
      }
    }
    print(selectedItemsList);

    return selectedItemsList;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: getSelectedItemsList().isEmpty,
        onPopInvoked: (didPop) {
          _deselectItemsOnBack();
          widget.onSelectionChanged(getSelectedItemsList());
          keys.clear();
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ValueListenableBuilder(
              valueListenable: widget.databaseBox.listenable(),
              builder: (context, Box databaseBox, _) {
                final dataIndex = databaseBox.keys.map((key) {
                  final value = databaseBox.get(key);
                  return {
                    "key": key,
                    "url": value["url"],
                    "mode": value['mode'],
                    "format": value['format'],
                  };
                }).toList();
                // _items = dataIndex.reversed.toList();

                _itemsLength = dataIndex.reversed
                    .toList()
                    .where((item) => widget.format == 'file_text'
                        ? true
                        : item['format'] ==
                            '${widget.format == 'music_text' ? 'music' : widget.format == 'video_text' ? 'video' : widget.format == 'docs_text' ? 'docs' : widget.format == 'image_text' ? 'image' : 'other'}')
                    .toList();

                // add refresh
                if (_items.length != _itemsLength.length) {
                  selectedItems =
                      List.generate(_itemsLength.length, (index) => false);
                }

                _items = dataIndex.reversed
                    .toList()
                    .where((item) => widget.format == 'file_text'
                        ? true
                        : item['format'] ==
                            '${widget.format == 'music_text' ? 'music' : widget.format == 'video_text' ? 'video' : widget.format == 'docs_text' ? 'docs' : widget.format == 'image_text' ? 'image' : 'other'}')
                    .toList();
                // print('the lengh is ${selectedItems.length}');

                return ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = _items[index];
                    return Column(
                      children: [
                        index == 0
                            ? getSelectedItemsList().isNotEmpty
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 32, 124),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            '${getSelectedItemsList().length}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            FadeInAnimation(
                                              delay: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          print(
                                                              'the keys is ${keys}');
                                                          showConfirmDialog(
                                                              context, () {
                                                            // context.read<DetailPhotoCubit>().downloadPhoto(
                                                            //     context, photo.src.original, false);

                                                            //  DatabaseHandler.deleteItem(key);
                                                            print(
                                                                'the keys is ${keys}');
                                                            for (int key
                                                                in keys) {
                                                              DatabaseHandler
                                                                  .deleteItem(
                                                                      key);
                                                              print(key);
                                                            }
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            // setState(() {
                                                            //   refresh();
                                                            // });
                                                          }, 'are u sure?');

                                                          // keys.clear();
                                                        },
                                                        icon: Icon(
                                                          Iconsax.trash,
                                                          color: Colors.red,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          _deselectItemsOnBack();
                                                          widget.onSelectionChanged(
                                                              getSelectedItemsList());
                                                          keys.clear();
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color:
                                                              Colors.deepPurple,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 66, 32, 124),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 6),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        10)), // Add padding here
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (_) =>
                                                      FistTimeChange()),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'alarms',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Icon(Icons.alarm_add)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                            : Container(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (getSelectedItemsList().isNotEmpty) {
                                selectedItems[index] = !selectedItems[index];
                                widget
                                    .onSelectionChanged(getSelectedItemsList());

                                // keys.add(currentItem['key']);
                                print(keys);
                              }

                              if (selectedItems[index]) {
                                keys.add(currentItem['key']);
                              } else {
                                keys.remove(_items[index]['key']);
                              }
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              selectedItems[index] = true;
                              keys.add(currentItem['key']);
                              print(keys);
                            });
                            widget.onSelectionChanged(getSelectedItemsList());
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  child: Card(
                                    color: selectedItems[index]
                                        ? Colors.grey
                                        : null,
                                    child: Container(
                                      // margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: currentItem['mode'] == 'on'
                                                ? GradientColors.AlarmCard
                                                : GradientColors
                                                    .DisableAlarmCard,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.orange
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                spreadRadius: 2,
                                                offset: Offset(0, 0))
                                          ]),
                                      padding: EdgeInsets.only(
                                          right: 0,
                                          left:
                                              getSelectedItemsList().isNotEmpty
                                                  ? 0
                                                  : 12),
                                      // height: 50,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  getSelectedItemsList()
                                                          .isNotEmpty
                                                      ? Checkbox(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0))),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
                                                          ),
                                                          value: selectedItems[
                                                              index],
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              // Update the item's selection state based on the checkbox.
                                                              selectedItems[
                                                                      index] =
                                                                  newValue ??
                                                                      false;
                                                              widget.onSelectionChanged(
                                                                  getSelectedItemsList());
                                                            });
                                                          },
                                                          activeColor: Colors
                                                              .deepPurple, // Use your theme color for the checkbox.
                                                        )
                                                      : Container(),
                                                  Container(
                                                    width: 200,
                                                    child: Neon(
                                                      glowing: false,
                                                      text:
                                                          "${DateTimeFormatter.extractDateTime(currentItem['url']).isNotEmpty ? DateTimeFormatter.extractDateTime(currentItem['url'])[1] : ""} : ${DateTimeFormatter.extractDateTime(currentItem['url']).isNotEmpty ? DateTimeFormatter.extractDateTime(currentItem['url'])[2] : ""}",

                                                      color:
                                                          currentItem['mode'] ==
                                                                  'on'
                                                              ? Colors.red
                                                              : Colors.grey,
                                                      fontSize: 40,
                                                      font: NeonFont.Monoton,
                                                      // flickeringText: true,
                                                      flickeringLetters: null,
                                                      flickeringText: false,

                                                      // glowingDuration: new Duration(seconds: 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (_) =>
                                                                changeTime(
                                                              keyItem:
                                                                  currentItem[
                                                                      'key'],
                                                              firstTime: false,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color:
                                                            Colors.deepPurple,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              // g.spacew(8),
                                              Text(
                                                "${DateTimeFormatter.extractDateTime(currentItem['url']).isNotEmpty ? DateTimeFormatter.extractDateTime(currentItem['url'])[0] == "e" ? "every day" : DateTimeFormatter.extractDateTime(currentItem['url'])[0] : ""}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Switch(
                                                onChanged: (bool value) {
                                                  print(
                                                      "Current url  ${currentItem['url']}");

                                                  setState(() {
                                                    print(currentItem['mode']);

                                                    if (currentItem['mode'] ==
                                                        'off') {
                                                      // if () {}
                                                      DatabaseHandler
                                                          .updateItem(
                                                              currentItem[
                                                                  'key'],
                                                              {
                                                            "key": currentItem[
                                                                'key'],
                                                            "url": DateTimeFormatter.extractDateTime(
                                                                            currentItem['url'])[
                                                                        0] !=
                                                                    "e"
                                                                ? formatedString(
                                                                    context,
                                                                    currentItem)
                                                                : currentItem[
                                                                    'url'],
                                                            "mode": 'on',
                                                            "format": 'music',
                                                          });
                                                    } else {
                                                      DatabaseHandler
                                                          .updateItem(
                                                              currentItem[
                                                                  'key'],
                                                              {
                                                            "key": currentItem[
                                                                'key'],
                                                            "url": currentItem[
                                                                'url'],
                                                            "mode": 'off',
                                                            "format": 'music',
                                                          });
                                                    }
                                                    print(currentItem['mode']);

                                                    print(_items);
                                                  });
                                                },
                                                value:
                                                    currentItem['mode'] == 'on',
                                                activeColor: Colors.green,
                                                focusColor: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              },
            )));
  }
}
