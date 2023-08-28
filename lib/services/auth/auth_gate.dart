import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/HomePage.dart';
import 'login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Listen to changes in the authentication state using FirebaseAuth's stream
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // Check if there is data
          //user logged in
          if(snapshot.hasData){
            return const HomePage();
          }
          //user not logged in
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
