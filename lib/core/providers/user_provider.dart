import 'package:flutter/material.dart';
import 'package:social/core/firebase/authentication.dart';
import 'package:social/core/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final _auth = FirebaseAuthentication();

  UserModel _user = const UserModel(
    firstName: '',
    lastName: '',
    userUid: '',
    email: '',
    followers: [],
    following: [],
  );

  UserModel get getUser {
    return _user;
  }

  Future<void> refreshUser() async {
    UserModel user = await _auth.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
