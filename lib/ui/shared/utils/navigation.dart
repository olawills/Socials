import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationData {
  static moveToFeatures(BuildContext context) {
    context.go('/features');
  }

  static moveToOtpView(BuildContext context) {
    context.go('/otp');
  }

  static moveToUploadView(BuildContext context) {
    context.go('/uploads');
  }

  static pushToResetPassword(BuildContext context) {
    context.push('/forgot-password');
  }

  static pushToSignup(BuildContext context) {
    context.push('/signup');
  }

  static pushTologin(BuildContext context) {
    context.push('/signin');
  }

  static pushToMessageView(BuildContext context) {
    context.push('/message');
  }

  static pushToStoryView(BuildContext context) {
    context.push('/story');
  }

  static pushToProfileView(BuildContext context) {
    context.push('/profile');
  }

  static pushToChatView(BuildContext context) {
    context.push('/chat');
  }

  static pushToCreatePostView(BuildContext context) {
    context.push('/create-post');
  }

  static pushToCreateStoryView(BuildContext context) {
    context.push('/story-post');
  }

  static pushBack(BuildContext context) {
    context.pop();
  }
}
