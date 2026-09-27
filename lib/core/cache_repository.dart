import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository {
  final SharedPreferences preferences;

  CacheRepository(this.preferences);

  Future<void> save(String key, String data) async {
    await preferences.setString(key, data);
  }

  String? get(String key) {
    return preferences.getString(key);
  }

  Future<void> remove(String key) async {
    await preferences.remove(key);
  }
}
