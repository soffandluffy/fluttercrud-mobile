import 'package:fluttercrud/application/classes/common/pagination.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunities.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity_form_model.dart';
import 'package:fluttercrud/application/repositories/opportunity_repository.dart';
import 'package:fluttercrud/utils/helper.dart';

class OpportunityState {
  final OpportunityRepository _opportunityRepository;

  OpportunityState(this._opportunityRepository);

  List<Opportunity> _opportunities = [];
  List<Opportunity> get opportunities => _opportunities;

  Pagination _pagination;
  bool _loading = false;
  bool get loading => _loading;

  Future getAllOpportunities() async {
    if (Helper.paginationFetchNext(this._pagination).fetchNext) {
      _loading = true;
      Opportunities _newOpportunties =
          await _opportunityRepository.getAllOpportunities(
              Helper.paginationFetchNext(this._pagination).currentPage);
      _opportunities.addAll(_newOpportunties.opportunities);
      _pagination = _newOpportunties.pagination;
      _loading = false;
    }
  }

  Future saveOpportunity(OpportunityFormModel model) async {
    await _opportunityRepository.saveOpportunity(model);
  }
}
