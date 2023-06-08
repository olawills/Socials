// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postDescription;
  final String uid;
  final String username;
  final String displayPhoto;
  final int likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final int comments;
  final int shares;
  PostModel({
    required this.postDescription,
    required this.uid,
    required this.username,
    required this.displayPhoto,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.comments,
    required this.shares,
  });

  PostModel copyWith({
    String? postDescription,
    String? uid,
    String? username,
    String? displayPhoto,
    int? likes,
    String? postId,
    DateTime? datePublished,
    String? postUrl,
    int? comments,
    int? shares,
  }) {
    return PostModel(
      postDescription: postDescription ?? this.postDescription,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      displayPhoto: displayPhoto ?? this.displayPhoto,
      likes: likes ?? this.likes,
      postId: postId ?? this.postId,
      datePublished: datePublished ?? this.datePublished,
      postUrl: postUrl ?? this.postUrl,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postDescription': postDescription,
      'uid': uid,
      'username': username,
      'displayPhoto': displayPhoto,
      'likes': likes,
      'postId': postId,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'postUrl': postUrl,
      'comments': comments,
      'shares': shares,
    };
  }

  static PostModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return PostModel(
      postDescription: snap['postDescription'],
      uid: snap['uid'],
      username: snap['username'],
      displayPhoto: snap['displayPhoto'],
      likes: snap['likes'],
      postId: snap['postId'],
      datePublished: snap['datePublished'],
      postUrl: snap['postUrl'],
      comments: snap['comments'],
      shares: snap['shares'],
    );
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postDescription: map['postDescription'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      displayPhoto: map['displayPhoto'] as String,
      likes: map['likes'] as int,
      postId: map['postId'] as String,
      datePublished:
          DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
      postUrl: map['postUrl'] as String,
      comments: map['comments'] as int,
      shares: map['shares'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(postDescription: $postDescription, uid: $uid, username: $username, displayPhoto: $displayPhoto, likes: $likes, postId: $postId, datePublished: $datePublished, postUrl: $postUrl, comments: $comments, shares: $shares)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.postDescription == postDescription &&
        other.uid == uid &&
        other.username == username &&
        other.displayPhoto == displayPhoto &&
        other.likes == likes &&
        other.postId == postId &&
        other.datePublished == datePublished &&
        other.postUrl == postUrl &&
        other.comments == comments &&
        other.shares == shares;
  }

  @override
  int get hashCode {
    return postDescription.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        displayPhoto.hashCode ^
        likes.hashCode ^
        postId.hashCode ^
        datePublished.hashCode ^
        postUrl.hashCode ^
        comments.hashCode ^
        shares.hashCode;
  }
}
