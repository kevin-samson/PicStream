import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/utils/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getCurrentUser() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    if (documentSnapshot.data() != null) {
      return model.User.fromJson(
          documentSnapshot.data() as Map<String, dynamic>, currentUser.uid);
    } else {
      return model.User(
        username: '',
        email: '',
        bio: '',
        profilePic: '',
        followers: [],
        following: [],
      );
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List? image,
  }) async {
    final ByteData bytes = await rootBundle.load('assets/placeholder.png');
    final Uint8List list = bytes.buffer.asUint8List();
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String photourl = await StorageMethods().uploadProfilePic(
          image: image ?? list, uid: userCredential.user!.uid);

      _firestore.collection('users').doc(userCredential.user!.uid).set(
            model.User(
              username: username,
              email: email,
              bio: '',
              profilePic: photourl,
              followers: [],
              following: [],
            ).toJson(),
          );

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
      return "An undefined Error happened.";
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "valid";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else if (e.code == 'invalid-email') {
        return "The email is invalid.";
      } else if (e.code == 'operation-not-allowed') {
        return "The operation is not allowed.";
      }
      return "An undefined Error happened.";
    } catch (e) {
      return "An undefined Error happened.";
    }
  }
}
