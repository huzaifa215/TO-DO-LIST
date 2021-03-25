import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';
import 'package:to_do_list/App_Sign_in/SignIn/sign_in_page.dart';
import 'package:to_do_list/Services/Auth.dart';

class LanddindgPage extends StatefulWidget {
  final AuthBase auth;

  const LanddindgPage({Key key, this.auth}) : super(key: key);
  @override
  _LanddindgPageState createState() => _LanddindgPageState();
}

class _LanddindgPageState extends State<LanddindgPage> {
  // cehck user here
  User _user;// current user details status

  @override
  void _updateUser(User user) {
    try {
      setState(() {
        // setstate is used here because it is the parent of (home and sign up)
        // child widget it automatically update the both
        // pages and pass date from here to all the child widgets
        // the all the child rebuilt them automatically only by calling the setstate method in the parent 
        _user = user;
      });
    } catch (e, s) {
      print(s);
    }
  }

  // check the user login or not
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth:widget.auth,
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth:widget.auth,
      OnSignOut: () => _updateUser(null),
    ); // Temporary placeholder for homepage
  }
}
