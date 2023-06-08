// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String userUid;
  final String email;
  final List followers;
  final List following;
  final String? displayPhoto;
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.userUid,
    required this.email,
    required this.followers,
    required this.following,
    this.displayPhoto,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? userUid,
    String? email,
    List<String>? followers,
    List<String>? following,
    String? displayPhoto,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userUid: userUid ?? this.userUid,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      displayPhoto: displayPhoto ?? this.displayPhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userUid': userUid,
      'email': email,
      'followers': followers,
      'following': following,
      'displayPhoto': displayPhoto,
    };
  }

  // Map<String, dynamic> toJson() => {
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'username': firstName,
  //       'uid': userUid,
  //       'email': email,
  //       'followers': [],
  //       'following': [],
  //     };

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      firstName: snap['firstName'],
      lastName: snap['lastName'],
      userUid: snap['userUid'],
      email: snap['email'],
      followers: snap['followers'],
      following: snap['following'],
      displayPhoto: snap['displayPhoto'],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      userUid: map['userUid'] as String,
      email: map['email'] as String,
      followers: List<String>.from((map['followers'] as List<String>)),
      following: List<String>.from((map['following'] as List<String>)),
      displayPhoto:
          map['displayPhoto'] != null ? map['displayPhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, userUid: $userUid, email: $email, followers: $followers, following: $following, displayPhoto: $displayPhoto)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.userUid == userUid &&
        other.email == email &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.displayPhoto == displayPhoto;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        userUid.hashCode ^
        email.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        displayPhoto.hashCode;
  }
}
