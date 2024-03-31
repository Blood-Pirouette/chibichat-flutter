import 'package:flutter/material.dart';
import 'messages.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$counter'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: responses
                  .map((response) => Text(response.message.toString()))
                  .toList(),
            ),
            const Text('output'),
            const SizedBox(
              width: 250,
              height: 500,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
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
                    setState(() {
                      counter++;
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
