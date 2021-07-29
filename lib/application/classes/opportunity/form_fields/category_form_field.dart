import 'package:fluttercrud/application/classes/common/category.dart';

class CategoryFormField {
  final Category category;

  CategoryFormField(this.category);

  validate() {}

  bool isValid() {
    return category != null;
  }
}
