import 'package:aquaticcy/pages/Login.dart';
import 'package:aquaticcy/pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aquaticcy/pages/Leaderboard.dart';
import 'pages/home.dart';
import 'Auth/Wrapper.dart';
import 'routes/approutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
      routes: {
        AppRoutes.login: (context) => const Login(),
        AppRoutes.home: (context) => const Home(),
        AppRoutes.leaderboard: (context) => const Leaderboard(),
        AppRoutes.profile:(context)=> const Profile(),
      },
    );
  }
}
