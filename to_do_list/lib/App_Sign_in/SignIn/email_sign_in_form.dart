import 'package:flutter/material.dart';
import 'package:to_do_list/Common_widgets/form_submit_button.dart';
import 'package:to_do_list/Services/Auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;

  const EmailSignInForm({Key key, this.auth}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode=FocusNode();
  final FocusNode _passwordFocusNode=FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  void _submit() async {
    // TODO: print the email and password but than transfer data to the firebase
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.CreateUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();// move to landing page
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete(){
    
  }

// TODO: Toggole set the _formkey here and when the _builtChilder will call it changes
  void _toogleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _builtChildern() {
    final primarytext = (_formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an Account");
    final secondarytext = (_formType == EmailSignInFormType.signIn
        ? "Need an Account? Register"
        : "Have an Account? Sign In");
    return [
      // email feild input
      TextField(
        // TODO: what ever will be written in the textfield it aotumaticcaly edited in the controller
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: "test@test.com",
        ),
        //autocorrect: false,//TODO: used to enable the keyboard suggestion
        keyboardType: TextInputType.emailAddress,//TODO: Show that keyboard that is suitable for emails
        textInputAction: TextInputAction.next,// TODO: show the button that on which we click move to the password section
        onEditingComplete: _emailEditingComplete,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primarytext,
        onpressed: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      // TODO: Flat button have no prominant boder
      FlatButton(
        onPressed: _toogleFormType,
        child: Text(secondarytext),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // how much space should be occupy  at the mainaxis  means jitna space ye chilern arry le ge uthe ne jagah  he occupay ho ge
        children: _builtChildern(),
      ),
    );
  }
}

