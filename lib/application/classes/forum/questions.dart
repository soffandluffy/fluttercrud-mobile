import 'package:flutter/cupertino.dart';
import 'package:fluttercrud/application/classes/common/pagination.dart';
import 'package:fluttercrud/application/classes/forum/question.dart';

class Questions {
  final Pagination pagination;
  final List<Question> questions;

  Questions({@required this.pagination, @required this.questions});
}
