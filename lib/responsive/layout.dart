import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/size.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const Layout(
      {super.key, required this.mobileScreen, required this.webScreen});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return widget.webScreen;
        } else {
          return widget.mobileScreen;
        }
      },
    );
  }
}
