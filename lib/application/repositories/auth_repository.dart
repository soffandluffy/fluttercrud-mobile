import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttercrud/application/classes/errors/common_error.dart';
import 'package:fluttercrud/application/fluttercrud_api.dart';
import 'package:fluttercrud/application/storage/localstorage.dart';
import 'package:fluttercrud/application/storage/storage_keys.dart';

abstract class AuthRepository {
  Future login({
    @required String email,
    @required String password,
  });

  Future register({
    @required String name,
    @required String email,
    @required String password,
    @required String passwordConfirmation,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future login({
    String email,
    String password,
  }) async {
    try {
      var response = await FluttercrudApi.dio.post(
        "/api/auth/login",
        data: {"email": email, "password": password},
      );
      print(response);
      String accessToken = response.data['accessToken'];
      String expiresAt = response.data['expiresAt'];
      await LocalStorage.setItem(TOKEN, accessToken);
      await LocalStorage.setItem(TOKEN_EXPIRATION, expiresAt);
      return;
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }

  @override
  Future register({
    String name,
    String email,
    String password,
    String passwordConfirmation,
  }) async {
    try {
      var response = await FluttercrudApi.dio.post(
        "/api/auth/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      print(response);
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }
}
