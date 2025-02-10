import 'package:firebase_auth/firebase_auth.dart';
import 'package:hsdk_assignment/Model/user_model.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email & Password
  Future<UserModel?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Convert Firebase User to UserModel
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Sign In with Email & Password
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Convert Firebase User to UserModel
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get Current User
  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}
