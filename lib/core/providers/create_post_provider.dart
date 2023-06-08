import 'package:flutter/material.dart';

class CreatePostProvider extends ChangeNotifier {
  bool _isLastPage = false;

  bool get isLastPage => _isLastPage;

  set isLastPage(bool lastpage) {
    _isLastPage = lastpage;
    // pageController = PageController();
    notifyListeners();
  }
}
