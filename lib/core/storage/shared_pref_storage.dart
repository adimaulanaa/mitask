import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage {
  final String prefix;
  late SharedPreferences _prefs;

  SharedPrefStorage({required this.prefix});

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String _key(String key) => '${prefix}_$key';

  T? get<T>(String key, {T? defaultValue}) {
    final fullKey = _key(key);
    if (T == bool) return _prefs.getBool(fullKey) as T? ?? defaultValue;
    if (T == int) return _prefs.getInt(fullKey) as T? ?? defaultValue;
    if (T == double) return _prefs.getDouble(fullKey) as T? ?? defaultValue;
    if (T == String) return _prefs.getString(fullKey) as T? ?? defaultValue;

    final jsonString = _prefs.getString(fullKey);
    if (jsonString != null) {
      try {
        return json.decode(jsonString) as T;
      } catch (_) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  Future<void> set<T>(String key, T value) async {
    final fullKey = _key(key);
    if (value is bool) {
      await _prefs.setBool(fullKey, value);
    } else if (value is int) {
      await _prefs.setInt(fullKey, value);
    } else if (value is double) {
      await _prefs.setDouble(fullKey, value);
    } else if (value is String) {
      await _prefs.setString(fullKey, value);
    } else {
      await _prefs.setString(fullKey, json.encode(value));
    }
  }

  Future<void> remove(String key) async {
    await _prefs.remove(_key(key));
  }

  Future<void> clear() async {
    final keys = _prefs.getKeys().where((k) => k.startsWith(prefix));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
}
