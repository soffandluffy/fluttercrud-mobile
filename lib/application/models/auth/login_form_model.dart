import 'package:fluttercrud/application/classes/errors/common_error.dart';
import 'package:fluttercrud/application/state/auth_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginFormModel {
  final AuthState _authState = Injector.get<AuthState>();

  String email;
  String password;

  void setEmail(String email) {
    // Email validation
    if (!validateEmail(email)) {
      throw CommonError(message: "Invalid email");
    }
    this.email = email;
  }

  void setPassword(String password) {
    // Password validation
    if (password.length < 4) {
      throw CommonError(message: "Password length should be more than 6 chars");
    }

    this.password = password;
  }

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool validateData() {
    return this.email != null &&
        this.password != null &&
        this.validateEmail(this.email);
  }

  Future<void> submitLogin() async {
    return await _authState.login(email: this.email, password: this.password);
  }
}
