// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'user_model.dart';

class ChatUsersModel {
  final String name;
  final String messages;
  final String id;
  final UserModel displayPhoto;
  ChatUsersModel({
    required this.name,
    required this.messages,
    required this.id,
    required this.displayPhoto,
  });

  ChatUsersModel copyWith({
    String? name,
    String? messages,
    String? id,
    UserModel? displayPhoto,
  }) {
    return ChatUsersModel(
      name: name ?? this.name,
      messages: messages ?? this.messages,
      id: id ?? this.id,
      displayPhoto: displayPhoto ?? this.displayPhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'messages': messages,
      'id': id,
      'displayPhoto': displayPhoto.toMap(),
    };
  }

  factory ChatUsersModel.fromMap(Map<String, dynamic> map) {
    return ChatUsersModel(
      name: map['name'] as String,
      messages: map['messages'] as String,
      id: map['id'] as String,
      displayPhoto:
          UserModel.fromMap(map['displayPhoto'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUsersModel.fromJson(String source) =>
      ChatUsersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatUsersModel(name: $name, messages: $messages, id: $id, displayPhoto: $displayPhoto)';
  }

  @override
  bool operator ==(covariant ChatUsersModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.messages == messages &&
        other.id == id &&
        other.displayPhoto == displayPhoto;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        messages.hashCode ^
        id.hashCode ^
        displayPhoto.hashCode;
  }
}
