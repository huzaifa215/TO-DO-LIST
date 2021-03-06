import 'package:flutter/material.dart';
import 'package:to_do_list/AppScreen/sign_in_page.dart';
void main(){
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

