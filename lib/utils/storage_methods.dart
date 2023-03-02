import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadProfilePic(
      {required Uint8List image, required String uid}) async {
    try {
      final ref = _storage.ref().child('profileImages/$uid');
      final uploadTask = ref.putData(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> uploadPost(
      {required Uint8List image,
      required String uid,
      required String caption,
      required String username,
      required String profileImage}) async {
    try {
      String postId = const Uuid().v4();
      final ref = _storage.ref().child('posts').child(uid).child(postId);
      final uploadTask = ref.putData(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();

      Post post = Post(
        caption: caption,
        imageUrl: url,
        uid: uid,
        username: username,
        date: DateTime.now(),
        profileImg: profileImage,
        likes: [],
      );

      await _firestore.collection('posts').doc(postId).set(post.toMap());

      return url;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> likePost(String postID, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
