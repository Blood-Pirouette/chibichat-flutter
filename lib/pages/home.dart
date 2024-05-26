import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chibichat/classes/message.dart';
import 'package:chibichat/classes/message_card.dart';
import 'package:chibichat/services/api_class.dart';
import 'package:chibichat/services/prompt_class.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String promptInput = '';
  String ipAddress = '';
  String output = '';
  int counter = 0;
  List<Message> responses = [];
  List<String> messageStringList = [];
  String messagesString = '';

  void sendPrompt() async {
    responses.add(Message(message: promptInput, messageId: 1));
    setState(() {});
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
    setState(() {});
    messageStringList.add(output);
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
            /* Creates output of prompt */
            //Text(output),

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

            /* Textfield for IP Address */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    onChanged: (value) => ipAddress = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter IP Address',
                    ),
                  ),
                ),
              ],
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
