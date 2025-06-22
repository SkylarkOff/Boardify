import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'components/opsi.dart';

class SettingsMahasiswa extends StatelessWidget {
  const SettingsMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 82, 20, 24),
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 100),

        // 🔐 Account button
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 82,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF1E88E5)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.black),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                OpsiPopup(
                  items: [
                    [
                      OpsiItem(value: 'profile', label: 'Profile'),
                      OpsiItem(value: 'security', label: 'Security'),
                    ],
                  ],
                  onSelected: (value) {
                    // Aksi saat opsi Account dipilih
                    if (value == 'profile') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile selected')),
                      );
                    } else if (value == 'security') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Security selected')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),

        // 🏢 Organization button
        Container(
          height: 82,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF1E88E5)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.apartment_rounded, color: Colors.black),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Organization',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                OpsiPopup(
                  items: [
                    [
                      OpsiItem(value: 'general', label: 'General'),
                      OpsiItem(value: 'members', label: 'Members'),
                    ],
                  ],
                  onSelected: (value) {
                    // Aksi saat opsi Organization dipilih
                    if (value == 'general') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('General selected')),
                      );
                    } else if (value == 'members') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Members selected')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
