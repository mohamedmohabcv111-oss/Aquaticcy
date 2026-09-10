import 'package:aquaticcy/pages/Login.dart';
import 'package:aquaticcy/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 84, 178, 255),
              ),
            );
          } 
          
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'ERROR HAS OCCURRED',
                style: TextStyle(
                  fontFamily: 'PixelifySans',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111921),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return const Home();
          }else{
            return const Login();
          }

          
        },
      ),
    );
  }
}
