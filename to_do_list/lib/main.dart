import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vk_sdk/flutter_vk_sdk.dart';
import 'package:to_do_list/App_Sign_in/SignIn/LandingPage/landdingpade.dart';
import 'package:to_do_list/Services/Auth.dart';

const String APP_ID = '12345';
const String API_VERSION = '5.90';
Future<void> main() async{

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
      home: LanddindgPage(
        auth: Auth(),// for firebase authentication
      ),
    );
  }
}

