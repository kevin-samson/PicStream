import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/storage_methods.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _image;
  final _captionController = TextEditingController();
  bool _isLoading = false;

  void _postImage(String uid, String username, String photoUrl) async {
    try {
      setState(() {
        _isLoading = true;
        FocusScope.of(context).unfocus();
      });
      await StorageMethods().uploadPost(
          uid: uid,
          caption: _captionController.text,
          image: _image!,
          username: username,
          profileImage: photoUrl);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Post added successfully'),
      ));
      setState(() {
        _isLoading = false;
        _image = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Photo with Camera'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final ImagePicker imagePicker = ImagePicker();
                  final XFile? image = await imagePicker.pickImage(
                    source: ImageSource.camera,
                  );
                  Uint8List img = await image!.readAsBytes();
                  setState(() {
                    _image = img;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Image from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final ImagePicker imagePicker = ImagePicker();
                  final XFile? image = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  Uint8List img = await image!.readAsBytes();
                  setState(() {
                    _image = img;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
          automaticallyImplyLeading: false,
          backgroundColor: mobileBackgroundColor,
          actions: [
            TextButton(
                onPressed: _image == null
                    ? null
                    : () {
                        _postImage(user.uid!, user.username, user.profilePic);
                      },
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
        body: _image == null
            ? Center(
                child: IconButton(
                    onPressed: () {
                      _selectImage(context);
                    },
                    icon: const Icon(Icons.add_a_photo)))
            : SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _isLoading
                          ? const LinearProgressIndicator()
                          : const SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: _captionController,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 30),
                          decoration: const InputDecoration(
                              hintText: "Write a caption...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Image.memory(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
