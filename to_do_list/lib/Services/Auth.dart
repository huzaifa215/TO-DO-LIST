import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';


abstract class AuthBase {
  // only declare here
  User get currentUser;

  Stream<User> authStateChanges();

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<User> signInFacebook();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> CreateUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {

  // wrapper for firebase AUTH
  final _firebaseAuth = FirebaseAuth.instance;


  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
 // bool _sdkInitialized = false;

  @override
  User get currentUser => _firebaseAuth.currentUser; // getter that give data

  // Future<void> _initSdk() async {
  //   await widget.plugin.initSdk('7503887');
  //   _sdkInitialized = true;
  //   await _updateLoginInfo();
  // }
  //
  // Future<void> _getSdkVersion() async {
  //   final sdkVersion = await widget.plugin.sdkVersion;
  //   setState(() {
  //     _sdkVersion = sdkVersion;
  //   });
  // }

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
    final googleUser =
        await googleSignIn.signIn(); // allow the user and get the user
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
            FacebookAuthProvider.credential(accessToken.token));
        return UserCredential.user;

// if the login cancel
      case FacebookLoginStatus.Cancel:
        throw FirebaseAuthException(
            code: "ERROR_ABROTED_BY_USER", message: "Sign in abroted by user");

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

  // sign in with email and password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final usercredentials = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return usercredentials.user;
  }

  // Create account with email and password
  @override
  Future<User> CreateUserWithEmailAndPassword(
      String email, String password) async {
    final usercredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return usercredentials.user;
  }
// TODO: VK loGin

//   Future<User> LoginWithVk() async{
//     // Create an instance of VKLogin
//     final vk = VKLogin();
//     final fb = FacebookLogin();
//
// // Initialize
//     await vk.initSdk('7813504');
//
// // Log in
//     final res = await vk.logIn(scope: [
//       VKScope.email,
//       VKScope.friends,
//     ]);
//
//     // Check result
//     if (res.isValue) {
//       // There is no error, but we don't know yet
//       // if user loggen in or not.
//       // You should check isCanceled
//       final VKLoginResult data = res.asValue.value;
//
//       if (res.isError) {
//         // User cancel log in
//         print("failed");
//       } else {
//         // Logged in
//         // Send access token to server for validation and auth
//         final accessToken = res.accessToken;
//         print('Access token: ${accessToken.token}');
//
//         // Get profile data
//         final profile = await fb.getUserProfile();
//         print('Hello, ${profile.firstName}! You ID: ${profile.userId}');
//
//         // Get email (since we request email permissions)
//         final email = await fb.getUserEmail();
//         print('And your email is $email');
//
//         final UserCredential = await _firebaseAuth.signInWithCredential(
//             FacebookAuthProvider.credential(accessToken.token));
//         return UserCredential.user;
//
//       }
//     } else {
//       // Log in failed
//       final errorRes = res.asError;
//       print('Error while log in: ${errorRes.error}');
//     }
//   }



  @override
  Future<void> signOut() async {
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    // final facebook = FacebookLogin();
    // await facebook.logOut();
    await _firebaseAuth.signOut();
  }
}
