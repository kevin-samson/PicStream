import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/size.dart';

class Layout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const Layout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreen;
        } else {
          return mobileScreen;
        }
      },
    );
  }
}
