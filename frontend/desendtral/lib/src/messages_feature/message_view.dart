import 'package:flutter/material.dart';
import '../contacts_feature/contact_item.dart';
import './message_item.dart';

/// Displays detailed information about a ContactItem.
class MessageView extends StatefulWidget {
  MessageView({super.key});

  static const routeName = '/Contact_item';

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late ContactItem contact;
  List<MessageItem> messages = [];

  @override
  Widget build(BuildContext context) {
    contact = ModalRoute.of(context)!.settings.arguments as ContactItem;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:[
            Image.asset(
              'assets/images/desendtral_logo_clear.png',
              width: 50, // Adjust the width as needed
              height: 50, // Adjust the height as needed
            ),
            const SizedBox(width: 8), 
            Text('Message ${contact.name}')
          ]),
      ),
      body: Column(children: [
        const SizedBox(height: 6),
        Flexible(flex:9, child:
          Container(
            child:ListView.builder(
              restorationId: 'MessageView',
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                
              }
        ))),
        Flexible(flex:1, child: 
          Container(
            // color: Colors.amber,
            margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: Row(children: [
              Flexible(flex: 15, child:
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Enter a message',
                )
              )),
              Flexible(flex:1, 
                child: Row(children:[
                  const SizedBox(width: 8),
                  ElevatedButton(  
                    onPressed: () {}, 
                    style: ElevatedButton.styleFrom(  
                      shape: const CircleBorder(), 
                      padding: const EdgeInsets.all(20), 
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,  
                    ), 
                    child: const Icon(Icons.send_rounded, color: Colors.white),  
                  )
                ]))
            ]))
        )
      ],),
    );
  }
}
