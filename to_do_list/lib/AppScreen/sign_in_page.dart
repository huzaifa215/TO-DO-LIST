import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TO DO LIST")),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
      ),
      body: BuiltCntext(),
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget BuiltCntext() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sign In',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        RaisedButton(
          child: Text(
            "Sign In with Google",
            style: TextStyle(color: Colors.black87, fontSize: 15.0),
          ),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}
