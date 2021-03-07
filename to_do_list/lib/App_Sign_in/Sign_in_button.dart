import 'package:flutter/cupertino.dart';
import 'package:to_do_list/Common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton{
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onpressed,})
    :super(
    child:Text(text,style: TextStyle(color: textColor,fontSize: 15.0),),
    color:color,
    OnPressed:onpressed,
    );
}