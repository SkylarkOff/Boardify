import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'boards/dashboard.dart';
import 'activity/activity.dart';
import 'members/members.dart';
import 'settings/settings.dart';

class MainDosenPage extends StatefulWidget {
  const MainDosenPage({super.key});

  @override
  State<MainDosenPage> createState() => _MainDosenPageState();
}

class _MainDosenPageState extends State<MainDosenPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DosenDashboard(),
    ActivityDosen(),
    MembersDosen(),
    SettingsDosen(),
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
    return Scaffold(
      body: Stack(
        children: [
          // Background biru
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 22, 107, 182),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

          // Konten aktif
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IndexedStack(index: _currentIndex, children: _pages),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: _items,
      ),
    );
  }
}
