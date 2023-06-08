import 'package:flutter/material.dart';
import 'package:social/core/firebase/authentication.dart';
import 'package:social/core/models/exports.dart';

class PostProvider extends ChangeNotifier {
  final _auth = FirebaseAuthentication();

  // StoryModel _story = StoryModel(
  //   username: '',
  //   storyUrl: '',
  //   uid: '',
  //   timeOfPost: DateTime.now(),
  //   profileImage: '',
  // );
  // StoryModel get getStory {
  //   return _story;
  // }

  // Future<void> refreshStories() async {
  //   StoryModel story = await _auth.getStoryDetails();

  //   _story = story;
  //   notifyListeners();
  // }
}
