import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social/app/logger.dart';
import 'package:social/core/models/exports.dart';

class FirebaseStoryMethod {
  static const String stories = "stories";
  final firestore =
      FirebaseFirestore.instance.collection('stories').snapshots();

  static Future<bool> updateStory(StoryModel story, bool isViewed) async {
    try {
      // firestore.document(story.uid).updateData({"isSeen": isSeen});
      // return true;
      FirebaseFirestore.instance
          .collection('stories')
          .doc(story.uid)
          .update({"isViewed": isViewed});
      return true;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
