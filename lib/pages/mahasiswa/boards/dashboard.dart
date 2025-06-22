import 'package:boardify/models/board_model.dart';
import 'package:boardify/services/board_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/workspace_model.dart';
import '../../../providers/user_provider.dart';
import '../../../services/workspace_service.dart';
import 'boards/boards.dart';
import 'add_workspace.dart';
import 'add_board_dialog.dart';

class DashboardMahasiswa extends StatefulWidget {
  final void Function(dynamic board)? onBoardTap;

  const DashboardMahasiswa({super.key, this.onBoardTap});

  @override
  State<DashboardMahasiswa> createState() => _DashboardMahasiswaState();
}

class _DashboardMahasiswaState extends State<DashboardMahasiswa> {
  List<WorkspaceModel> _workspaces = [];
  bool _loading = true;

  Future<void> _loadWorkspaces() async {
    final token = Provider.of<UserProvider>(context, listen: false).token;
    if (token == null) return;

    try {
      final data = await WorkspaceService.fetchMyWorkspaces(token);
      setState(() {
        _workspaces = data;
        _loading = false;
      });
    } catch (e) {
      print('Gagal memuat workspace: $e');
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWorkspaces();
    _fetchWorkspaces();
  }

  Future<void> _fetchWorkspaces() async {
    setState(() => _loading = true);
    try {
      final token = Provider.of<UserProvider>(context, listen: false).token;
      final data = await WorkspaceService.fetchMyWorkspaces(token!);
      setState(() {
        _workspaces = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengambil workspace: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      children: [
        // Header: Logo + Boardify + Create
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 295, maxHeight: 70),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'lib/assets/images/logo unimal.png',
                      height: 50,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'BOARDIFY',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await showTambahWorkspaceDialog(context);
                        await _loadWorkspaces(); // refresh setelah create
                      },
                      child: const Text(
                        'Create',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Judul Workspace + tombol add
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Workspace',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  await showTambahWorkspaceDialog(context);
                  await _loadWorkspaces(); // refresh
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Greeting
        Text(
          'Halo, ${user?.name ?? 'Mahasiswa'}!',
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Daftar Workspace
        if (_loading)
          const Center(child: CircularProgressIndicator())
        else if (_workspaces.isEmpty)
          const Text('Belum ada workspace yang dibuat.')
        else
          ..._workspaces.map(
            (ws) => FutureBuilder<List<BoardModel>>(
              future: BoardService.fetchBoards(
                Provider.of<UserProvider>(context, listen: false).token!,
                ws.id,
              ),
              builder: (context, snapshot) {
                final boards = snapshot.data ?? [];

                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🏢 Nama Workspace
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.apartment_rounded,
                              size: 30,
                              color: Color(0xFF1E88E5),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ws.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // 📋 Daftar Board sebagai Tombol
                      if (snapshot.connectionState == ConnectionState.waiting)
                        const Center(child: CircularProgressIndicator())
                      else if (boards.isEmpty)
                        const Text('Belum ada board')
                      else
                        ...boards.map(
                          (b) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // ❌ HAPUS NAVIGASI DETAIL BOARD
                                  // Awalnya di sini ada push ke DetailBoardPage
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    22,
                                    107,
                                    182,
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  elevation: 0,
                                ),
                                child: Text(
                                  b.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // 🎯 Tombol Create Board
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await showTambahBoardDialog(context, ws.id);
                            setState(() {}); // refresh setelah create
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              22,
                              107,
                              182,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.centerLeft,
                            elevation: 0,
                          ),
                          child: const Text(
                            'Create your board here...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
