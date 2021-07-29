import 'package:flutter/foundation.dart';
import 'package:fluttercrud/application/repositories/auth_repository.dart';

class AuthState {
  final AuthRepository _authRepository;

  AuthState(this._authRepository) : assert(_authRepository != null);

  Future login({
    @required String email,
    @required String password,
  }) async {
    await _authRepository.login(email: email, password: password);
  }

  Future register({
    @required String name,
    @required String email,
    @required String password,
    @required String passwordConfirmation,
  }) async {
    await _authRepository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
