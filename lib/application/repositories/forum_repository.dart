import 'package:dio/dio.dart';
import 'package:fluttercrud/application/classes/common/pagination.dart';
import 'package:fluttercrud/application/classes/errors/common_error.dart';
import 'package:fluttercrud/application/classes/forum/question.dart';
import 'package:fluttercrud/application/classes/forum/questions.dart';
import 'package:fluttercrud/application/storage/localstorage.dart';
import 'package:fluttercrud/application/storage/storage_keys.dart';

import '../fluttercrud_api.dart';

abstract class ForumRepository {
  // Fetch question
  Future<Questions> getAllQuestions(int page);
}

class ForumRepositoryImpl implements ForumRepository {
  @override
  Future<Questions> getAllQuestions(int page) async {
    try {
      final response = await FluttercrudApi.dio.get("/api/questions?page=$page",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      List _temp = response.data['data'];
      var _meta = response.data['meta'];

      Pagination pagination = Pagination.fromJson(_meta);

      List<Question> _questions =
          _temp.map((question) => Question.fromJson(question)).toList();
      return new Questions(pagination: pagination, questions: _questions);
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }
}
