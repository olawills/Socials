import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social/core/firebase/authentication.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageManager with ChangeNotifier {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  String _message = '';
  bool _status = false;
  String get message => _message;
  bool get status => _status;
  void resetMessage() {
    _message = '';
    notifyListeners();
  }

  Future<String> uploadPicturesToStorage(
    String? userId,
    File? image,
  ) async {
    _status = true;
    notifyListeners();

    String imagePath = '';
    try {
      final imgName = image!.path.split('/').last;
      final stores = '$userId/displayPicture/$imgName';
      await _storage.ref().child(stores).putFile(image).whenComplete(() async {
        await _storage.ref().child(stores).getDownloadURL().then((value) {
          imagePath = value;
        });
      });
      final addToFirebase = {
        'displayPhoto': imagePath,
      };
      await reference.doc(userId).update(addToFirebase);
      _status = false;
      _message = 'Succesfully created account';
      notifyListeners();
    } on FirebaseException catch (e) {
      _status = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (_) {
      _status = false;
      _message = 'Check your internet and try again..';
      notifyListeners();
    } catch (e) {
      _status = false;
      _message = 'Please try again...';
      notifyListeners();
    }
    return _message;
  }

  Future<String> uploadPostsToStorage(String childName, File image) async {
    _status = true;
    notifyListeners();
    String postId = const Uuid().v1();
    Reference ref = _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid)
        .child(postId);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    _status = false;
    _message = 'Succesfully Uploaded';
    return downloadUrl;
  }

  Future<String> uploadStoriesToStorage(String childName, String image) async {
    _status = true;
    notifyListeners();
    String storyId = const Uuid().v1();
    Reference ref = _storage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid)
        .child(storyId);

    UploadTask uploadTask = ref.putFile(File(image));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    _status = false;
    _message = 'Succesfully Uploaded';
    return downloadUrl;
  }
}
