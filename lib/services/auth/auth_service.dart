import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class AuthService extends ChangeNotifier{
  //To handle all the methods of authentication.

  //Instance of Auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  //Instance of Firestore DB
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;



  //SIGN IN method
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      //Try to Sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      // After sign in, make a document for the user in the users collection if it doesn't exist.
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid,
            'email':email,
          }, SetOptions(merge: true),
      );
      // End of document creation


      return userCredential;
    }
    //Catch any sign in Errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // End of Sign in method

  //SIGN OUT method
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
  //End of Sign out method


  // Create a new user
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // After user creation, make a document for the user in the users collection.
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid,
        'email':email,
        }
      );
      // End of document creation

      return userCredential;
    }
    //Catch any Errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // End of create user


}
