import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../routes/route_names.dart';

class SettingsMahasiswa extends StatelessWidget {
  const SettingsMahasiswa({super.key});

  void _logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.logout(); // hapus data user
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.loginStepEmail,
      (route) => false, // hapus semua route sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Pengaturan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),

          // Contoh item pengaturan lain
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Ubah Password'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur belum tersedia')),
              );
            },
          ),
          const Divider(),

          // Tombol Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
