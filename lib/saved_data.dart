import 'package:shared_preferences/shared_preferences.dart';

class SavedData {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Save user id on device

  static Future<void> saveUserId(String id) async {
    await preferences!.setString("userId", id);
  }

  // Get the user Id

  static String getUserId() {
    return preferences!.getString("userId") ?? "";
  }

// Save user name
  static Future<void> saveUserName(String name) async {
    await preferences!.setString("name", name);
  }
  // Get the user Id

  static String getUserName() {
    return preferences!.getString("name") ?? "";
  }

// Save user email
  static Future<void> saveUserEmail(String email) async {
    await preferences!.setString("email", email);
  }
  // Get the user email

  static String getUserEmail() {
    return preferences!.getString("email") ?? "";
  }
}
