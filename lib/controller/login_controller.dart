import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';

class LoginController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> loginOnly() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    clearError();
    setLoading(true);

    final result = await AuthService.login(email, password);

    setLoading(false);

    if (result != null) {
      final user = result['user'] as UserModel;
      final token = result['token'] as String;

      await LocalStorageService.saveUser(user, token);
      return {'user': user, 'token': token};
    } else {
      errorMessage = 'Email atau password salah';
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
