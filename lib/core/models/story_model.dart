// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social/core/models/user_model.dart';

class StoryModel {
  final UserModel user;
  final String storyUrl;
  final String uid;
  final DateTime timeOfPost;
  final bool isViewed;
  StoryModel({
    required this.user,
    required this.storyUrl,
    required this.uid,
    required this.timeOfPost,
    this.isViewed = false,
  });

  StoryModel copyWith({
    UserModel? user,
    String? storyUrl,
    String? uid,
    DateTime? timeOfPost,
    bool? isViewed,
  }) {
    return StoryModel(
      user: user ?? this.user,
      storyUrl: storyUrl ?? this.storyUrl,
      uid: uid ?? this.uid,
      timeOfPost: timeOfPost ?? this.timeOfPost,
      isViewed: isViewed ?? this.isViewed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'storyUrl': storyUrl,
      'uid': uid,
      'timeOfPost': timeOfPost.millisecondsSinceEpoch,
      'isViewed': isViewed,
    };
  }

  static StoryModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return StoryModel(
      user: snap['user'],
      storyUrl: snap['storyUrl'],
      timeOfPost: snap['timeOfPost'],
      isViewed: snap['isViewed'],
      uid: snap['uid'],
    );
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      storyUrl: map['storyUrl'] as String,
      uid: map['uid'] as String,
      timeOfPost: DateTime.fromMillisecondsSinceEpoch(map['timeOfPost'] as int),
      isViewed: map['isViewed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoryModel(user: $user, storyUrl: $storyUrl, uid: $uid, timeOfPost: $timeOfPost, isViewed: $isViewed)';
  }

  @override
  bool operator ==(covariant StoryModel other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.storyUrl == storyUrl &&
        other.uid == uid &&
        other.timeOfPost == timeOfPost &&
        other.isViewed == isViewed;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        storyUrl.hashCode ^
        uid.hashCode ^
        timeOfPost.hashCode ^
        isViewed.hashCode;
  }
}
