import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  // only declare here
  Stream<User> authStateChanges();

  User get currentUser;

  Future<User> signInAnonymously();
  Future<User> sinInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  // wrapper for firebase AUTH
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser; // getter that give data

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  // request for token ,
  // token return,
  // send that token to firebase to store ,
  // the firebase than the user
  @override
  Future<User> sinInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser =
        await googleSignIn.signIn(); // allow the user and get the user
    if (googleUser != null) {
      // get the token from that we can proceed
      final googleAuht = await googleUser.authentication;
      if (googleAuht.idToken != null) {
        final userCredentioal = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuht.idToken,
                accessToken: googleAuht.accessToken));
        return userCredentioal.user;
      } else {
        throw FirebaseAuthException(
            code: "ERROR_MISSING_GOOGLE_ID_TOKEN",
            message: "missing google id token");
      }
    } else {
      //throw the excption
      throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user");
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
