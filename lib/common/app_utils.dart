import 'package:flutter/material.dart';
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

  static void bar({
    required String text,
    required BuildContext context,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        behavior: .floating,
        margin: EdgeInsets.all(10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: color,
      ),
    );
  }
}
