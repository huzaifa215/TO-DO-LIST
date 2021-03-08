import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'App_Sign_in/sign_in_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO DO List",
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: SignInPage(),
    );
  }
}
