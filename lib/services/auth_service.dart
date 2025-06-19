import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user_model.dart';

class AuthService {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: dotenv.env['API_BASE_URL'] ?? ''),
  );

  /// Cek apakah email terdaftar (untuk langkah pertama login)
  static Future<bool> checkEmail(String input) async {
    try {
      final response = await _dio.post(
        '/auth/check-user',
        data: {'input': input},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (kDebugMode) print('Check email error: ${e.response?.data}');
      if (e.response?.statusCode == 404) {
        throw Exception('User tidak ditemukan');
      }
      throw Exception('Gagal memeriksa email');
    } catch (e) {
      if (kDebugMode) print('Check email exception: $e');
      throw Exception('Terjadi kesalahan saat memeriksa email');
    }
  }

  /// Login ke API dan kembalikan user & token jika sukses
  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'input': email,
          'password': password,
        },
      );

      if (kDebugMode) {
        print('Response Login Code: ${response.statusCode}');
        print('Response Login Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        final token = response.data['token'];
        return {'user': user, 'token': token};
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(
          'Login DioException: ${e.response?.statusCode} - ${e.response?.data}',
        );
      }
      if (e.response?.statusCode == 401) {
        throw Exception('Email atau password salah');
      }
      throw Exception('Gagal login');
    } catch (e) {
      if (kDebugMode) {
        print('Login exception: $e');
      }
      return null;
    }
  }

  /// (Opsional) Ambil profil dari token
  static Future<UserModel?> getProfile(String token) async {
    try {
      final response = await _dio.get(
        '/auth/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      if (kDebugMode) print('Get profile error: $e');
    }

    return null;
  }
}
