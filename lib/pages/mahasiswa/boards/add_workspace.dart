import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/workspace_service.dart';

Future<void> showTambahWorkspaceDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  bool loading = false;

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Tambah Workspace',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Nama Workspace',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        loading
                            ? null
                            : () async {
                              final name = controller.text.trim();
                              final token =
                                  Provider.of<UserProvider>(
                                    context,
                                    listen: false,
                                  ).token;

                              if (name.isEmpty || token == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Nama workspace tidak boleh kosong',
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() => loading = true);
                              try {
                                await WorkspaceService.createWorkspace(
                                  name,
                                  token,
                                );
                                Navigator.of(context).pop(); // Tutup dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Workspace berhasil dibuat!'),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Gagal: $e')),
                                );
                              } finally {
                                setState(() => loading = false);
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child:
                        loading
                            ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Tambah',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
