import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kadpilgrims/models/miningmode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../models/btadashboardmodel.dart';
import '../models/hotelModel.dart';
import '../models/usermodel.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/homescreen/operationsHomescree.dart';
import '../widgets/dialogue.dart';
import 'package:http/http.dart' as http;

// import 'package:intent/intent.dart' as android_intent;
// import 'package:intent/extra.dart' as android_extra;
// import 'package:intent/typedExtra.dart' as android_typedExtra;
// import 'package:intent/action.dart' as android_action;

final dio = Dio();
String baseUrl = 'http://10.0.2.2:80/kaduna pilgrim/api';

void push(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

pushwithcallback(BuildContext context, Widget widget) {
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

String? validateHajjId(String? value) {
  if (value == '' || value == null) {
    return 'Invalid Hajj ID/Pilgrims ID please input valid Hajj ID/Pilgrims ID';
  } else if (value.length < 7) {
    return 'Hajj ID/Pilgrims ID must be atleast 7 characters';
  } else {
    return null;
  }
}

String? minimum3(String? value) {
  if (value == '' || value == null) {
    return 'bus name cannot be empty';
  } else if (value.length < 3) {
    return 'character must be atleast 3 characters';
  } else {
    return null;
  }
}

String? validateUsername(String? value) {
  if (value == '' || value == null) {
    return 'Username Cannot be empty';
  } else if (value.length < 3) {
    return 'Username cannot be lessthan three characters';
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

        debugPrint(user.fullName);

        await hideProgress();
        push(
            context,
            MyHomePage(
              user: user,
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

//login with hajj id loginwithHajjID
loginwithHajjID(String? email, BuildContext context) async {
  // Timer.periodic(const Duration(seconds: 2), (timer) {
  //   debugPrint(timer.tick.toString());
  // });

  String endpoint = "$baseUrl/getpilgrim.php";

  Map<String, dynamic> data = {
    "pilgrimID": email.toString().trim(),
  };

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    debugPrint(endpoint);
    debugPrint(data.toString());

    final response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonEncode(data),
    );

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      print(userData['pilgrim'][0]['fullName']);

      print(userData);
      // print(userData["pilgrim"].toString());

      if (userData['pilgrim'][0]['success'].toString() == 'true') {
        debugPrint('user found');

        User user = User.fromJson(userData);

        await hideProgress();
        push(
            context,
            MyHomePage(
              user: user,
            ));
        return true;
      }
    }
    // return user;
  } catch (e) {
    return 'netowrk';
  }
}

//login with hajj id loginwithHajjID
operationLogin(String? email, String? password, BuildContext context) async {
  // Timer.periodic(const Duration(seconds: 2), (timer) {
  //   debugPrint(timer.tick.toString());
  // });

  String endpoint =
      "$baseUrl/operationslogin.php?username=$email&password=$password";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    debugPrint(endpoint);
    final response = await http.get(
      Uri.parse(endpoint),
      headers: headers,
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      // print(userData['pilgrim'][0]['user_id']);
      // print(userData['pilgrim'][0]['name']);
      // print(userData["pilgrim"].toString());
      if (userData['pilgrim'][0]['success'].toString() == 'true') {
        debugPrint('user found');

        OperationsUser userOperation = OperationsUser.fromJson(userData);
        debugPrint(userOperation.userID);
        debugPrint(userOperation.name);
        User user = User.fromJson(userData);
        await hideProgress();
        push(
            context,
            OperationsScreen(
              user: userOperation,
            ));
        return true;
      } else {
        // await hideProgress();
        // andriodAlertDialogue(context, 'Invalid Email or Password',
        //     'Please Kindly Input a valid email and password');
      }
    }
    // return user;
  } catch (e) {
    await hideProgress();
    andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return 'netowrk';
  }
}

searchpilgrim(BuildContext context, String? pilgrimCode) {}

pilgrimminfo(String? email, BuildContext context) async {
  String endpoint = "$baseUrl/getpilgrim.php";

  Map<String, dynamic> data = {
    "pilgrimID": email.toString().trim(),
  };

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    debugPrint(endpoint);
    debugPrint(data.toString());

    final response = await http
        .post(
      Uri.parse(endpoint),
      headers: headers,
      body: jsonEncode(data),
    )
        .timeout(
      const Duration(seconds: 8),
      onTimeout: () {
        hideProgress();
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      print(userData['pilgrim'][0]['fullName']);

      print(userData);

      if (userData['pilgrim'] == null) {
        debugPrint('pilgrim data null');
        hideProgress();
        andriodAlertDialogue(context, 'No Record found,',
            'Please check and enter Pilgrim Passport NO');
        return '';
      } else {
        User user = User.fromJson(userData);

        return user;
      }
      // print(userData["pilgrim"].toString());
    }

    if (response.statusCode == 201) {
      debugPrint('pilgrim data null');
      hideProgress();
      andriodAlertDialogue(context, 'No Record found,',
          'Please check and enter Pilgrim Passport NO');
      return '';
    }
    // return user;
  } catch (e) {
    return 'netowrk';
  }
}

pilgrimminfoBTA(String? email, BuildContext context) async {
  String endpoint = "$baseUrl/getpilgrim.php";

  Map<String, dynamic> data = {
    "pilgrimID": email.toString().trim(),
  };

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //run to scheck first

  //function to checkw whether bta is already
  var isGiven = await verifyBTA(email.toString());
  print('isGive ' + isGiven);
  if (isGiven == 'yes') {
    return 'yes';
  } else {
    try {
      debugPrint(endpoint);
      debugPrint(data.toString());

      final response = await http
          .post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(data),
      )
          .timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          hideProgress();
          andriodAlertDialogue(
              context,
              'Operation failed due to slow or no internet access',
              'Try again later');
          // Time has run out, do what you wanted to do.
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );

      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);

        print(userData['pilgrim'][0]['fullName']);

        print(userData);

        if (userData['pilgrim'] == null) {
          debugPrint('pilgrim data null');
          hideProgress();
          andriodAlertDialogue(context, 'No Record found,',
              'Please check and enter Pilgrim Passport NO');
          return 'wrong';
        } else {
          User user = User.fromJson(userData);

          return user;
        }
        // print(userData["pilgrim"].toString());
      }

      if (response.statusCode == 201) {
        debugPrint('pilgrim data null');
        hideProgress();
        andriodAlertDialogue(context, 'No Record found,',
            'Please check and enter Pilgrim Passport NO');
        return '';
      }
      // return user;
    } catch (e) {
      return 'netowrk';
    }
  }
}

