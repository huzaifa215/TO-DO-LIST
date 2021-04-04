import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("TO DO LIST")),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
      ),
      body: _builtContext(),
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget _builtContext(){
  return Container();
}