import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list/App_Sign_in/SignIn/validator.dart';
import 'package:to_do_list/Common_widgets/form_submit_button.dart';
import 'package:to_do_list/Services/Auth.dart';
import 'package:email_auth/email_auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  final AuthBase auth;

  EmailSignInForm({Key key, this.auth}) : super(key: key);

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
  bool _sumbited=false;
  bool isLoading =false;




  // getting email

  void _submit() async {
    print ("Submit called");
   setState(() {
     _sumbited=true;
     isLoading=true;
   });
    // TODO: print the email and password but than transfer data to the firebase
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.CreateUserWithEmailAndPassword(_email, _password);
        //_sendOTP();
        Navigator.of(context).pop();
      }
     // Navigator.of(context).pop();// move to the sign in page  therefore the  2 times navigator.pop is used to reach the homepage
      Navigator.of(context).pop(); // move to landing page
    } catch (e) {
      print(e.toString());
    }finally{
      isLoading=false;
    }
  }

  void _emailEditingComplete() {
    final newFocus=widget.emailValidator.isValid(_email) ? _passwordFocusNode :_emailFocusNode;
    // TODO: keep track on the next widget or the widgets to follow the flow
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditingComplete() {
    // TODO: keep track on the next widget or the widgets to follow the flow
    FocusScope.of(context).requestFocus(_OTPFocusNode);
  }

// TODO: Toggole set the _formkey here and when the _builtChilder will call it changes
  void _toogleFormType() {
    setState(() {
      _sumbited=false;
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
    } else {
      print("Problem in sending OTP");
    }
  }

  //TODO:Verify the OTP that is send on the email on yours
  void _verifyOTP() async {
    var res = EmailAuth.validate(receiverMail: _email, userOTP: _OTP);
    if (res) {
      print("OPT Verify");
      _submit();
    } else {
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
        : "Create Account");
    final secondarytext = (_formType == EmailSignInFormType.signIn
        ? "Need an Account? Register"
        : "Have an Account? Sign In");
    // TODO variable that store the current sate that we cannot enter the enter data and submit it
    bool submitEnabled=widget.emailValidator.isValid(_email) && widget.emailValidator.isValid(_password) && !isLoading;

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
      // _buildOTP(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        // do the setstate to doe the logic formation
        text: primarytext,
        onpressed: (){
          if(submitEnabled==true){
            setState(() {
              if (primarytext == " Sign In") {
                _submit();
              }
              else{
                _sendOTP();
                OPTsheet();
              }
            },
            );
          }
          else{
            // Showtost("Enter the Email and password");
            submitEnabled=null;
          }
        }
      ),
      SizedBox(
        height: 8.0,
      ),
      // TODO: Flat button have no prominant boder
      FlatButton(
        onPressed: _toogleFormType,
       // onPressed: !isLoading ?_toogleFormType : null,
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
    bool emailValid=widget.emailValidator.isValid(_email);
    return TextField(
      // TODO: what ever will be written in the textfield it aotumaticcaly edited in the controller
      controller: _emailController,
      focusNode: _emailFocusNode,// Focus only on the box taht you have selected
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: "test@test.com",
       // enabled: isLoading == false,
        errorText: emailValid ?  null:widget.invalidEmailText,
        //TODO: written as a power on the email\
        // suffixIcon:TextButton(
        //   child: Text("Send OTP"),
        //   onPressed : _sendOTP,
        // )
      ),
      //autocorrect: false,//TODO: used to enable the keyboard suggestion
      keyboardType: TextInputType.emailAddress,
      //TODO: Show that keyboard that is suitable for emails
      textInputAction: TextInputAction.next,
      // TODO: show the button that on which we click move to the password section
      onEditingComplete: _emailEditingComplete,
      onChanged: (email)=>updateState(),
    );
  }

  TextField _buildpassword() {
    bool passwordValid= _sumbited && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      onEditingComplete: _passwordEditingComplete,
      decoration: InputDecoration(
        labelText: 'Password',
       // enabled: isLoading==false,
        errorText: passwordValid ? null :widget.invalidPasswordText ,
      ),
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onChanged: (_password)=>updateState(),
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
      keyboardType: TextInputType.number ,
      textInputAction: TextInputAction.done,
    );
  }


  // submit form
  void submit_form(final primarytext){
    setState(() {
      if (primarytext == " Sign In") {
        _submit();
      }
      else{
        _sendOTP();
        OPTsheet();
      }
    },
    );
  }

  void OPTsheet(){
    showModalBottomSheet(context: context, builder:(context){
        return Container(
          height: 180,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
            )
          ),
          child: Center(
            child: Card(
              child: Column(
                children: [
                  _buildOTP(),
                  SizedBox(
                    height: 8.0,
                  ),

                  FormSubmitButton(
                    // do the setstate to doe the logic formation
                    text: "Verify",
                    onpressed: _verifyOTP,
                  ),
                ],
              ),
            ),
          ),
        );
    });
  }

  updateState() {
    print ("email is$_email and the $_password");
    setState(() {});
  }

 // Showtost(msg){
 //    Fluttertoast.showToast(
 //        msg: msg,
 //        toastLength: Toast.LENGTH_SHORT,
 //        gravity: ToastGravity.SNACKBAR,
 //        timeInSecForIosWeb: 5,
 //        backgroundColor: Colors.red,
 //        textColor: Colors.white,
 //        fontSize: 16.0
 //    );
 //  }
}