Future verifyBTA(String pilgrimId) async {
  var url = Uri.parse('$baseUrl/api/verifybta.php?pid=$pilgrimId');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    var userData = jsonDecode(response.body);
    print('Is ussed' + userData[0]['issued_bta'].toString());

    if (userData[0]['issued_bta'].toString() == 'yes') {
      return 'yes';
    } else {
      return 'no';
    }
  } else {
    // Request failed
    print('Request failed with status: ${response.statusCode}.');
    return '';
  }
}

pilgrimminfowithverification(String? email, BuildContext context) async {
  String endpoint = "$baseUrl/verifyaccomodation.php?pilgrimID=$email";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    debugPrint(endpoint);

    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 8),
      onTimeout: () {
        hideProgress();
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      print(userData['pilgrim'][0]['fullName']);

      print(userData);

      if (userData['pilgrim'][0]['is_accomodated'] == true) {
        return 1;
      } else if (userData['pilgrim'] == null) {
        debugPrint('pilgrim data null');
        hideProgress();
        andriodAlertDialogue(context, 'No Record found,',
            'Please check and enter Pilgrim Passport NO');
        return '';
      } else {
        User user = User.fromJson(userData);

        return user;
      }
      // print(userData["pilgrim"].toString());
    }

    if (response.statusCode == 201) {
      debugPrint('pilgrim data null');
      hideProgress();
      andriodAlertDialogue(context, 'No Record found,',
          'Please check and enter Pilgrim Passport NO');
      return '';
    }
    // return user;
  } catch (e) {
    return 'netowrk';
  }
}

