abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}
class EmailAndPasswordValidator{

final StringValidator emailValidator=new NonEmptyStringValidator();
final StringValidator passwordValidator=new NonEmptyStringValidator();
final String invalidEmailText="Email can't be Empty";
final String invalidPasswordText="Password can't be Empty";
}