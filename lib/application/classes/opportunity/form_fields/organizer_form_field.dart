class OrganizerFormField {
  final String organizer;

  OrganizerFormField(this.organizer);

  validate() {
    if (organizer == null || organizer.isEmpty) {
      throw Exception("Organizer is required");
    }
  }
}
