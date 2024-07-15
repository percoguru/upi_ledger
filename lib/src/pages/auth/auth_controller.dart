import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_service.dart';

class AuthController with ChangeNotifier {
  AuthController._() {
    _authService = AuthService();
  }

  // Make SettingsService a private variable so it is not used directly.
  late final AuthService _authService;

  static final AuthController _instance = AuthController._();

  factory AuthController() {
    return _instance;
  }

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  // late bool _loggedIn;

  // Allow Widgets to read the user's preferred ThemeMode.
  Future<String?> get userInfo async {
    return _authService.getUserInfo();
  }

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  // Future<void> loadSettings() async {
  //   // _themeMode = await _settingsService.themeMode();

  //   // Important! Inform listeners a change has occurred.
  //   notifyListeners();
  // }

  Future<User?> signUp(email, password) async {
    return _authService.signUpUser(email, password);
  }

  Future<void> initializeAuth() async {
    await _authService.initialize();
  }

  Future<User?> login(email, password) async {
    return _authService.login(email, password);
  }
}
