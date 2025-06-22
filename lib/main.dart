import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/app_routes.dart';
import 'routes/route_names.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Cek token dan role dari SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final role = prefs.getString('role');

  // Tentukan initial route
  String initialRoute;

  if (token != null && role != null) {
    if (role == 'mahasiswa') {
      initialRoute = RouteNames.mainMahasiswa;
    } else if (role == 'dosen') {
      initialRoute = RouteNames.mainDosen;
    } else {
      initialRoute = RouteNames.intro;
    }
  } else {
    initialRoute = RouteNames.intro;
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boardify Mobile',
      theme: ThemeData(useMaterial3: true),
      initialRoute: initialRoute,
      routes: appRoutes,
    );
  }
}
