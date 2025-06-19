import 'package:shared_preferences/shared_preferences.dart';
import 'package:boardify/models/user_model.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

class LocalStorageService {
  static const _keyToken = 'auth_token';
  static const _keyId = 'user_id';
  static const _keyName = 'user_name';
  static const _keyEmail = 'user_email';
  static const _keyRole = 'user_role';

  /// Simpan token dan data user
  static Future<void> saveUser(UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setInt(_keyId, user.id);
    await prefs.setString(_keyName, user.name);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setString(_keyRole, user.role);

    _logger.i('User data saved: ${user.toJson()}');
  }

  /// Ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_keyToken);
    _logger.d('Retrieved token: $token');
    return token;
  }

  /// Ambil data user
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(_keyId);
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);
    final role = prefs.getString(_keyRole);

    if (id != null && name != null && email != null && role != null) {
      final user = UserModel(id: id, name: name, email: email, role: role);
      _logger.d('Retrieved user: ${user.toJson()}');
      return user;
    }

    _logger.w('No user data found in local storage.');
    return null;
  }

  /// Hapus semua data saat logout
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyId);
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyRole);
    _logger.i('Local storage cleared');
  }
}
