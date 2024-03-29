class UserModel {
  final String? nim;
  final String? name;
  final String? password;
  final String? salt;

  UserModel({
    this.nim,
    this.name,
    this.password,
    this.salt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nim: json['id'],
        name: json['name'],
        password: json['password'],
        salt: json['salt'],
      );

  // UserModel copyWith({
  //   String? username,
  //   String? name,
  //   String? pin,
  //   String? password,
  //   int? balance,
  // }) =>
  //     UserModel(
  //         id: id,
  //         username: username ?? this.username,
  //         name: name ?? this.name,
  //         password: password ?? this.password,
  //         pin: pin ?? this.pin,
  //         balance: balance ?? this.balance,
  //         verified: verified,
  //         profilePicture: profilePicture,
  //         cardNumber: cardNumber,
  //         token: token);
}
