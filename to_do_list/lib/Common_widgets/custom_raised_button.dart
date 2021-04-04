import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.child,
      this.color,
      this.height = 45.0,
      this.radius: 12.0,
        this.width=null,
      this.OnPressed});

  final Widget child;
  final Color color;
  final double radius;
  final double height;
  final double width;
  final VoidCallback OnPressed; // void call back on when we pressed button

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width:width,
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
