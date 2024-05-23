import 'dart:ffi';

class User {
  final String fullName;
  final String lga;
  final String passportNo;
  final String referenceNo;
  // final Int status;
  final String nin;
  final String sex;
  final String image;
  final String phoneNumber;
  final String address;
  final String hajjID;
  final String mofaNo;
  final String tag;
  final String code;
  final String barcode;

  const User({
    required this.fullName,
    required this.lga,
    required this.passportNo,
    required this.referenceNo,
    required this.nin,
    required this.sex,
    required this.image,
    required this.phoneNumber,
    required this.address,
    required this.hajjID,
    required this.mofaNo,
    required this.tag,
    required this.code,
    required this.barcode,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      fullName: json['pilgrim'][0]['fullName'] ?? "",
      lga: json['pilgrim'][0]['lga'] ?? "",
      passportNo: json['pilgrim'][0]['passportNo'] ?? "",
      referenceNo: json['pilgrim'][0]['referenceNo'] ?? "",
      nin: json['pilgrim'][0]['nin'] ?? "",
      sex: json['pilgrim'][0]['sex'] ?? "",
      image: json['pilgrim'][0]['image'] ?? "",
      phoneNumber: json['pilgrim'][0]['phoneNumber'] ?? "",
      address: json['pilgrim'][0]['address'] ?? "",
      hajjID: json['pilgrim'][0]['hajjID'] ?? "",
      mofaNo: json['pilgrim'][0]['mofaNo'] ?? "",
      tag: json['pilgrim'][0]['tag'] ?? "",
      code: json['pilgrim'][0]['code'] ?? "",
      barcode: json['pilgrim'][0]['barcode'] ?? "",
    );
  }
}

class AccomodationInfo {
  final String house;
  final String floor;
  final String room;
  final String bed;
  final String name;
  // final String lat;
  // final String lon;

  const AccomodationInfo({
    required this.house,
    required this.floor,
    required this.room,
    required this.bed,
    required this.name,
    // required this.lat,
    // required this.lon,
  });

  factory AccomodationInfo.fromJson(Map<dynamic, dynamic> json){
    return AccomodationInfo(
      house: json['appartment'] ?? "", 
      floor: json['floor'] ?? "", 
      room: json['room'] ?? "", 
      bed: json['bed'] ?? "", 
      name: json['name'] ?? "", 
      // lat: json['pilgrim'][0]['lat'] ?? "", 
      // lon: json['pilgrim'][0]['lon'] ?? ""
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