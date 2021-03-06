import 'package:flutter/cupertino.dart';
import 'package:to_do_list/Common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String text,
     Color color,
    Color textColor,
    @required String image,//@ required show that it should be include in it
    VoidCallback onpressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset("images/google-logo.png"),
              ),
            ],
          ),
          color: color,
          OnPressed: onpressed,
        );
}
