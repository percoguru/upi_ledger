import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/BalanceModel.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uuid/v4.dart';

import 'package:provider/provider.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});
  static const routeName = '/expense';

  @override
  State<AddExpenseView> createState() => _ExpenseWidgetState();
}

class Expense {
  Expense(this.id, this.friend, this.amount, this.name);

  UuidV4 id;
  Contact? friend;
  double amount;
  String name;
}

class _ExpenseWidgetState extends State<AddExpenseView> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  void createExpense() {
    String name = nameController.text;
    double amount = double.parse(amountController.text);

    var expense = Expense(UuidV4(), Contact(), amount, name);
    BalancesModel balancesModel = context.read<BalancesModel>();
    balancesModel.addExpense(expense);
  }

  @override
  void initState() {
    super.initState();
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          TextField(
            showCursor: true,
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              helperText: 'Just so we remember',
            ),
          ),
          TextField(
            showCursor: true,
            controller: amountController,
            decoration: const InputDecoration(
                labelText: 'Amount',
                helperText: 'How much was the transaction'),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                createExpense();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          )
        ]),
      ),
    );
  }
}

class Balance {
  Balance(this.id, this.friend, this.amount);
  final int id;
  final Contact friend;
  late int amount;
}
