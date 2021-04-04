import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign In")),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(child: EmailSignInForm()
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
