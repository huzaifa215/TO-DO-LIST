import 'package:flutter/cupertino.dart';
import 'package:to_do_list/Services/Auth.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({@required this.auth, @required this.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  final AuthBase auth;
  final Widget child;

  static AuthBase of(BuildContext context){
    AuthProvider provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}