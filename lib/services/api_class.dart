import 'package:http/http.dart';
import 'dart:convert';

class APIClass {
  Map<String, dynamic> prompt;
  String ipAddress;

  APIClass({required this.prompt, required this.ipAddress});

  Future<Response> sendPrompt() async {
    return post(
      Uri.parse('http://$ipAddress:5001/api/v1/generate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(prompt),
    );
  }
}
