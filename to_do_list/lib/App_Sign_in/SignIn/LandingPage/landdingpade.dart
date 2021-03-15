
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';
import 'package:to_do_list/App_Sign_in/SignIn/sign_in_page.dart';

class LanddindgPage extends StatefulWidget {

  @override
  _LanddindgPageState createState() => _LanddindgPageState();
}

class _LanddindgPageState extends State<LanddindgPage> {
  // cehck user here
  User _user;
  void _updateUser(User user){
   setState(() {
     _user=user;
   });
  }
  @override
  Widget build(BuildContext context) {
    if(_user==null) {
      return SignInPage(
        onSignIn:_updateUser,
      );
    }
    return HomePage(
      OnSignOut: ()=> _updateUser(null),
    );// Temporary placeholder for homepage
  }
}
