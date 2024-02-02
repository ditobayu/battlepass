class SignInFormModel {
  final String? nim;
  final String? password;

  SignInFormModel({
    this.nim,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'password': password,
    };
  }
}
