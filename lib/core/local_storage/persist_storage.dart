import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistStorageProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _userId = '';
  String _userToken = '';

  String get userId => _userId;
  String get userToken => _userToken;

  void saveUserId(String userId) async {
    SharedPreferences value = await _pref;

    value.setString('userId', userId);
  }

  void saveUserToken(String userToken) async {
    SharedPreferences value = await _pref;

    value.setString('userToken', userToken);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userToken')) {
      String data = value.getString('userToken')!;
      _userToken = data;
      notifyListeners();
      return data;
    } else {
      _userToken = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('userId')) {
      String data = value.getString('userId')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  void clearPrefs(BuildContext context) async {
    final value = await _pref;
    value.clear();
    // context.go('/signin');
  }
}
