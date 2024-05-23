import 'dart:ffi';

class DashboadBTA {
  final String passport_no;
  final String name;
  final String lga;

  const DashboadBTA({
    required this.passport_no,
    required this.name,
    required this.lga,
  });

  factory DashboadBTA.fromJson(Map<dynamic, dynamic> json) {
    return DashboadBTA(
      passport_no: json['passport_no'].toString(),
      name: json['name'] ?? "",
      lga: json['lga'] ?? "",
    );
  }
}
