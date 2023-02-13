import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:btcafarm/models/miningmode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/usermodel.dart';
import '../screens/homescreen/homescreen.dart';
import '../widgets/dialogue.dart';
import 'package:http/http.dart' as http;

void push(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

pushh(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

//helper method to show progress
late ProgressDialog progressDialog;
showProgress(BuildContext context, String message, bool isDismissible) async {
  progressDialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: isDismissible);
  progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Color(COLOR_PRIMARY),
      progressWidget: Container(
          padding: const EdgeInsets.all(8.0),
          child: const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
          )),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: const TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
  await progressDialog.show();
}

updateProgress(String message) {
  progressDialog.update(message: message);
}

hideProgress() async {
  await progressDialog.hide();
}

//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content) {
  // set up the AlertDialog
  Widget okButton = TextButton(
    child: const Text('ok'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  if (Platform.isIOS) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      // actions: [
      //   okButton,
      // ],
    );

    // show the dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      // actions: [
      //   okButton,
      // ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

andriodAlertDialogue(BuildContext context, String title, String content) {
  Widget okButton = TextButton(
    child: const Text('ok'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    // actions: [
    //   okButton,
    // ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogWidget(BuildContext context, Widget widget, String title) {
  // set up the AlertDialog
  Widget okButton = TextButton(
    child: const Text('cancel'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  if (Platform.isIOS) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: widget,
      // actions: [
      //   okButton,
      // ],
    );

    // show the dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    AlertDialog alert = AlertDialog(
      // insetPadding: const EdgeInsets.symmetric(horizontal: 100,vertical: 100),
      title: Text(title),
      content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: widget),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showAlertDialogWithFunction(
    BuildContext context, String title, String content, VoidCallback f) {
  // set up the AlertDialog
  Widget okButton = TextButton(
    child: const Text('ok'),
    onPressed: f,
  );
  if (Platform.isIOS) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => predict);
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Invalid e-mail, please input valid email';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return 'Password Lenght must be atleast 6';
  } else {
    return null;
  }
}

loginWithEmail(String? email, String? password, BuildContext context) async {
  // Timer.periodic(const Duration(seconds: 2), (timer) {
  //   debugPrint(timer.tick.toString());
  // });

  String? endpoint =
      "https://api.thebitcoinafrica.com/account/loginWithPasswordAndEmail";

  Map<String, dynamic> user = {
    'email': email.toString().trim(),
    'password': password.toString().trim(),
  };

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonEncode(user),
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      print(userData['message']);
      print(userData);
      print(userData["success"].toString());

      if (userData["success"].toString() == 'true') {
        debugPrint('user found');
        User user = User.fromJson(userData);

        MininingData userminingDatag = await getMiningData(user.userId);
        // MininingData userminingData = MininingData.fromJson(mining);
        debugPrint(userminingDatag.packageName);

        await hideProgress();
        push(
            context,
            MyHomePage(
              user: user,
              miningData: userminingDatag,
            ));
        return true;
        // return user;
      } else if (userData['message'].toString() ==
          'An OTP has been sent your email, kindly confirm your email') {
        await hideProgress();
        debugPrint('check your email and password');
        return 'verify';
      } else if (userData["success"].toString() == "0") {
        await hideProgress();
        debugPrint('check your email and password');
        return 0;
      } else if (userData["success"].toString() == "false") {
        await hideProgress();
        return false;
      }
    } else if (response.statusCode == 401) {
      await hideProgress();
      andriodAlertDialogue(context, 'Invalid Email or Password',
          'Please Kindly Input a valid email and password');
    }
  } catch (e) {
    return 'netowrk';
  }
}

//get mining data
Future getMiningData(String? userid) async {
  debugPrint('starting api coall');
  String? endpoint =
      "http://www.btcafarm.com/includes/mobileApi.php?userID=$userid&getMiningData=true";
      // "http://localhost/btcafarm-2/includes/mobileApi.php?userID=$userid&getMiningData=true";

  try {
    final response = await http.get(Uri.parse(endpoint));
    debugPrint((response.body));
    debugPrint((response.statusCode.toString()));
    if (response.statusCode.toString() == '200') {
      var miningDat = jsonDecode(response.body);
      Map miningData = miningDat.asMap();
      print(miningData);
      print(miningData[0]['packageName']);
      print(miningData[0]['minnedThisMonth']);
      print(miningData[0]['minnedToday']);
      print(miningData[0]['maxLoad']);
      print(miningData[0]['monthRemaining']);
      print(miningData[0]["success"].toString());

      // debugPrint('Minining data ');
      MininingData mininingResult = MininingData.fromJson(miningData);
      debugPrint(mininingResult.packageName);
      return mininingResult;
    }
  } catch (e) {
    return 'eror: $e';
  }
}

Future saveUserCredentials(String? email, String? password) async {
  print('save user details called');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final prefs = await _prefs;

  await prefs.setString('email', email!.toString());
  await prefs.setString('password', password!.toString());
  await prefs.setBool('autoLogin', true);

  //reading and displaying data
  final String? savedEmail = prefs.getString('email');
  final String? savedPassword = prefs.getString('password');
  final bool? autoLogin = prefs.getBool('autoLogin');
  print(savedEmail);
  print(savedPassword);
  print(autoLogin);
}
