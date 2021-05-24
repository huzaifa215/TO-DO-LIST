import 'package:flutter/material.dart';
import 'package:to_do_list/Common_widgets/ShowAlertDialog.dart';
import 'package:to_do_list/Services/Auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.auth}) : super(key: key);

//  final VoidCallback OnSignOut;

  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      // OnSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSigout = await showAlertDialog(
      context,
      title: "LogOut",
      content: "Are you sure that you want to logout",
      defaultActionText: "Logout",
      cancelActionText: "Cancel",
    );
    if(didRequestSigout == true){
      _signOut();
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
            onPressed:() => _confirmSignOut(context),
          ), // does not have any visible edges
        ],
      ),
    );
  }
}
