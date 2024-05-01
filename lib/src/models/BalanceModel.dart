import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/addExpense/add_expense.dart';

class BalancesModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Expense> _expenses = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  /// The current total price of all items (assuming all items cost $42).
  Expense expense(id) => _expenses.firstWhere((element) => element.id == id);

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }
}
