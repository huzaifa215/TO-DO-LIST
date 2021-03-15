import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HOME")),
        elevation: 20.0, // shadow under the ap bas
        toolbarHeight: 75,
      ),
    );
  }
}
