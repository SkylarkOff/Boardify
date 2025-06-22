import 'package:flutter/material.dart';

class MembersMahasiswa extends StatelessWidget {
  const MembersMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Text(
            'Anggota Board',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('U${index}'),
            ),
            title: Text('Mahasiswa ${index}'),
            subtitle: const Text('mahasiswa@email.com'),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              // TODO: Aksi lebih lanjut
            },
          );
        }
      },
    );
  }
}
