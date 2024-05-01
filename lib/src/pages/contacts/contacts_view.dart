import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/contactsModel.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});
  static const routeName = '/contacts';

  @override
  State<ContactsView> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsView> {
  List<Contact> _contacts = [];
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  void fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() {
        _permissionDenied = true;
      });
    } else {
      final contacts = await FlutterContacts.getContacts();

      setState(() {
        _contacts = contacts;
      });
    }
  }

  // ···
  @override
  Widget build(BuildContext context) {
    ContactsModel contactsModel = context.read<ContactsModel>();
    contactsModel.setContacts(_contacts);

    if (_permissionDenied) {
      contactsModel.setPermission(false);
      return const Center(child: Text('Permission Denied'));
    }
    if (_contacts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: contactsModel.contacts.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = contactsModel.contacts[index];

          return ListTile(
            title: Text(contact.displayName),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
          );
        },
      ),
    );
  }
}
