import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {

  // only declare here
  Stream<User> authStateChanges();
  User get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  // wrapper for firebase AUTH
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges()=>_firebaseAuth.authStateChanges();
  @override
  User get currentUser => _firebaseAuth.currentUser; // getter that give data

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
