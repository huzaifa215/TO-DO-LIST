// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:to_do_list/App_Sign_in/SignIn/email_sign_in_form.dart';
//
//
//
// class OTPscreen extends StatefulWidget {
//   @override
//   _OTPscreenState createState() => _OTPscreenState();
// }
//
// class _OTPscreenState extends State<OTPscreen> {
//
//   //TODO:Verify the OTP that is send on the email on yours
//   void _verifyOTP() async {
//     var res = EmailAuth.validate(receiverMail: , userOTP: _);
//     if (res) {
//       print("OPT Verify");
//     }
//     else{
//       print("invalid OTP");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("OTP Screen")),
//         elevation: 20.0, // shadow under the ap bas
//         toolbarHeight: 75,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(child: //EmailSignInForm(auth: auth,)
//         ),
//       ),
//       backgroundColor: Colors.grey[200],
//     );
//   }
// }
