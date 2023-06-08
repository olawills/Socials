import 'package:flutter/material.dart';

class FeaturesProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool isVisible = true;

  bool _reverse = false;
  bool get reverse => _reverse;

  set newIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  void show() {
    if (!isVisible) {
      isVisible = true;
      notifyListeners();
    }
  }

  void hide() {
    if (isVisible) {
      isVisible = false;
      notifyListeners();
    }
  }

  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }
}
