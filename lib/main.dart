import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/stores/BalancesStore.dart';
import 'package:flutter_application_1/src/stores/ContactsStore.dart';
import 'package:flutter_application_1/src/stores/FriendsStore.dart';
import 'package:flutter_application_1/src/pages/settings/settings_controller.dart';
import 'package:flutter_application_1/src/pages/settings/settings_service.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  runApp(
    MultiProvider(providers: [
      Provider(create: (context) => ContactsStore()),
      ChangeNotifierProvider(create: (context) => BalancesStore()),
      ChangeNotifierProvider(create: (context) => FriendsStore())
    ], child: MyApp(settingsController: settingsController)),
  );
}
