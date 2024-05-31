import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'contact_item.dart';
import '../messages_feature/message_view.dart';

/// Displays a list of ContactItems.
class ContactItemListView extends StatefulWidget {
  const ContactItemListView({super.key});

  static const routeName = '/';

  @override
  _ContactItemListViewState createState() => _ContactItemListViewState();
}

class _ContactItemListViewState extends State<ContactItemListView> {
  // Initialize the list of items.
  List<ContactItem> contactsList = [];

  late TextEditingController nameController;
  late TextEditingController portController;
  late TextEditingController emailController;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController();
    portController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose(){
    nameController.dispose();
    portController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void addContact(String name, String port, String email, int? index) {
    setState(() {
      if(index==null){
        int newId = contactsList.isNotEmpty ? contactsList.last.id + 1 : 0;
        contactsList.add(ContactItem(newId, name, port, email));
      }else{
        contactsList[index].name=name;
        contactsList[index].port=port;
        contactsList[index].e=email;
      }
    });
    
  }

  void openNewContactDialog(int? index) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: index==null ? const Text("Add Contact") : const Text("Edit Contact"),
      content: SingleChildScrollView(
        child: ListBody(
          children:[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: portController,
              decoration: const InputDecoration(hintText: "Port"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
            nameController.clear();
            portController.clear();
            emailController.clear();
          },
        ),
        
        TextButton(
          child: index==null ? const Text("Add") : const Text("Save"),
          onPressed: () {
            // Navigator.of(context).pop(nameController.text);
            // Navigator.of(context).pop(portController.text);
            // Navigator.of(context).pop(emailController.text);
            Navigator.of(context).pop();
            addContact(nameController.text, portController.text, emailController.text, index);

            nameController.clear();
            portController.clear();
            emailController.clear();
          },
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
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
            Text('Contacts')
          ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Column(children:[
        const SizedBox(height: 8), 
        Flexible(child:ListView.builder(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'ContactItemListView',
          itemCount: contactsList.length,
          itemBuilder: (BuildContext context, int index) {
            ContactItem item = contactsList[index];

            return ListTile(
              title: Text(item.name),
              leading: const CircleAvatar(
                // Display the User Icon image asset.
                foregroundImage: AssetImage('assets/images/user_icon.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.pushNamed(
                  context,
                  MessageView.routeName,
                  arguments: item
                );
              },
              trailing: Wrap(spacing:10,children:[IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // setState(() {
                    // int newId = contactsList.isNotEmpty ? contactsList.last.id + 1 : 0;
                    // contactsList.removeAt(index);
                  // });
                  nameController.text = item.name;
                  portController.text = item.port;
                  emailController.text = item.e;
                  openNewContactDialog(index);
                },),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      // int newId = contactsList.isNotEmpty ? contactsList.last.id + 1 : 0;
                      contactsList.removeAt(index);
                    });
                  })
                ]),
            );
          },
      ))]),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        // backgroundColor: Colors.blue[700],
        onPressed: () {
          openNewContactDialog(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
