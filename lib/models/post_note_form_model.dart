class PostNoteFormModel {
  final String? title;
  final String? description;

  PostNoteFormModel({
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
