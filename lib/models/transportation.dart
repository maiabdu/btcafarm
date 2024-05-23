import 'dart:ffi';

class Buses {
  final String id;
  final String name;
  final String route;
  final String count;

  const Buses({
    required this.id,
    required this.name,
    required this.route,
    required this.count,
  });

  factory Buses.fromJson(Map<dynamic, dynamic> json) {
    return Buses(
        id: json['id'].toString(),
        name: json['name'] ?? "",
        route: json['route'] ?? "",
        count: json['count'] ?? 0);
  }
}

class PigrimOnBuses {
  final String otherName;
  final String name;
  final String passportNo;

  const PigrimOnBuses({
    required this.otherName,
    required this.name,
    required this.passportNo,
  });

  factory PigrimOnBuses.fromJson(Map<dynamic, dynamic> json) {
    return PigrimOnBuses(
      otherName: json['other_name'].toString(),
      name: json['name'] ?? "",
      passportNo: json['passport_no'] ?? "",
    );
  }
}
