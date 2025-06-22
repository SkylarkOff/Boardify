import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/board_model.dart';

class BoardService {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: dotenv.env['API_BASE_URL'] ?? ''),
  );

  static Future<void> createBoard({
    required String token,
    required String title,
    required String orgId,
    required String background,
  }) async {
    try {
      final response = await _dio.post(
        '/board',
        data: {'title': title, 'orgId': orgId, 'background': background},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Gagal membuat board');
      }
    } catch (e) {
      throw Exception('Gagal membuat board: $e');
    }
  }

  /// 📥 Ambil semua board dalam organisasi
  static Future<List<BoardModel>> fetchBoards(
    String token,
    String orgId,
  ) async {
    try {
      final response = await _dio.get(
        '/board/org/$orgId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['boards'] as List;
        return data.map((json) => BoardModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil boards: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil boards: $e');
    }
  }
}
