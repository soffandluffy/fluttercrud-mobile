import 'package:fluttercrud/application/classes/auth/user.dart';
import 'package:fluttercrud/application/classes/common/category.dart';
import 'package:fluttercrud/application/classes/common/country.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity_detail.dart';

class Opportunity {
  final int id;
  final String title;
  final Category category;
  final Country country;
  final String deadline;
  final User createdBy;
  final String organizer;
  final OpportunityDetail opportunityDetail;
  final String createdAt;
  final String updatedAt;

  Opportunity.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        title = jsonMap['title'] ?? '',
        category = jsonMap['category'] != null
            ? Category.fromJson(jsonMap['category'])
            : null,
        country = jsonMap['country'] != null
            ? Country.fromJson(jsonMap['country'])
            : null,
        deadline = jsonMap['deadline'] ?? '',
        createdBy = jsonMap['createdBy'] != null
            ? User.fromJson(jsonMap['createdBy'])
            : null,
        organizer = jsonMap['organizer'] ?? '',
        opportunityDetail = jsonMap['opportunityDetail'] != null
            ? OpportunityDetail.fromJson(jsonMap['opportunityDetail'])
            : null,
        createdAt = jsonMap['createdAt'] ?? '',
        updatedAt = jsonMap['updatedAt'] ?? '';
}
