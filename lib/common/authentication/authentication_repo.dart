import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLogin => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authState() => _firebaseAuth.authStateChanges();

  Future<void> userSignup(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> userLogout() async {
    await _firebaseAuth.signOut();
  }

  Future<void> userLogin(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> githubLogin() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepo());

final authState = StreamProvider((ref) => ref.watch(authRepo).authState());
