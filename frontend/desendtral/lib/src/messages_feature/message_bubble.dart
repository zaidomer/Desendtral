import 'package:desendtral/src/messages_feature/message_item.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget{
  final MessageItem message;
  final bool isSent;
  const MessageBubble({super.key, required this.message, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start, 
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: isSent ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onSecondary,
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
            child: Text(message.text),
          ),
        ),
      ],
    );
  }
}
