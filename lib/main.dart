import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tnt_bomb/Homepage.dart';
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.initHive();

  await Hive.initFlutter();

  //
  await Hive.openBox('database_box');

  await DatabaseHandler.initHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tnt Clock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
