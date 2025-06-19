import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'local_storage_service.dart';

class ApiService {
  static late final Dio _dio;

  /// Inisialisasi Dio dengan BASE_URL dari file .env
  static Future<void> init() async {
    final baseUrl = dotenv.env['API_BASE_URL'];

    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('API_BASE_URL tidak ditemukan di .env');
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  static Dio get client => _dio;

  /// GET
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(path, queryParameters: query);
  }

  /// POST
  static Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return await _dio.post(path, data: data);
  }

  /// PUT
  static Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return await _dio.put(path, data: data);
  }

  /// DELETE
  static Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
