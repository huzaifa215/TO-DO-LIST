import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/App_Sign_in/SignIn/homepage.dart';
import 'package:to_do_list/App_Sign_in/SignIn/sign_in_page.dart';
import 'package:to_do_list/Services/Auth.dart';

class LanddindgPage extends StatefulWidget {
  //due to statefull we use widget but for stateless we onl use auth.etc
  final AuthBase auth;

  const LanddindgPage({Key key, this.auth}) : super(key: key);

  @override
  _LanddindgPageState createState() => _LanddindgPageState();
}

class _LanddindgPageState extends State<LanddindgPage> {
  // // cehck user here
  // User _user; // current user details status page status
  //
  // @override
  // void _updateUser(User user) {
  //   try {
  //     setState(() {
  //       // setstate is used here because it is the parent of (home and sign up)
  //       // child widget it automatically update the both
  //       // pages and pass date from here to all the child widgets
  //       // the all the child rebuilt them automatically only by calling the set state method in the parent
  //       _user = user;
  //     });
  //   } catch (e, s) {
  //     print(s);
  //   }
  // }

  // check the user login or not
  // void initState() {
  //   super.initState();
  //   // widget.auth.authStateChanges().listen((user) {
  //   //   print('Uid :${user?.uid}');
  //   // the question mark is used kion keh agr exception ai tu ye chale ga nhi ruk kr khatam kion keh is ke pas uid nhi ho ge
  //   // tu is ke lia
  //   // hame ne ? ye lagaya keh ai tu ignore or na ai tu chale
  //   //});
  //
  //  // _updateUser(widget.auth.currentUser);
  // }

  @override
  Widget build(BuildContext context) {
    // stream are sources for asyncronous data
    return StreamBuilder<User>// that the steam will deals with users
      (
      //initialData: widget.auth.authStateChanges(),// inital data optional if we pass the intial data no need to check the connection
      stream: widget.auth.authStateChanges(),
      builder: (context, snapshot) {
        // snapshot that hold the data from the stream
        // check connection state

        // any one doumentation
        if (snapshot.connectionState == ConnectionState.active) {
          //
          final User user = snapshot.data;
          if (user == null) {
            return SignInPage(
              auth: widget.auth,
             // onSignIn: _updateUser,
            );
          }
          return HomePage(
            auth: widget.auth,
           // OnSignOut: () => _updateUser(null),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
  // previous state
//   if (_user == null) {
//     return SignInPage(
//       auth:widget.auth,
//       onSignIn: _updateUser,
//     );
//   }
//   return HomePage(
//     auth:widget.auth,
//     OnSignOut: () => _updateUser(null),
//   ); // Temporary placeholder for homepage
// }
}
