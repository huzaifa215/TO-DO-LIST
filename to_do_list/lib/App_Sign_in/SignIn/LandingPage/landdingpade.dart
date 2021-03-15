
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/sign_in_page.dart';

class LanddindgPage extends StatefulWidget {

  @override
  _LanddindgPageState createState() => _LanddindgPageState();
}

class _LanddindgPageState extends State<LanddindgPage> {
  // cehck user here
  User _user;
  @override
  Widget build(BuildContext context) {
    if(_user==null) {
      return SignInPage();
    }
    return Container();// Temporary placeholder for homepage
  }
}
