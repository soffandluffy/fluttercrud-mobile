class DescriptionFormField {
  final String description;

  DescriptionFormField(this.description);

  validate() {
    if (description == null || description.isEmpty) {
      throw Exception("Description is required");
    }
  }
}
