import 'package:dio/dio.dart';
import 'package:fluttercrud/application/classes/common/pagination.dart';
import 'package:fluttercrud/application/classes/errors/common_error.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunities.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity_form_model.dart';
import 'package:fluttercrud/application/fluttercrud_api.dart';
import 'package:fluttercrud/application/storage/localstorage.dart';
import 'package:fluttercrud/application/storage/storage_keys.dart';

abstract class OpportunityRepository {
  // We need to fetch the opportuntities
  Future<Opportunities> getAllOpportunities(int page);
  Future<Opportunity> saveOpportunity(OpportunityFormModel model);
}

class OpportunityRepositoryImpl implements OpportunityRepository {
  @override
  Future<Opportunities> getAllOpportunities(int page) async {
    try {
      final response = await FluttercrudApi.dio.get(
          "/api/opportunity?page=$page",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      List _temp = response.data['data'];
      var _meta = response.data['meta'];

      Pagination pagination = Pagination.fromJson(_meta);

      List<Opportunity> _opportunties = _temp
          .map((opportunity) => Opportunity.fromJson(opportunity))
          .toList();
      return new Opportunities(
          pagination: pagination, opportunities: _opportunties);
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future<Opportunity> saveOpportunity(OpportunityFormModel model) async {
    try {
      var _data = {
        "title": model.title,
        "description": model.description,
        "category_id": model.category.id,
        "country_id": model.country.id,
        "deadline": model.deadline.toIso8601String(),
        "organizer": model.organizer,
        "created_by": 1,
      };
      var response = await FluttercrudApi.dio.post('/api/opportunity',
          data: _data,
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));

      print(response);
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }
}
