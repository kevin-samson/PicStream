import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Mobile Screen'),
        Text(
            'You are logged in as ${FirebaseAuth.instance.currentUser!.email}'),
        ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Sign out'),
        ),
      ]),
    );
  }
}
