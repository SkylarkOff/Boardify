import 'package:flutter/material.dart';
import '../../components/custom_appbar.dart';

class MainMahasiswaPage extends StatelessWidget {
  const MainMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(isMahasiswa: true);
  }
}
