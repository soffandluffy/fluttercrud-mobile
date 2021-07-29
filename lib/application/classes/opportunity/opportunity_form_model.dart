import 'package:fluttercrud/application/classes/common/category.dart';
import 'package:fluttercrud/application/classes/common/country.dart';
import 'package:meta/meta.dart';

class OpportunityFormModel {
  final String title;
  final String description;
  final Category category;
  final Country country;
  final DateTime deadline;
  final String organizer;

  OpportunityFormModel(
      {@required this.title,
      @required this.description,
      @required this.category,
      @required this.country,
      @required this.deadline,
      @required this.organizer});
}
