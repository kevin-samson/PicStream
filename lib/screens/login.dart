import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/widgets/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        // SvgPicture.asset(
        //   "assets/ic_instagram.svg",
        //   color: primaryColor,
        //   height: 64,
        // ),
        Text('PicStream', style: GoogleFonts.grandHotel(fontSize: 64)),
        const SizedBox(height: 64),
        NewTextInput(
            textEditingController: _emailField,
            hintText: "Enter your email",
            textInputType: TextInputType.emailAddress),
        const SizedBox(height: 24),
        NewTextInput(
            textEditingController: _passwordField,
            hintText: "Enter your password",
            textInputType: TextInputType.text,
            obscureText: true),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 13)),
            ),
            onPressed: () {},
            child: const Text("Sign In"),
          ),
        ),
        const SizedBox(height: 12),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {},
              child: const Text("Sign Up"),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      ],
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: column,
                )),
          ),
        ),
      ),
    );
  }
}
