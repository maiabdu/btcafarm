import 'dart:ffi';

class HotelModel {
  final String hotelName;

  const HotelModel({
    required this.hotelName,
  });

  factory HotelModel.fromJson(Map<dynamic, dynamic> json) {
    return HotelModel(
      hotelName: json['appartment'].toString(),
    );
  }
}

class Apartment {
  final String hotelName;

  const Apartment({
    required this.hotelName,
  });

  factory Apartment.fromJson(Map<dynamic, dynamic> json) {
    return Apartment(
      hotelName: json['appartment'].toString(),
    );
  }
}

class Floors {
  final String floor;

  const Floors({
    required this.floor,
  });

  factory Floors.fromJson(Map<dynamic, dynamic> json) {
    return Floors(
      floor: json['floor'].toString(),
    );
  }
}

class Rooms {
  final String room, is_full, space, rid, lat, log;

  const Rooms({
    required this.room,
    required this.is_full,
    required this.space,
    required this.rid,
    required this.lat,
    required this.log,
  });

  factory Rooms.fromJson(Map<dynamic, dynamic> json) {
    return Rooms(
      room: json['room'].toString(),
      is_full: json['is_full'].toString(),
      space: json['space'].toString(),
      rid: json['id'].toString(),
      lat: json['lat'].toString(),
      log: json['log'].toString(),
    );
  }
}

class FetchHotel {
  final String hotel, floor, room, bed;

  const FetchHotel({
    required this.hotel,
    required this.floor,
    required this.room,
    required this.bed,
  });

  factory FetchHotel.fromJson(Map<dynamic, dynamic> json) {
    return FetchHotel(
      hotel: json['pilgrim'][0]['appartment'].toString(),
      floor: json['pilgrim'][0]['floor'].toString(),
      room: json['pilgrim'][0]['room'].toString(),
      bed: json['pilgrim'][0]['bed'].toString(),
    );
  }
}
