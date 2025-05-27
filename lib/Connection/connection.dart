import 'package:http/http.dart' as http;
import 'package:tnt_bomb/dataBase/dataBase.dart';
import 'package:tnt_bomb/dataBase/sharePrefrence.dart';

Future<void> connectUrls({DateTime? dateTime}) async {
  List<Map<String, dynamic>> _items = DatabaseHandler.refreshItems();
  String connectedUrls = "";

  for (int i = 0; i < _items.length; i++) {
    var currentItem = _items[i];
    String url = currentItem['url'];

    if (currentItem['mode'] == 'on') {
      connectedUrls += url;
    }
    if (i < _items.length - 1) {
      connectedUrls += ",";
    }
  }
  print('the url is $connectedUrls');

  DateTime now = dateTime ??
      DateTime
          .now(); // Using dateTime parameter if provided, else use DateTime.now()

  print(now); //s Current date and time

  var url = 'http://192.168.4.1/get';
  try {
    var response = await http.get(Uri.parse(
        '$url?input1=${connectedUrls}&input2=${now}&input3=${AppPreferences.LightSet}&input4=${AppPreferences.lightTimeSet}&input5=${AppPreferences.lightTimeColorSet}&input6=${""}'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print(e);
  }
}

Future<void> checkUrlValidity() async {
  // print(' the validation is');

  try {
    var response = await http.get(Uri.parse('http://192.168.4.1'));
    // setState(() {
    var isUrlValid = response.statusCode == 200;
    print(' the validation is $isUrlValid');
    // });
  } catch (e) {
    // setState(() {
    // isUrlValid = false;
    // print(' the validation is $isUrlValid');
    // });

    print(e);
  }
}
