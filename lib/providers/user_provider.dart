import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  String? _token;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isLoggedIn => _user != null;
  String get role => _user?.role ?? '';

  /// Login user & simpan data + token via AuthService
  Future<bool> login(String email, String password) async {
    try {
      final result = await AuthService.login(email, password);

      if (result != null) {
        _user = result['user'];
        _token = result['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  /// Logout dan hapus data lokal
  Future<void> logout() async {
    _user = null;
    _token = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  /// Cek token lokal & fetch profile jika valid
  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    if (savedToken != null) {
      try {
        final fetchedUser = await AuthService.getProfile(savedToken);
        if (fetchedUser != null) {
          _user = fetchedUser;
          _token = savedToken;
          notifyListeners();
        } else {
          await prefs.remove('token');
        }
      } catch (e) {
        debugPrint('Auto-login failed: $e');
        await prefs.remove('token');
      }
    }
  }

  /// Set user dan token secara manual (opsional)
  void setUser(UserModel user, String token) {
    _user = user;
    _token = token;
    notifyListeners();
  }
}
