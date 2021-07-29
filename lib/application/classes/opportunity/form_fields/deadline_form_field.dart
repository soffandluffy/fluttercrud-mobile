class DeadlineFormField {
  final DateTime deadline;

  DeadlineFormField(this.deadline);

  validate() {
    if (deadline == null) {
      throw Exception("Deadline is required");
    }
  }

  bool isValid() {
    return deadline != null;
  }
}
