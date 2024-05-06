import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/models/BalanceModel.dart';
import 'package:flutter_application_1/src/pages/addExpense/add_expense.dart';
import 'package:flutter_application_1/src/pages/contacts/contacts_view.dart';
import 'package:flutter_application_1/src/pages/settings/settings_view.dart';
import 'package:flutter_application_1/src/scanner/scanner.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
  static const routeName = '/balances';

  @override
  State<HomePageView> createState() => _BalancesWidgetState();
}

class _BalancesWidgetState extends State<HomePageView>
    with WidgetsBindingObserver {
  List<Balance> _balances = [Balance(1, Contact(), 12)];

  Future<void> openGPay() async {
    const platform = MethodChannel('splitty-app');
    try {
      final result = await platform.invokeMethod<int>('initializeTransaction');
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // ···
  @override
  Widget build(BuildContext context) {
    BalancesModel balancesModel = context.read<BalancesModel>();
    List<Expense> expenses = balancesModel.expenses;
    return Scaffold(
        appBar: AppBar(
          leading: const CircleAvatar(
                  // Display the Flutter Logo image asset.
                  foregroundImage: AssetImage('assets/images/random_png.png'),
                ),
          title: const Text(
             "Splitty",
              style: TextStyle(
                fontFamily: AutofillHints.creditCardType,
                fontWeight: FontWeight.w800,
                fontSize: 30.0,
                color: Colors.teal
          )),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_suggest),
              iconSize: 35.0,
              color: Colors.teal,
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
            IconButton(
              icon: const Icon(Icons.contact_phone_outlined),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, ContactsView.routeName);
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
        body: Stack(
          children: [
            const ExpensesList(),
            Center(
              child: TextButton(
                child: const Text('Pay Gaurav Mehra'),
                onPressed: () {
                  openGPay();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Scanner(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 50,
                          color: Colors.teal,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.restorablePushNamed(
                              context, AddExpenseView.routeName);
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 50,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                    
                  )),
            ),
          ],
        ),);
}
}

class Balance {
  Balance(this.id, this.friend, this.amount);
  final int id;
  final Contact friend;
  late int amount;
}

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalancesModel>(
      builder: (context, balancesModel, child) {
        List<Expense> expenses = balancesModel.expenses;
        return ListView.builder(
          // Providing a restorationId allows the ListView to restore the
          // scroll position when a user leaves and returns to the app after it
          // has been killed while running in the background.
          restorationId: 'balancesView',
          itemCount: expenses.length,
          itemBuilder: (BuildContext context, int index) {
            final item = expenses[index];

            return ListTile(
                title: Text('${item.name}'),
                leading: const CircleAvatar(
                  // Display the Flutter Logo image asset.
                  foregroundImage: AssetImage('assets/images/'),
                ));
          },
        );
      },
    );
  }
}
