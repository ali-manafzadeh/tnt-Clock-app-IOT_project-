import 'package:hive_flutter/adapters.dart';

class AppPreferences {
  static late Box boxOfData;
  static late Box boxOfMaps;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    boxOfData = await Hive.openBox("data");
    boxOfMaps = await Hive.openBox<List<Map<String, dynamic>>>("maps");
  }

// saving user choice about theme selection

  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  // saving user choice about theme selection

  static bool get backgroundImageColor =>
      boxOfData.get("backgroundImageColor") ?? false;
  static set backgroundImageColor(bool value) =>
      boxOfData.put("backgroundImageColor", value);

  //  grind number
  static int get GridNumber => boxOfData.get("GridNumber") ?? 1;
  static set GridNumber(int value) => boxOfData.put("GridNumber", value);

  // buzzer set
  static int get BuzzerSet => boxOfData.get("BuzzerSet") ?? 1;
  static set BuzzerSet(int value) => boxOfData.put('BuzzerSet', value);

  // light dataBase
  // light set
  static int get LightSet => boxOfData.get("LightSet") ?? 1;
  static set LightSet(int value) => boxOfData.put('LightSet', value);

  // Light Time set
  static String get lightTimeSet => boxOfData.get("lightTimeSet") ?? "";
  static set lightTimeSet(String value) => boxOfData.put('lightTimeSet', value);

  // Light Time set
  static String get lightTimeColorSet =>
      boxOfData.get("lightTimeColorSet") ?? "red";
  static set lightTimeColorSet(String value) =>
      boxOfData.put('lightTimeColorSet', value);
}
