import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';

abstract class AuthBase {
  // only declare here
  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<User> signInFacebook();

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
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn
        .signIn(); // allow the user and get the user
    if (googleUser != null) {
      // get the token from that we can proceed
      final googleAuht = await googleUser.authentication;
      if (googleAuht.idToken != null) {
        // check we have a google user or not ?
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
  Future<User> signInFacebook() async {
    final fb = FacebookLogin();
    final responce = await fb.logIn(permissions: [
      // alow permission that we can use it
      FacebookPermission.publicProfile,
      FacebookPermission.readPageMailboxes,
      FacebookPermission.userHometown,
      FacebookPermission.email
    ]);
    switch (responce.status) {
      case FacebookLoginStatus.Success:
        final accessToken = responce.accessToken;
        final UserCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token)
        );
        return UserCredential.user;

// if the login cancel
      case FacebookLoginStatus.Cancel:
        throw FirebaseAuthException(
            code: "ERROR_ABROTED_BY_USER",
            message: "Sign in abroted by user"
        );

    // check error if an error occur
      case FacebookLoginStatus.Error:
        throw FirebaseAuthException(
          code: "ERROR_LOGIN_FACEBOOK_FAILED",
          message: responce.error.developerMessage,
        );

      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebook = FacebookLogin();
    await facebook.logOut();
    await _firebaseAuth.signOut();

  }
}
