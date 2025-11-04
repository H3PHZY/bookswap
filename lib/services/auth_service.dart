import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Get instance of Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email & password
  Future<String> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Send email verification
      await userCredential.user?.sendEmailVerification();
      
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occurred.";
    }
  }

  // Sign in with email & password
  Future<String> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occurred.";
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}