import 'package:flutter/material.dart';

import '../../components/background_biru_container.dart';
import '../../components/custom_appbar.dart';

class MainDosenPage extends StatelessWidget {
  const MainDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background tetap di belakang
          const BackgroundHeaderContainer(
            height: 230, // Sesuaikan tinggi background
          ),

          // Konten utama di atas background
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ), // Biar ga nabrak background
            child: CustomAppBar(isMahasiswa: true),
          ),
        ],
      ),
    );
  }
}
