import 'dart:ffi';

class OperationsUser {
  final String userID;
  final String name;
  final String role;

  const OperationsUser({
    required this.userID,
    required this.name,
    required this.role,
  });

  factory OperationsUser.fromJson(Map<dynamic, dynamic> json) {
    return OperationsUser(
      userID: json['pilgrim'][0]['user_id'].toString(),
      name: json['pilgrim'][0]['name'] ?? "",
      role: json['pilgrim'][0]['role'] ?? "",
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