import 'package:flutter/material.dart';

/// Displays detailed information about a ContactItem.
class ContactItemExpanded extends StatelessWidget {
  const ContactItemExpanded({super.key});

  static const routeName = '/Contact_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
