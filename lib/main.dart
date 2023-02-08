import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/layout.dart';
import 'package:instagram_clone/responsive/mobile_screen.dart';
import 'package:instagram_clone/responsive/web_screen.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            primaryColor: primaryColor,
          ),
          home: const _HomePage()),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // return const Layout(
            //     mobileScreen: MobileScreen(), webScreen: WebScreen());
            Future.delayed(Duration.zero, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const Layout(
                          mobileScreen: MobileScreen(),
                          webScreen: WebScreen())));
            });
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Login()));
            });
          }
        }
        return Container();
      },
    );
  }
}
