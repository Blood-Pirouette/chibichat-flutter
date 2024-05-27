import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chibichat/classes/message.dart';
import 'package:chibichat/classes/message_card.dart';
import 'package:chibichat/services/api_class.dart';
import 'package:chibichat/services/prompt_class.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String promptInput = '';
String ipAddress = '';
String output = '';
int counter = 0;
List<Message> responses = [];
List<String> messageStringList = [];
String messagesString = '';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            /* List view of messages */
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
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
            ),
            const SizedBox(
              height: 20,
            ),

            /* Settings button */
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

            /* Row containing button and text field for prompt*/
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
                    sendPrompt(callback: () {
                      setState(() {});
                    });
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

void sendPrompt({required Function callback}) async {
  final prefs = await SharedPreferences.getInstance();
  ipAddress = prefs.getString('IPADDRESS') ?? '';
  responses.add(Message(message: promptInput, messageId: 1));
  callback!();
  promptInput = " [INST] $promptInput [/INST] ";
  messageStringList.add(promptInput);
  messagesString = messageStringList.join();

  PromptClass promptObject = PromptClass(prompt: messagesString);
  Map<String, dynamic> prompt = promptObject.toJson();
  APIClass requestObject = APIClass(prompt: prompt, ipAddress: ipAddress);
  Response responseObject = await requestObject.sendPrompt();
  var decodedResponse = jsonDecode(responseObject.body);
  var textObject = decodedResponse['results'];
  output = textObject[0]['text'];
  responses.add(Message(message: output, messageId: 2));
  callback!();
  messageStringList.add(output);
}
