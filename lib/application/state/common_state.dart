import 'package:fluttercrud/application/classes/common/category.dart';
import 'package:fluttercrud/application/classes/common/country.dart';
import 'package:fluttercrud/application/repositories/common_repository.dart';

class CommonState {
  final CommonRepository _commonRepository;

  CommonState(this._commonRepository);

  List<Category> _categories = [];
  List<Category> get categories => _categories;
  List<Country> _countries = [];
  List<Country> get countries => _countries;

  Future getCategories() async {
    _categories = await _commonRepository.categories();
  }

  Future getCountries() async {
    _countries = await _commonRepository.countries();
  }
}
