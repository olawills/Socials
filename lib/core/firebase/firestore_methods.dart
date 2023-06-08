import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/core/firebase/firebase_storage.dart';
import 'package:social/core/models/exports.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _storageManager = FirebaseStorageManager();
  bool _isLoading = false;

  String _errorResponse = 'Something went wrong please try again later';
  String get errorResponse => _errorResponse;
  bool get isLoading => _isLoading;

  Future<String> uploadPosts(
    String desc,
    File? file,
    String id,
    String username,
    String profileImage,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      String postUrl =
          await _storageManager.uploadPostsToStorage('posts', file!);
      String postId = const Uuid().v1();

      PostModel posts = PostModel(
        postDescription: desc,
        uid: id,
        username: username,
        displayPhoto: profileImage,
        likes: 0,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        comments: 0,
        shares: 0,
      );
      _firebaseFirestore.collection('posts').doc(postId).set(posts.toMap());
      _isLoading = false;
      _errorResponse = 'Posted!...';
      notifyListeners();
    } catch (e) {
      _errorResponse = e.toString();
      notifyListeners();
    }
    return _errorResponse;
  }

  Future<String> uploadStories(
      DateTime time, String image, UserModel user) async {
    try {
      _isLoading = true;
      notifyListeners();
      String storyUrl =
          await _storageManager.uploadStoriesToStorage('stories', image);
      String storyId = const Uuid().v1();

      final storiesData = StoryModel(
        user: user,
        storyUrl: storyUrl,
        timeOfPost: time,
        uid: storyId,
      );
      _firebaseFirestore
          .collection('stories')
          .doc(storyId)
          .set(storiesData.toMap());
      _isLoading = false;
      _errorResponse = 'Posted!...';
      notifyListeners();
    } catch (e) {
      _errorResponse = e.toString();
      notifyListeners();
    }
    return _errorResponse;
  }
}