Future issueBTA(String? pid, btaby, BuildContext context) async {
  String endpoint = "$baseUrl/issuebtabycode.php?pid=$pid&btaby=$btaby";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return 'netowrk';
  }
}

Future allocateRoom(
    String? pid, ap, fl, room, acb, rid, BuildContext context) async {
  String endpoint =
      "$baseUrl/allocateaccomodation.php?pid=$pid&ap=$ap&fl=$fl&room=$room&bed=1&acb=$acb&rid=$rid";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return 'netowrk';
  }
}

Future addpilgrimtobus(
    String? busid, route, pilgrimId, uid, BuildContext context) async {
  String endpoint =
      "$baseUrl/addpilgrimtobus.php?bus_id=$busid&route=$route&pilgrimId=$pilgrimId&uid=$uid";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      debugPrint(userData['success'][0]);

      debugPrint(userData);
      debugPrint(userData[0]['pilgrim']);

      return true;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    // TODO::take care of this return
    return true;
  }
}

Future issueManifest(String? pid, btaby, BuildContext context) async {
  String endpoint = "$baseUrl/issuemanifest.php?pid=$pid&btaby=$btaby";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return 'netowrk';
  }
}

Future flightBoarding(String? pid, btaby, BuildContext context) async {
  String endpoint = "$baseUrl/issuemanifest.php?pid=$pid&by=$btaby";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return 'netowrk';
  }
}

Future addbus(String? name, route, createdby, BuildContext context) async {
  String endpoint =
      "$baseUrl/addbus.php?name=$name&route=$route&created_by=$createdby";

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final client = new HttpClient();
  client.connectionTimeout = const Duration(seconds: 10);

  try {
    debugPrint(endpoint);
    final response = await http
        .get(
      Uri.parse(endpoint),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        andriodAlertDialogue(
            context,
            'Operation failed due to slow or no internet access',
            'Try again later');
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);

      String bus = userData[0]['bus'];
      debugPrint(bus);
      await hideProgress();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    await hideProgress();
    // andriodAlertDialogue(context, 'Soemting went wrong', 'Try again later');
    return false;
  }
}

Future<DashboadBTA> fetchDashboadBTA(String uid) async {
  DashboadBTA pilgrim;

  final response =
      await http.get(Uri.parse('$baseUrl/myissuedbta.php?uid=$uid'));

  debugPrint(response.body);
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));

    var decodedJson = jsonDecode(response.body);

    List<DashboadBTA> parsePhotos(String responseBody) {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<DashboadBTA>((json) => DashboadBTA.fromJson(json))
          .toList();
    }

    parsePhotos(decodedJson);

    return DashboadBTA.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DashboadBTA');
  }
}

Future<FetchHotel> fetchAccomodation(String passportNo) async {

  final response = await http
      .get(Uri.parse('$baseUrl/getaccomodation.php?pilgrimID=$passportNo'));

  debugPrint(response.body);
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    var decodedJson = jsonDecode(response.body);
    FetchHotel hotel = FetchHotel.fromJson(decodedJson);
    return hotel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DashboadBTA');
  }
}

// void launchGoogleMaps(latitude, longitude) async {
//   final String googleMapsUrl =
//       'https://maps.google.com/?q=$latitude,$longitude';
//   if (await canLaunch(googleMapsUrl.toString())) {
//     await launch(googleMapsUrl.toString());
//   } else {
//     throw 'Could not launch $googleMapsUrl';
//   }
// }

// Future<void> navigateTo(double lat, double lng) async {
//     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=c");
//     android_intent.Intent()
//       ..setAction(android_action.Action.ACTION_VIEW)
//       ..setData(uri)
//       ..setPackage("com.google.android.apps.maps")
//       ..startActivity().catchError((e) => print(e));
//   }

Future fetchBTAdata() async {}

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
