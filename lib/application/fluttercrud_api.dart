import 'package:dio/dio.dart';
import 'package:fluttercrud/base_url.dart';

class FluttercrudApi {
  static BaseOptions _baseOptions = new BaseOptions(baseUrl: BASE_URL);

  // For unauthenticated apis
  static Dio dio = new Dio(_baseOptions);

  // Autheticated routes
  static Dio dioAuth() {
    return Dio();
  }
}
