import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

class Friend {
  Friend(this.id, this.phoneNumber, this.email, this.name);

  UuidV4 id;
  String phoneNumber;
  String name;
  String email;
}

class FriendsStore extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Friend> _friends = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Friend> get friends => UnmodifiableListView(_friends);

  /// The current total price of all items (assuming all items cost $42).
  Friend get contact => _friends[0];

  void addFriend(Friend friend) {
    _friends.add(friend);
    notifyListeners();
  }
}
