import 'package:flutter/material.dart';
import 'package:hsdk_assignment/Model/user_model.dart';
import 'package:hsdk_assignment/Services/email_auth.dart';
import 'package:hsdk_assignment/Services/google_signin.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  UserModel? _user;

  UserModel? get user => _user;

  AuthProvider() {
    _checkUserLoggedIn();
  }

  // Check if user is already logged in when app starts
  void _checkUserLoggedIn() {
    _user = _authService.getCurrentUser();
    notifyListeners();
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    _user = await _googleAuthService.signInWithGoogle();
    notifyListeners();
  }

  // Sign up with Email & Password
  Future<void> signUp(String email, String password) async {
    _user = await _authService.signUp(email, password);
    notifyListeners();
  }

  // Sign in with Email & Password
  Future<void> signInWithEmail(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }

  // Sign Out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
