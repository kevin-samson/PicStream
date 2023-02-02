import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/utils/auth_methods.dart';
import 'package:instagram_clone/widgets/text_input.dart';

import '../responsive/layout.dart';
import '../responsive/mobile_screen.dart';
import '../responsive/web_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _usernameField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    _usernameField.dispose();
  }

  //function to pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Uint8List img = await image!.readAsBytes();
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    var column = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Text('PicsStream', style: GoogleFonts.grandHotel(fontSize: 64)),
          const SizedBox(height: 10),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/placeholder.png'),
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_a_photo),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          NewTextInput(
              textEditingController: _usernameField,
              hintText: "Enter your username",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
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
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                String? res;
                if (_formKey.currentState!.validate()) {
                  res = await AuthMethods().signUpUser(
                      email: _emailField.text.toString(),
                      password: _passwordField.text.toString(),
                      username: _usernameField.text.toString(),
                      image: _image);
                  setState(() {
                    _isLoading = false;
                  });
                  if (res != "valid") {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(res),
                      ),
                    );
                  } else {
                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Layout(
                            mobileScreen: MobileScreen(),
                            webScreen: WebScreen())));
                  }
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text("Sign In"),
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
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text("Sign In"),
              ),
            ],
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 24,
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
