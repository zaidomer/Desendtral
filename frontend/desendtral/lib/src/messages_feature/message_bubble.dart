import 'package:desendtral/src/messages_feature/message_item.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget{
  final MessageItem message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // or MainAxisAlignment.end
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 20.0),
            child: Text(message.text),
          ),
        ),
      ],
    );
  }
}
