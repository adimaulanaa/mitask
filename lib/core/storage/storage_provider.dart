
import 'package:mitask/core/storage/shared_pref_storage.dart';

class StorageProvider {
  static const _storagePrefix = 'app_storage';

  static const _keyInitialization = 'initialization';
  static const _keyUserId = 'user_id';
  static const _keyToken = 'token';
  static const _keyFirstName = 'first_name';
  static const _keyLastName = 'last_name';
  static const _keyDisplayName = 'display_name';

  final SharedPrefStorage _storage;

  StorageProvider._(this._storage);

  static Future<StorageProvider> create() async {
    final storage = SharedPrefStorage(prefix: _storagePrefix);
    await storage.init();
    return StorageProvider._(storage);
  }

  Future<void> clear() => _storage.clear();

  // String
  String? get userId => _storage.get<String>(_keyUserId);
  set userId(String? value) => _storage.set<String>(_keyUserId, value ?? '');

  String? get token => _storage.get<String>(_keyToken);
  set token(String? value) => _storage.set<String>(_keyToken, value ?? '');

  String? get displayName => _storage.get<String>(_keyDisplayName);
  set displayName(String? value) => _storage.set<String>(_keyDisplayName, value ?? '');

  String? get firstName => _storage.get<String>(_keyFirstName);
  set firstName(String? value) => _storage.set<String>(_keyFirstName, value ?? '');

  String? get lastName => _storage.get<String>(_keyLastName);
  set lastName(String? value) => _storage.set<String>(_keyLastName, value ?? '');

  // Int
  // int get age => _storage.get<int>(_keyAge, defaultValue: 0)!;
  // set age(int value) => _storage.set<int>(_keyAge, value);

  // Bool
  bool get isInitialization => _storage.get<bool>(_keyInitialization, defaultValue: false)!;
  set isInitialization(bool value) => _storage.set<bool>(_keyInitialization, value);
  // bool get isInitialization => _storage.get<bool>(_keyInitialization, defaultValue: false)!;
  // set isInitialization(bool value) => _storage.set<bool>(_keyInitialization, value);

  // // Double
  // double get balance => _storage.get<double>(_keyBalance, defaultValue: 0.0)!;
  // set balance(double value) => _storage.set<double>(_keyBalance, value);

  // DateTime (di-handle sebagai String ISO)
  // DateTime? get lastLogin {
  //   final str = _storage.get<String>(_keyLastLogin);
  //   return str != null ? DateTime.tryParse(str) : null;
  // }

  // set lastLogin(DateTime? value) {
  //   _storage.set<String>(_keyLastLogin, value?.toIso8601String() ?? '');
  // }
}
