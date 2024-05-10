import 'dart:collection';

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsStore {
  /// Internal, private state of the cart.
  List<Contact> _contacts = [];
  bool _permissionDenied = false;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);
  bool get permissionDenied => _permissionDenied;

  /// The current total price of all items (assuming all items cost $42).
  Contact get contact => _contacts[0];

  void setContacts(List<Contact> contacts) {
    _contacts = contacts;
  }

  void setPermission(bool permissionDenied) {
    _permissionDenied = permissionDenied;
  }
}
