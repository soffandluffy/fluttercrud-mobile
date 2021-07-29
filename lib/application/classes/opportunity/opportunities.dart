import 'package:flutter/cupertino.dart';
import 'package:fluttercrud/application/classes/common/pagination.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity.dart';

class Opportunities {
  final Pagination pagination;
  final List<Opportunity> opportunities;

  Opportunities({
    @required this.pagination,
    @required this.opportunities,
  });
}
