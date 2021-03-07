import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/Sign_in_button.dart';
import 'package:to_do_list/Common_widgets/custom_raised_button.dart';

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
        SignInButton(
          text: "Sign In with Google",
          textColor: Colors.black87,
          color: Colors.white,
          onpressed: (){},
        ),
        // CustomRaisedButton(
        //   child: Text(
        //     "Sign In with Facebook",
        //     style: TextStyle(color: Colors.black87, fontSize: 15.0),
        //   ),
        //   color: Colors.blue,
        //   radius: 4.0,
        //   OnPressed: () {},
        // )
      ],
    ),
  );
}

