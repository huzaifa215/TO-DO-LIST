import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/Sign_in_button.dart';
import 'package:to_do_list/App_Sign_in/social_signin_button.dart';
import 'package:to_do_list/Common_widgets/custom_raised_button.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print('${userCredential.user.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

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
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign In with Google",
            textColor: Colors.black87,
            color: Colors.white,
            image: "images/google-logo.png",
            onpressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            // constructor passing value
            onpressed: () {},
            image: "images/facebook-logo.png",
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700], // constructor passing value
            onpressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "OR",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Go Anonymous",
            textColor: Colors.black87,
            color: Colors.lime[300], // constructor passing value
            onpressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
