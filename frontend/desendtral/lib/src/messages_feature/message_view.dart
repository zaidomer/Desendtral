import 'package:desendtral/src/messages_feature/message_bubble.dart';
import 'package:flutter/material.dart';
import '../contacts_feature/contact_item.dart';
import './message_item.dart';

class MessageView extends StatefulWidget {
  MessageView({super.key});

  static const routeName = '/Contact_item';

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late ContactItem contact;
  late TextEditingController messageController;
  List<MessageItem> messages = [];

  @override
  void initState(){
    super.initState();
    messageController = TextEditingController();
  }

  bool isValidMessage(String msg) {
    final RegExp patternOfBlankMessages = RegExp(r'^\s*$');
    return !patternOfBlankMessages.hasMatch(msg);
  }

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
        Flexible(flex:8, child:
          ListView.builder(
            restorationId: 'MessageView',
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              MessageItem item = messages[index];
              return MessageBubble(message: item);
            }
        )),
        Flexible(flex:1, child: 
          Container(
            // color: Colors.amber,
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: Center(child:Row(children: [
              Expanded(child:
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'Enter a message',
                ),
                controller: messageController,
              )),
             
              const SizedBox(width: 8),
              ElevatedButton(  
                onPressed: () {
                  if(isValidMessage(messageController.text)){
                    setState(() {
                      int newId = messages.isNotEmpty ? messages.last.id + 1 : 0;
                      messages.add(MessageItem(newId, messageController.text));
                      messageController.text="";
                      messageController.clear();
                    });
                  }
                }, 
                style: ElevatedButton.styleFrom(  
                  shape: const CircleBorder(), 
                  padding: const EdgeInsets.all(20), 
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,  
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ), 
                child: const Icon(Icons.send_rounded, color: Colors.white),  
              )
            ]))
        )
    )],),
    );
  }
}
