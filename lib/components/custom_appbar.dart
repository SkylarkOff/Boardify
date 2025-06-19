import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/background_biru_container.dart';

import '../pages/mahasiswa/boards/dashboard.dart';
import '../pages/mahasiswa/activity/activity.dart';
import '../pages/mahasiswa/members/members.dart';
import '../pages/mahasiswa/settings/settings.dart';

import '../pages/dosen/boards/dashboard.dart';
import '../pages/dosen/activity/activity.dart';
import '../pages/dosen/members/members.dart';
import '../pages/dosen/settings/settings.dart';

class CustomAppBar extends StatefulWidget {
  final bool isMahasiswa;
  final int initialIndex;

  const CustomAppBar({
    super.key,
    required this.isMahasiswa,
    this.initialIndex = 0,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.isMahasiswa ? _mahasiswaItems : _dosenItems;
    final pages = widget.isMahasiswa ? _mahasiswaPages : _dosenPages;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background biru di atas halaman
          const BackgroundHeaderContainer(height: 253),

          // Halaman aktif
          Positioned.fill(
            child: IndexedStack(index: _currentIndex, children: pages),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
          }
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items:
            items
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _AppBarItem {
  final IconData icon;
  final String label;

  const _AppBarItem({required this.icon, required this.label});
}

// === Mahasiswa ===
const List<_AppBarItem> _mahasiswaItems = [
  _AppBarItem(icon: LucideIcons.layoutDashboard, label: 'Boards'),
  _AppBarItem(icon: LucideIcons.activity, label: 'Activity'),
  _AppBarItem(icon: LucideIcons.users, label: 'Members'),
  _AppBarItem(icon: LucideIcons.settings, label: 'Settings'),
];

const List<Widget> _mahasiswaPages = [
  DashboardMahasiswa(),
  ActivityMahasiswa(),
  MembersMahasiswa(),
  SettingsMahasiswa(),
];

// === Dosen ===
const List<_AppBarItem> _dosenItems = [
  _AppBarItem(icon: LucideIcons.layoutDashboard, label: 'Boards'),
  _AppBarItem(icon: LucideIcons.activity, label: 'Activity'),
  _AppBarItem(icon: LucideIcons.users, label: 'Members'),
  _AppBarItem(icon: LucideIcons.settings, label: 'Settings'),
];

const List<Widget> _dosenPages = [
  DosenDashboard(),
  ActivityDosen(),
  MembersDosen(),
  SettingsDosen(),
];
