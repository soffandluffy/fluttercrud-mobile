import 'package:fluttercrud/application/classes/auth/user.dart';
import 'package:fluttercrud/application/classes/forum/comment.dart';

class Question {
  final String question;
  final User createdBy;
  final List<Comment> comments;

  Question.fromJson(Map<String, dynamic> jsonMap)
      : question = jsonMap['question'] ?? "",
        createdBy = User.fromJson(jsonMap['createdBy']),
        comments = _getComments(jsonMap['comments']);

  static _getComments(List<dynamic> comments) {
    if (comments == null) return List<Comment>.empty();
    return comments.map((comment) => Comment.fromJson(comment)).toList();
  }
}
