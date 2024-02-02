class SignUpFormModel {
  final String? nim;
  final String? name;
  final String? password;
  final String? description;

  SignUpFormModel({
    this.nim,
    this.name,
    this.password,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'name': name,
      'password': password,
      'description': description,
    };
  }

  // SignUpFormModel copyWith({
  //   String? pin,
  //   String? profilePicture,
  //   String? ktp,
  // }) =>
  //     SignUpFormModel(
  //       name: name,
  //       email: email,
  //       password: password,
  //       pin: pin ?? this.pin,
  //       profilePicture: profilePicture ?? this.profilePicture,
  //       ktp: ktp ?? this.ktp,
  //     );
}
