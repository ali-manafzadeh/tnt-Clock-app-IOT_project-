import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DatabaseHandler {
  static late Box databaseBox;
  static late Box databaseFoldersBox;
  static late Box databaseBuzzer;
  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('database_box');
    await Hive.openBox('database_folder_box');
    // await Hive.openBox('database_folder_box');

    databaseBox = Hive.box('database_box');
    databaseFoldersBox = Hive.box('database_folder_box');
    // databaseBuzzer = Hive.box('+');
  }

// databaseFolderBox
  static Future<void> createFolderItem(Map<String, dynamic> newItem) async {
    await databaseFoldersBox.add(newItem);
  }

// dateBase buzzer Light

// databaseFolderBox

  static List<Map<String, dynamic>> refreshFolderItems() {
    final data = databaseFoldersBox.keys.map((key) {
      final value = databaseFoldersBox.get(key);
      return {
        "key": key,
        "folderName": value["folderName"],
        "folder": value['folder'],
      };
    }).toList();
    print(data.reversed.toList());
    return data.reversed.toList();
  }

  // delete databaseFoldersBox
  static Future<void> deleteFolderItem(int itemKey) async {
    await databaseFoldersBox.delete(itemKey);
  }

  // delete databaseFoldersBox folder items
  static Future<void> deleteFolderItemItems(
      int itemKey, List<int> keyList) async {
    print('the keyLIst is ${keyList} the itemKey is ${itemKey}');
    var item = databaseFoldersBox.get(itemKey);
    String folderString = item['folder'];
    List<int> keys = folderString.split(',').map((e) => int.parse(e)).toList();

    // Remove elements from keys list that are present in itemKey list
    keys.removeWhere((key) => keyList.contains(key));
    String keysString = keys.join(',');

    Map<String, dynamic> itemMap = {
      "key": item['key'],
      "folderName": item["folderName"],
      "folder": keysString,
    };

    await databaseFoldersBox.put(itemKey, itemMap);
  }

  // databaseBox
  static Future<void> createItem(Map<String, dynamic> newItem) async {
    await databaseBox.add(newItem);
  }

  static readItem(int key) {
    return databaseBox.get(key);
  }

  static readItemFolder(int key) {
    return databaseFoldersBox.get(key);
  }

  static List<Map<String, dynamic>> readItemsFolder(String keyesString) {
    List<int> keys = [];
    if (keyesString.isNotEmpty) {
      keys = keyesString.split(',').map((e) => int.parse(e)).toList();
    }

    final data = keys.where((key) => databaseBox.containsKey(key)).map((key) {
      final value = databaseBox.get(key);
      return {
        "key": key,
        "url": value["url"],
        "mode": value['mode'],
        "format": value['format'],
      };
    }).toList();

    print('the items reversed ${data.reversed.toList()}');
    return data.reversed.toList();
  }

  static Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
    await databaseBox.put(itemKey, item);
  }

  static Future<void> deleteItem(int itemKey) async {
    await databaseBox.delete(itemKey);
  }

  static List<Map<String, dynamic>> refreshItems() {
    final data = databaseBox.keys.map((key) {
      final value = databaseBox.get(key);
      return {
        "key": key,
        "url": value["url"],
        "mode": value['mode'],
        "format": value['format'],
      };
    }).toList();
    print(data.reversed.toList());
    return data.reversed.toList();
  }
}
