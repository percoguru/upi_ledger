import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class AuthService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  // Future<ThemeMode> themeMode() async => ThemeMode.system;
  // Obtain shared preferences.
  late final SupabaseClient supabase;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> initialize() async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    await Supabase.initialize(
      url: 'https://xfmjzwzasggjcopokmrh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhmbWp6d3phc2dnamNvcG9rbXJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgxMjA1MzEsImV4cCI6MjAzMzY5NjUzMX0.ing5siFn8Oh8NafZhIT8AnHCUUB-OCNzP2kmTo_S-gw',
    );
    supabase = Supabase.instance.client;
  }

  Future<User?> signUpUser(String email, String password) async {
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;

    final SharedPreferences prefs = await _prefs;
    prefs.setString('session', session.toString());
    prefs.setString('user', user.toString());

    return user;
  }

  Future<String?> getUserInfo() async {
    final SharedPreferences prefs = await _prefs;
    String? user = prefs.getString('user');
    print("Found user in storage, $user");

    return user;
  }

  Future<User?> login(String email, String password) async {
    final AuthResponse res = await supabase.auth
        .signInWithPassword(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;

    print("swfs $user");
    print(session);

    final SharedPreferences prefs = await _prefs;
    prefs.setString('session', session.toString());
    prefs.setString('user', user.toString());

    return user;
  }
}
