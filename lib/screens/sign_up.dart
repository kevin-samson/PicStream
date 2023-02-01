import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/auth_methods.dart';
import 'package:instagram_clone/widgets/text_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    _usernameField.dispose();
    _confirmPasswordField.dispose();
  }

  // function to validate email
  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!value.contains("@")) {
      return "Please enter a valid email";
    }
    return null;
  }

  // function to check if both passwords match
  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value != _confirmPasswordField.text) {
      return "Passwords do not match";
    }
    return null;
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
          // SvgPicture.asset(
          //   "assets/ic_instagram.svg",
          //   color: primaryColor,
          //   height: 64,
          // ),
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
              errorText: _validateEmail(_emailField.text),
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
          NewTextInput(
              errorText: _validatePassword(_passwordField.text),
              textEditingController: _confirmPasswordField,
              hintText: "Confirm your password",
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AuthMethods().signUpUser(
                      email: _emailField.text,
                      password: _passwordField.text,
                      username: _usernameField.text,
                      image: _image!);
                }
              },
              child: const Text("Sign Up"),
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
                onPressed: () {},
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
                height: MediaQuery.of(context).size.height + 24,
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
