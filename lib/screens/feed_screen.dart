import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: Center(
        child: Text('Feed Page'),
      ),
    );
  }
}
