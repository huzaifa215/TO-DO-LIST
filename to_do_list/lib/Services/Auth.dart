import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  User get _currentUser => _firebaseAuth.currentUser; // getter that give data

  Future<User> _signInAnonymously() async {

      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
  }

}
