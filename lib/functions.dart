import 'dart:convert';
import 'package:http/http.dart';

/*Future<void> continueAuth(order, phone) async {
  const url = 'http://savechildfuture.com/app.php';
  const payload = {data: order};
  const response = await http.post(url, body: payload);
}*/

_makePostRequest (order, phone) async{
  String url = 'http://savechildfuture.com/app.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = jsonEncode(<String, String>{
    'order': order,
    'phone': phone
  });
  Response response = await post(url, headers: headers, body: json);
  int statusCode = response.statusCode;
  print(statusCode);
}