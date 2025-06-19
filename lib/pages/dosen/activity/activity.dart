import 'package:flutter/material.dart';

class ActivityDosen extends StatelessWidget {
  const ActivityDosen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Aktivitas Dosen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
