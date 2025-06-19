import 'package:flutter/material.dart';
import '../pages/intro.dart';
import '../pages/auth/login_step_email.dart';
import '../pages/auth/regis.dart';

// Main pages
import '../pages/mahasiswa/main.dart';
import '../pages/dosen/main.dart';

import 'route_names.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // Auth
  RouteNames.intro: (_) => const Intro(),
  RouteNames.loginStepEmail: (_) => const LoginStepEmail(),
  RouteNames.register: (_) => const RegisPage(),

  // Mahasiswa Main Page
  RouteNames.mainMahasiswa: (_) => const MainMahasiswaPage(),

  // Dosen Main Page
  RouteNames.mainDosen: (_) => const MainDosenPage(),
};
