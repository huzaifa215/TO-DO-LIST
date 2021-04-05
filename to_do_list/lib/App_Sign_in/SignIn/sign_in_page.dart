
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/email_sign_in_page.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';
import 'package:to_do_list/App_Sign_in/SignIn/social_signin_button.dart';
import 'file:///D:/FlutterApp/TO-DO-LIST/to_do_list/lib/App_Sign_in/SignIn/Sign_in_button.dart';
import 'package:to_do_list/Services/Auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key,@required this.auth}) : super(key: key);
  // due to stream we donot need  no call back inorder to sign in anosmusly
 // final void Function(User) onSignIn;

  final AuthBase auth;

// SignIn Anonymously
  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
     // return HomePage();
     // onSignIn(user);
    } catch (e) {
      print(e.toString());
    }
  }

// google
  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
      // onSignIn(user);
      return HomePage();
    } catch (e) {
      print(e.toString());
    }
  }
// facebook
  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInFacebook();
      // onSignIn(user);
      return HomePage();
    } catch (e) {
      print(e.toString());
    }
  }

void _signInWithEmail(BuildContext context){
    // TODO: show EmailSignIn page
  Navigator.of(context).push(
    // TODO: sepicify a new route
    MaterialPageRoute<void>(
      // navigation behaviour
      fullscreenDialog: true,
      builder: (context) =>EmailSignInPage(auth: auth,),
    )
  );

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TO DO LIST")),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
      ),
      body: BuiltCntext(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget BuiltCntext(BuildContext context) {
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
            onpressed: _signInWithGoogle,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            // constructor passing value
            onpressed: _signInWithFacebook,
            image: "images/facebook-logo.png",
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700], // constructor passing value
            onpressed: () =>_signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign In with VK.com",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            // constructor passing value
            onpressed: (){},
            image: "images/vk-logo.png",
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
