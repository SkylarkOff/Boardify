import 'package:flutter/material.dart';

class MembersDosen extends StatelessWidget {
  const MembersDosen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Mahasiswa Bimbingan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
