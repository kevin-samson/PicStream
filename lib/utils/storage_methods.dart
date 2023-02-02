import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePic(
      {required Uint8List image, required String uid}) async {
    try {
      final ref = _storage.ref().child('profileImages/$uid');
      final uploadTask = ref.putData(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<String> uploadPost(
      {required Uint8List image, required String uid}) async {
    try {
      final ref = _storage.ref().child('posts/$uid');
      final uploadTask = ref.putData(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return '';
    }
  }
}
