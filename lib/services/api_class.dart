import 'package:http/http.dart';
import 'dart:convert';

class APIClass {
  Map<String, dynamic> prompt;

  APIClass({required this.prompt});

  Future<Response> sendPrompt() async {
    return post(
      Uri.parse('http://192.168.12.202:5001/api/v1/generate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(prompt),
    );
  }
}
