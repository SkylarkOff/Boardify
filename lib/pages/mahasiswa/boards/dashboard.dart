import 'package:flutter/material.dart';

class DashboardMahasiswa extends StatelessWidget {
  const DashboardMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Dashboard Mahasiswa',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
