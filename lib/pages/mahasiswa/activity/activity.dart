import 'package:flutter/material.dart';

class ActivityMahasiswa extends StatelessWidget {
  const ActivityMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Text(
            'Aktivitas Terbaru',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.history, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Aktivitas #${index}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text('2 jam lalu'),
              ],
            ),
          );
        }
      },
    );
  }
}
