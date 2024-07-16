import 'package:flutter/material.dart';

enum AuthStatus { uninitialized, authenticated, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;

 
  Future<void> signIn(String email, String password) async {
    _status = AuthStatus.authenticating;
    notifyListeners();

   
    await Future.delayed(Duration(seconds: 2));

    // Assuming successful authentication for demonstration
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    _status = AuthStatus.authenticating;
    notifyListeners();

   
    await Future.delayed(Duration(seconds: 2));

    // Assuming successful registration for demonstration
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  void signOut() {
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
