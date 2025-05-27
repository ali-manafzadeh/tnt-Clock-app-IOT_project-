import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tnt_bomb/Connection/connection.dart';
import 'package:tnt_bomb/alarmTable/alarms.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/widgets/ConfirmDialog.dart';
import 'package:tnt_bomb/widgets/firstTime_edit.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({
    super.key,
  });

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final refreshController = RefreshController();
  int currentIconIndex = 2;

  List<int> SelectedItemsList = [];
  late int keyDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 71, 17, 80),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => FistTimeChange()),
            );
          },
          child: Icon(
            Icons.alarm_add,
            size: 35,
            color: Colors.white,
          ),
        ),

        // appBar: AppBar(),
        backgroundColor: Color(0xff2D2F41),
        body: Builder(builder: (context) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverToBoxAdapter(
                      child: FilesTable(
                    callback: (deleteKeyInt) {
                      Scaffold.of(context).openDrawer();
                      setState(() {
                        keyDelete = deleteKeyInt;
                      });
                    },
                    format: 'music_text',
                    onSelectionChanged: (selectedItemListCallback) {
                      SelectedItemsList.clear();
                      setState(() {
                        SelectedItemsList = selectedItemListCallback;
                      });
                    },
                    databaseBox: DatabaseHandler.databaseBox,
                  )),
                ),
              ],
            ),
          );
        }));
  }
}
