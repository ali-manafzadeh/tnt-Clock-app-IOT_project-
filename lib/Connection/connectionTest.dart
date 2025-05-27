import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connection Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectionCheckScreen(),
    );
  }
}

class ConnectionCheckScreen extends StatefulWidget {
  @override
  _ConnectionCheckScreenState createState() => _ConnectionCheckScreenState();
}

class _ConnectionCheckScreenState extends State<ConnectionCheckScreen> {
  StreamController<String> _connectionStatusController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  void _checkConnection() {
    Stream.periodic(Duration(milliseconds: 500)).listen((_) async {
      String status = await _getConnectionStatus();
      _connectionStatusController.add(status);
    });
  }

  Future<String> _getConnectionStatus() async {
    try {
      var url = Uri.parse('http://192.168.4.1/get');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return 'Connected';
      } else {
        return 'Not Connected';
      }
    } catch (e) {
      return 'Not Connected';
    }
  }

  @override
  void dispose() {
    _connectionStatusController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Checker'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: _connectionStatusController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(snapshot.data ?? 'Not Connected',
                  style: TextStyle(fontSize: 24, color: Colors.black));
            } else {
              return Text('Not Connected',
                  style: TextStyle(fontSize: 24, color: Colors.black));
            }
          },
        ),
      ),
    );
  }
}
