import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPrefsHelper? _instance;
  static SharedPreferences? _prefs;

  SharedPrefsHelper._internal();

  /// Singleton instance
  static Future<SharedPrefsHelper> getInstance() async {
    _instance ??= SharedPrefsHelper._internal();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  /// Save data
  Future<bool> setValue<T>(String key, T value) async {
    if (_prefs == null) return false;

    if (value is String) return _prefs!.setString(key, value);
    if (value is int) return _prefs!.setInt(key, value);
    if (value is bool) return _prefs!.setBool(key, value);
    if (value is double) return _prefs!.setDouble(key, value);
    if (value is List<String>) return _prefs!.setStringList(key, value);

    throw UnsupportedError("Type ${T.runtimeType} is not supported");
  }

  /// Get data
  T? getValue<T>(String key) {
    if (_prefs == null) return null;

    dynamic value = _prefs!.get(key);
    if (value is T) return value;
    return null;
  }

  /// Remove key
  Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return _prefs!.remove(key);
  }

  /// Clear all keys
  Future<bool> clear() async {
    if (_prefs == null) return false;
    return _prefs!.clear();
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}
