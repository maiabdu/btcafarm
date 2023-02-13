import 'dart:ffi';

class User {
  final String token;
  final String userId;
  final String fullname;
  final String email;
  // final Int status;
  final String phoneNumber;
  final String walletId;
  final String mnemomic;

  const User(
      {required this.token,
      required this.userId,
      required this.fullname,
      required this.email,
      required this.phoneNumber,
      required this.walletId,
      required this.mnemomic});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      token: json["token"] ?? "",
      userId: json["user"]["userId"] ?? '',
      fullname: json["user"]["fullname"] ?? "",
      email: json["user"]["email"] ?? "",
      // status: json["user"]["status"] ,
      phoneNumber: json["user"]["phoneNumber"] ?? "",
      walletId: json["user"]["wallet"]["walletId"] ?? "",
      mnemomic: json["user"]["wallet"]["mnemomic"] ?? "",
    );
  }
}




  // token: json["token"] != null ? json["token"] : "",
      // userId: json["token"] != null ? json["token"] : "",
      // fullname: json["token"] != null ? json["token"] : "",
      // status: json["token"] != null ? json["token"] : "",
      // email: json["token"] != null ? json["token"] : "",
      // phoneNumber: json["token"] != null ? json["token"] : "",
      // walletId: json["token"] != null ? json["token"] : "",
      // mnemomic: json["token"] != null ? json["token"] : "",