import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.child,
      this.color,
      this.height = 45.0,
      this.radius: 12.0,
      this.OnPressed});

  final Widget child;
  final Color color;
  final double radius;
  final double height;
  final VoidCallback OnPressed; // void call back on when we pressed button

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        onPressed: OnPressed,
      ),
    );
  }
}
