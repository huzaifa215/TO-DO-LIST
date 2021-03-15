import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.OnSignOut}) : super(key: key);
  final VoidCallback OnSignOut;



  Future<void> _signOut() async {
    try {
      final userCredential = await FirebaseAuth.instance.signOut();
      OnSignOut();
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
        actions: [
          // adding multiple things in the appbar
          FlatButton(
            child: Text(
              "Log Out",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed:_signOut,
          ), // does not have any visible edges
        ],
      ),
    );
  }
}
