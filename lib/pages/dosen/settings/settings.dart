import 'package:flutter/material.dart';
import '../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class SettingsDosen extends StatelessWidget {
  const SettingsDosen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 100),
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Keluar'),
          onTap: () async {
            await userProvider.logout();
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/loginStepEmail');
            }
          },
        ),
      ],
    );
  }
}
