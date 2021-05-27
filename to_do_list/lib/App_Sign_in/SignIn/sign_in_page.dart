import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/App_Sign_in/SignIn/email_sign_in_page.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';
import 'package:to_do_list/App_Sign_in/SignIn/social_signin_button.dart';
import 'package:to_do_list/Common_widgets/show_exception_alert_dialog.dart';
import 'package:to_do_list/Services/Auth.dart';
import 'file:///D:/FlutterApp/TO-DO-LIST/to_do_list/lib/App_Sign_in/SignIn/Sign_in_button.dart';

class SignInPage extends StatefulWidget {
  //  const SignInPage({Key key,@required this.auth}) : super(key: key);
  //  // due to stream we donot need  no call back inorder to sign in anosmusly
  // // final void Function(User) onSignIn;
  //
  //  final AuthBase auth;

// SignIn Anonymously
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERRORR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: "Sign In Failed",
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
      // return HomePage();
      // onSignIn(user);
    } on Exception catch (e) {
      _showSignError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
      // onSignIn(user);
      return HomePage();
    } on Exception catch (e) {
      _showSignError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInFacebook();
      // onSignIn(user);
      return HomePage();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWithEmail(BuildContext context) {
    // TODO: show EmailSignIn page
    Navigator.of(context).push(
        // TODO: sepicify a new route
        MaterialPageRoute<void>(
      // navigation behaviour
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
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
          SizedBox(
            height: 50,
            child: _buildheader(),
          ),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign In with Google",
            textColor: Colors.black87,
            color: Colors.white,
            image: "images/google-logo.png",
            onpressed: _isLoading ? null: () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            // constructor passing value
            onpressed: _isLoading ? null: () => _signInWithFacebook(context),
            image: "images/facebook-logo.png",
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700], // constructor passing value
            onpressed:  _isLoading ? null: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          // SocialSignInButton(
          //   text: "Sign In with VK.com",
          //   textColor: Colors.white,
          //   color: Color(0xFF334D92),
          //   // constructor passing value
          //   onpressed: (){},
          //   image: "images/vk-logo.png",
          // ),
          // SizedBox(
          //   height: 8.0,
          // ),
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
            onpressed: _isLoading ? null: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildheader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text(
        'Sign In',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
