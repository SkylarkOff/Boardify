import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/workspace_model.dart';

class WorkspaceService {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: dotenv.env['API_BASE_URL'] ?? ''),
  );

  /// Ambil semua workspace (organisasi) milik user
  static Future<List<WorkspaceModel>> fetchMyWorkspaces(String token) async {
    try {
      final response = await _dio.get(
        '/organization/workspace/my',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final List data = response.data['data'];
      return data.map((json) => WorkspaceModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Gagal memuat workspace: $e');
    }
  }

  /// Buat workspace (organisasi) baru
  static Future<void> createWorkspace(String name, String token) async {
    try {
      await _dio.post(
        '/organization',
        data: {'name': name},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      throw Exception('Gagal membuat workspace: $e');
    }
  }

  /// Hapus workspace (organisasi) berdasarkan ID
  static Future<void> deleteWorkspace(String id, String token) async {
    try {
      await _dio.delete(
        '/organization/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      throw Exception('Gagal menghapus workspace: $e');
    }
  }

  static getBoardsByOrg(String orgId, String token) {}
}
