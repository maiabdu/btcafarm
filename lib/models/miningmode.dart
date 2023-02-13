import 'dart:ffi';

class MininingData {
  final String packageName;
  final String minnedThisMonth;
  final String minnedToday;
  final String maxLoad;
  final String totalMinned;
  final String monthRemaining;
  final String monthMinned;

  const MininingData({
    required this.packageName,
    required this.minnedThisMonth,
    required this.minnedToday,
    required this.maxLoad,
    required this.totalMinned,
    required this.monthRemaining,
    required this.monthMinned,
  });

  factory MininingData.fromJson(Map<dynamic, dynamic> json) {
    return MininingData(
      packageName: json[0]["packageName"] ?? "",
      minnedThisMonth: json[0]["minnedThisMonth"] ?? '',
      minnedToday: json[0]["minnedToday"] ?? "",
      maxLoad: json[0]["maxLoad"] ?? "",
      totalMinned: json[0]["totalMinned"] ?? "",
      monthRemaining: json[0]["monthRemaining"] ?? "",
      monthMinned: json[0]["monthMinned"] ?? "",
    );
  }
}
