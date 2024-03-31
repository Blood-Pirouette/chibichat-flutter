import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chibichat/message.dart';
import 'package:chibichat/message_card.dart';
import 'package:chibichat/services/api_class.dart';
import 'package:chibichat/services/prompt_class.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String promptInput = '';
  String output = '';
  int counter = 0;
  List<Message> responses = [
    Message(
      message: 'Hello',
      messageId: 1,
    ),
    Message(
      message: 'How are you?',
      messageId: 2,
    ),
  ];

  void sendPrompt() async {
    PromptClass promptObject = PromptClass(prompt: promptInput);
    Map<String, dynamic> prompt = promptObject.toJson();
    APIClass requestObject = APIClass(prompt: prompt);
    Response responseObject = await requestObject.sendPrompt();
    var decodedResponse = jsonDecode(responseObject.body);
    var textObject = decodedResponse['results'];
    output = textObject[0]['text'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChibiChat'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(output),
            Column(
              children: responses
                  .map((response) => MessageCard(
                        delete: () {
                          setState(() {
                            responses.remove(response);
                          });
                        },
                        messageObject: response,
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, '/settings');
                });
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
            const SizedBox(
              width: 250,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    onChanged: (value) => promptInput = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Prompt',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      )),
                  onPressed: () {
                    sendPrompt();
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
            const SizedBox(
              width: 200,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
