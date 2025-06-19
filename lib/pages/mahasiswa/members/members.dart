import 'package:flutter/material.dart';

class MembersMahasiswa extends StatelessWidget {
  const MembersMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Anggota Bimbingan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
