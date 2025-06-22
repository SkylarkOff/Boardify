import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../mahasiswa/boards/dashboard.dart';
import '../mahasiswa/activity/activity.dart';
import '../mahasiswa/members/members.dart';
import '../mahasiswa/settings/settings.dart';

class MainMahasiswaPage extends StatefulWidget {
  const MainMahasiswaPage({super.key});

  @override
  State<MainMahasiswaPage> createState() => _MainMahasiswaPageState();
}

class _MainMahasiswaPageState extends State<MainMahasiswaPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardMahasiswa(),
    ActivityMahasiswa(),
    MembersMahasiswa(),
    SettingsMahasiswa(),
  ];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.layoutDashboard),
      label: 'Boards',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.activity),
      label: 'Activity',
    ),
    BottomNavigationBarItem(icon: Icon(LucideIcons.users), label: 'Members'),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.settings),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 🔵 Background biru melengkung
            Container(
              height: 253,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 22, 107, 182),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),

            // 📦 Konten halaman
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: IndexedStack(index: _currentIndex, children: _pages),
              ),
            ),
          ],
        ),

        // 🔽 Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) {
            setState(() => _currentIndex = i);
          },
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: _items,
        ),
      ),
    );
  }
}
