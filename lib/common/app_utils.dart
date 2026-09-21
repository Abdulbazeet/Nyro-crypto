import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static Future<bool> isVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? verified = prefs.getBool('verified');
    return verified ?? false;
  }

  static Future<void> setVerified(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('verified', value);
  }
}
