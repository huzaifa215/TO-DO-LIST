import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({this.child, this.color, this.radius:4.0, this.OnPressed});

  final Widget child;
  final Color color;
  final double radius;
  final VoidCallback OnPressed; // void call back on when we pressed button

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: child,
      color:color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      onPressed: OnPressed,
    );
  }
}
