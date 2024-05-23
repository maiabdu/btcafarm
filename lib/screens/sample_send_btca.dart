// import 'package:kadpilgrims/main.dart';
// import 'package:kadpilgrims/models/miningmode.dart';
// import 'package:flutter/material.dart';
// import 'package:otp_screen/otp_screen.dart';

// import '../models/usermodel.dart';
// import 'homescreen/homescreen.dart';

// class SendBTCASA extends StatefulWidget {
//   final User user;
//   final MininingData mininingData;
//   const SendBTCASA({Key? key, required this.user, required this.mininingData}) : super(key: key);

//   @override
//   State<SendBTCASA> createState() => _SendBTCASAState();
// }

// class _SendBTCASAState extends State<SendBTCASA> {
//   Future<String> validateOtp(String otp) async {
//     await Future.delayed(const Duration(milliseconds: 2000));
//     if (otp == "1234") {
//       return '';
//     } else {
//       return "The entered Otp is wrong";
//     }
//   }

//   // action to be performed after OTP validation is success
//   void moveToNextScreen(context) {
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => MyHomePage(
//     //     ),
//     //   ),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OtpScreen.withGradientBackground(
//         topColor: Color(0xFFcc2b5e),
//         bottomColor: Color(0xFF753a88),
//         otpLength: 4,
//         validateOtp: validateOtp,
//         routeCallback: moveToNextScreen,
//         themeColor: Colors.white,
//         titleColor: Colors.white,
//         title: "Phone Number Verification",
//         subTitle: "Enter the code sent to \n +919876543210",
//         icon: Image.asset(
//           'images/phone_logo.png',
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
