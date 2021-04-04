import 'package:flutter/material.dart';
import 'package:to_do_list/Common_widgets/form_submit_button.dart';
import 'package:to_do_list/Services/Auth.dart';
import 'package:email_auth/email_auth.dart';

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
  final TextEditingController _OTPController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _OTPFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;


  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _OTP => _OTPController.text;



  void _submit() async {
    // TODO: print the email and password but than transfer data to the firebase
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.CreateUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop(); // move to landing page
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete() {
    // TODO: keep track on the next widget or the widgets to follow the flow
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _passwordEditingComplete() {
    // TODO: keep track on the next widget or the widgets to follow the flow
    FocusScope.of(context).requestFocus(_OTPFocusNode);
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

  //TODO:sending the OTP message on the email
  void _sendOTP() async {
    EmailAuth.sessionName = "test Session";
    var res = await EmailAuth.sendOtp(receiverMail: _email);
    if (res) {
      print("OTP Send");
    }
    else{
      print("Problem in sending OTP");
    }
  }

  //TODO:Verify the OTP that is send on the email on yours
  void _verifyOTP() async {
    var res = EmailAuth.validate(receiverMail: _email, userOTP: _OTP);
    if (res) {
      print("OPT Verify");
      _submit();
    }
    else{
      print("invalid OTP");
    }
  }

// TextField _showOTPtextFeild(){
//     if(_formType !=EmailSignInFormType.signIn){
//       return ;
//     }
//     return _buildOTP()
//
// }



  List<Widget> _builtChildern() {
    final primarytext = (_formType == EmailSignInFormType.signIn
        ? " Sign In"
        : "Verify OTP");
    final secondarytext = (_formType == EmailSignInFormType.signIn
        ? "Need an Account? Register"
        : "Have an Account? Sign In");
    return [
      // email field input
      _buildemail(),
      SizedBox(
        height: 8.0,
      ),
      // password field input
      _buildpassword(),
      SizedBox(
        height: 8.0,
      ),
      // OTP text feild
      _buildOTP(),
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

  TextField _buildemail() {
    return TextField(
      // TODO: what ever will be written in the textfield it aotumaticcaly edited in the controller
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: "test@test.com",
        //TODO: written as a power on the email
        suffixIcon:TextButton(
          child: Text("Send OTP"),
          onPressed : _sendOTP,
        )
      ),
      //autocorrect: false,//TODO: used to enable the keyboard suggestion
      keyboardType: TextInputType.emailAddress,
      //TODO: Show that keyboard that is suitable for emails
      textInputAction: TextInputAction.next,
      // TODO: show the button that on which we click move to the password section
      onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildpassword() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      onEditingComplete: _passwordEditingComplete,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildOTP() {
    return TextField(
      controller: _OTPController,
      focusNode: _OTPFocusNode,
      onEditingComplete: _verifyOTP,
      decoration:
          InputDecoration(labelText: 'OTP Code', hintText: "Enter the OTP"),
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
