import 'package:fluttercrud/application/classes/errors/common_error.dart';
import 'package:fluttercrud/application/state/auth_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RegisterFormModel {
  final AuthState _authState = Injector.get<AuthState>();

  String name;
  String email;
  String password;
  String passwordConfirmation;

  void setName(String name) {
    this.name = name;
  }

  void setEmail(String email) {
    // Email validation
    if (!validateEmail(email)) {
      print("Invalid message");
      throw CommonError(message: "Invalid message");
    }
    this.email = email;
  }

  void setPassword(String password) {
    // Password validation
    if (password.length < 5) {
      print("Password length should be more than 6 chars");
      throw CommonError(message: "Password length should be more than 6 chars");
    }

    this.password = password;
  }

  void setPasswordConfirmation(String passwordConfirmation) {
    if (this.password != passwordConfirmation) {
      print("Password does not match");
      throw CommonError(message: "Password does not match");
    }
    this.passwordConfirmation = passwordConfirmation;
  }

  bool validateData() {
    return this.name != null &&
        this.email != null &&
        this.validateEmail(this.email) &&
        this.password != null &&
        this.password.length < 5 &&
        this.password == this.passwordConfirmation;
  }

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // Submit the Sign Up form to the server
  void submitRegister() async {
    await _authState.register(
      name: this.name,
      email: this.email,
      password: this.password,
      passwordConfirmation: this.passwordConfirmation,
    );
  }
}
