import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List image,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user!.uid);
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'bio': '',
        'followers': [],
        'following': [],
      });
      return "valid";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        return "The email is invalid.";
      } else if (e.code == 'operation-not-allowed') {
        return "The operation is not allowed.";
      }
      return "An undefined Error happened.";
    } catch (e) {
      print(e);
      return "An undefined Error happened.";
    }
  }
}
