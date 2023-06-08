import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social/core/local_storage/persist_storage.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/ui/shared/utils/navigation.dart';

final _firestore = FirebaseFirestore.instance;
final reference = _firestore.collection('users');

class FirebaseAuthentication with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final logger = Logger();
  bool _isLoading = false;
  // bool _isVerified = false;

  String _errorResponse = 'Something went wrong please try again later';
  String get errorResponse => _errorResponse;
  bool get isLoading => _isLoading;
  // bool get isVerified => _isVerified;
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await reference.doc(currentUser.uid).get();
    return UserModel.fromSnapshot(snapshot);
  }

  Future<StoryModel> getStoryDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await reference.doc(currentUser.uid).get();
    return StoryModel.fromSnapshot(snapshot);
  }

  // Sign Up function
  Future<String> signUpUsers(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        _isLoading = false;
        _errorResponse = 'Account successfully created';
        notifyListeners();
        logger.i(userCred.user!);
        UserModel user = UserModel(
          firstName: firstName,
          lastName: lastName,
          userUid: userCred.user!.uid,
          email: email,
          followers: [],
          following: [],
        );
        await reference.doc(userCred.user!.uid).set(user.toMap());
        final dbUser = userCred.user!.uid;
        final userToken = userCred.user!.email;
        PersistStorageProvider().saveUserId(dbUser);
        PersistStorageProvider().saveUserToken(userToken!);
        // ignore: use_build_context_synchronously
        NavigationData.moveToUploadView(context);
        _isLoading = false;
        logger.d(_errorResponse);
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'inavlid-email') {
        _errorResponse = 'The email is incorect';
        _isLoading = false;
        notifyListeners();
      } else if (e.code == 'weak-password') {
        _errorResponse = 'The Passsword should be at least 8 characters';
        _isLoading = false;
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        _errorResponse =
            'Email already in use, try again with a different email';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorResponse = 'Something went wrong please try again later';
      _isLoading = false;
      notifyListeners();
    }
    return _errorResponse;
  }

  Future<String> loginUsers(
      {required String email,
      required password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        logger.i(cred);
        _isLoading = false;
        _errorResponse = 'Successfully logged in';
        final dbUser = cred.user!.uid;
        final userEmail = cred.user!.email;
        PersistStorageProvider().saveUserId(dbUser);
        PersistStorageProvider().saveUserToken(userEmail!);
        // ignore: use_build_context_synchronously
        NavigationData.moveToFeatures(context);
        _isLoading = false;
        logger.d(_errorResponse);
        notifyListeners();
      } else {
        _isLoading = false;
        _errorResponse = 'All fields are required';
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _isLoading = false;
        _errorResponse = 'invalid email';
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        _isLoading = false;
        _errorResponse = 'incorrect password check and try again..';

        notifyListeners();
      } else if (e.code == 'user-not-found') {
        _isLoading = false;
        _errorResponse = 'Account not found go to sign up to create an account';
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _errorResponse = 'check your internet connection';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorResponse = e.toString();
      notifyListeners();
    }
    return '';
  }

  void resetResponse() {
    _errorResponse = '';
    notifyListeners();
  }
}
