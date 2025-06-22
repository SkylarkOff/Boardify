import 'package:flutter/material.dart';

class MembersDosen extends StatelessWidget {
  const MembersDosen({super.key});

  @override
  Widget build(BuildContext context) {
    final mahasiswa = [
      'Ahmad Faiz',
      'Dinda Lestari',
      'Rizky Ananda',
      'Putri Ayu',
      'Bagus Pratama',
    ];

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 100),
      itemCount: mahasiswa.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(mahasiswa[index]),
            subtitle: const Text('Status: Aktif'),
            trailing: const Icon(Icons.message),
            onTap: () {
              // TODO: Navigasi ke chat atau detail
            },
          ),
        );
      },
    );
  }
}
