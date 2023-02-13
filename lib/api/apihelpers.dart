import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../models/usermodel.dart';

Future<void> share() async {
  await FlutterShare.share(
      title: 'BTCA Wallet Address',
      text: 'bc1qxy2kgdygjrsqtzq2n0yrf2493',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title');
}




// Future<void> shareFile() async {
//   List<dynamic> docs = await DocumentsPicker.pickDocuments;
//   if (docs == null || docs.isEmpty) return null;
//
//   await FlutterShare.shareFile(
//     title: 'Example share',
//     text: 'Example share text',
//     filePath: docs[0] as String,
//   );
// }