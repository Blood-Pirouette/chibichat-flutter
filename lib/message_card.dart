import 'package:flutter/material.dart';
import 'message.dart';

class MessageCard extends StatelessWidget {
  Message messageObject;
  Function() delete;
  MessageCard({required this.messageObject, required this.delete});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(messageObject!.message.toString()),
          const SizedBox(
            height: 10,
          ),
          Text(messageObject!.messageId.toString()),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: delete,
            icon: Icon(Icons.delete),
            label: Text('delete'),
          ),
        ],
      ),
    );
  }
}
