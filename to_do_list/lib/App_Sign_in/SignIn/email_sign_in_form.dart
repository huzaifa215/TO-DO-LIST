import 'package:flutter/material.dart';
import 'package:to_do_list/Common_widgets/form_submit_button.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _builtChildern() {
    return [
      // email feild input
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: "test@test.com",
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
      text: "Sign In",
      onpressed: (){},
      ),
      SizedBox(height: 8.0,),
      // TODO: Flat button have no prominant boder
      FlatButton(
        onPressed: null,
        child: Text("Need an Account ? Register"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // how much space should be occupy  at the mainaxis  means jitna space ye chilern arry le ge uthe ne jagah  he occupay ho ge
        children: _builtChildern(),
      ),
    );
  }
}
