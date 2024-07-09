import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/helpers/transaction.dart';
import 'package:flutter_application_1/src/stores/BalancesStore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:uuid/v4.dart';

import 'package:provider/provider.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView(
      {super.key,
      this.upiAddress = '',
      this.amount = '',
      this.name = '',
      this.transactionRef = ''});
  static const routeName = '/expense';
  final String upiAddress;
  final String amount;
  final String name;
  final String transactionRef;

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
  final upiAddressController = TextEditingController();
  String transactionRef = '';

  bool amountReadOnly = false;
  bool upiAddressReadOnly = false;

  @override
  void initState() {
    super.initState();
  }

  void populateStateData(
      String amount, String upiAddress, String name, String transactionRef) {
    amountController.text = amount;
    upiAddressController.text = Uri.decodeComponent(upiAddress);
    nameController.text = name;
    this.transactionRef = transactionRef;
    if (amount.isNotEmpty) {
      amountReadOnly = true;
    }
    if (upiAddress.isNotEmpty) {
      upiAddressReadOnly = true;
    }
  }

  // ···
  @override
  Widget build(BuildContext context) {
    void createExpense() {
      String name = nameController.text;
      double amount = double.parse(amountController.text);

      var expense = Expense(const UuidV4(), Contact(), amount, name);
      BalancesStore balancesStore = context.read<BalancesStore>();
      balancesStore.addExpense(expense);
    }

    void makePayment() {
      createExpense();
      Transaction.initializeTransaction(
          receiverUpiAddress: upiAddressController.text,
          receiverName: nameController.text,
          transactionRef: transactionRef,
          amount: amountController.text);
    }

    populateStateData(
        widget.amount, widget.upiAddress, widget.name, widget.transactionRef);

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
              labelText: 'Expense Name',
              helperText: 'Just so we remember',
            ),
          ),
          TextField(
            showCursor: true,
            controller: upiAddressController,
            readOnly: upiAddressReadOnly,
            enabled: !upiAddressReadOnly,
            decoration: const InputDecoration(
                labelText: 'UPI Address',
                helperText: 'How much was the transaction'),
          ),
          TextField(
            showCursor: true,
            controller: amountController,
            readOnly: amountReadOnly,
            enabled: !amountReadOnly,
            decoration: const InputDecoration(
                labelText: 'Amount',
                helperText: 'How much was the transaction'),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                makePayment();
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
