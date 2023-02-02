import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Mobile Screen'),
        Text(
            'You are logged in as ${FirebaseAuth.instance.currentUser!.email}'),
        ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Sign out'),
        ),
      ])),
    );
  }
}
