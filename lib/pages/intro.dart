import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/route_names.dart';
import '../providers/user_provider.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dan Judul
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/logo unimal.png',
                      height: 64,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Boardify",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Badge LMS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(222, 246, 232, 183),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(185, 120, 67, 3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('lib/assets/icons/medal.png', height: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "LEARNING MANAGEMENT SYSTEM",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 222, 124, 5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Judul
                const Text(
                  "LMS Help Community",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Banner
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 43,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 210, 92, 198),
                        Color.fromARGB(255, 247, 48, 108),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Work Forward.",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Deskripsi
                const Text(
                  "Berkolaborasi, mengelola proyek, dan mencapai puncak produktivitas baru, dari kantor rumah, cara tim Anda bekerja adalah unik - capai semuanya di Task Management Community.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 100, 106, 117),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Tombol Login Manual
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(126, 21, 229, 97),
                        Color.fromARGB(255, 31, 121, 200),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final userProvider = Provider.of<UserProvider>(
                        context,
                        listen: false,
                      );

                      // Check if user is already logged in
                      if (userProvider.isLoggedIn &&
                          userProvider.user != null) {
                        final role = userProvider.user!.role;
                        debugPrint('User already logged in. Role: $role');

                        switch (role) {
                          case 'mahasiswa':
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.mainMahasiswa,
                            );
                            break;
                          case 'dosen':
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.mainDosen,
                            );
                            break;
                        }
                      } else {
                        Navigator.pushNamed(context, RouteNames.loginStepEmail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      "Bergabung di LMS UNIMAL",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
