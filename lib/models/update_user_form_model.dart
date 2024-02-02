class UpdateUserFormModel {
  final String? name;
  final String? password;
  final String? description;

  UpdateUserFormModel({
    this.name,
    this.password,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'description': description,
    };
  }
}
