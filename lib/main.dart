import 'package:auth_app_2/firebase_options.dart';
import 'package:auth_app_2/services/auth/auth_gate.dart';
import 'package:auth_app_2/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  //async, cause there's an await inside method

  // Ensure initializing flutter mechanics, to avoid any initialization-related issues
  WidgetsFlutterBinding.ensureInitialized(); // ?
  // Wait until Firebase is fully initialized
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}