import 'package:flutter/material.dart';

class ActivityMahasiswa extends StatelessWidget {
  const ActivityMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Aktivitas Mahasiswa',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
