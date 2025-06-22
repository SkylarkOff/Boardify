import 'package:flutter/material.dart';

class ActivityDosen extends StatelessWidget {
  const ActivityDosen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 100),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text('Mahasiswa X mengirim revisi ke-${index + 1}'),
          subtitle: const Text('20 Juni 2025, 09:00'),
        );
      },
    );
  }
}
