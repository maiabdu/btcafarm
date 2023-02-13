import 'dart:async';

import 'package:btcafarm/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../models/usermodel.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController? password_ = TextEditingController();
  TextEditingController? email_ = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isloading = false;
  bool hidePassword = true;
  late String email, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = 'asdf';
    password = 'fdsa';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/3.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 33,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.4),
              child: Column(children: [
                Image.asset(
                  'assets/img/btca1.png',
                  alignment: Alignment.center,
                  width: 170,
                ),
                Text(
                  'BTCA FARM',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: email_,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: password_,
                        validator: validatePassword,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                if (globalFormKey.currentState?.validate() ??
                                    false) {
                                  globalFormKey.currentState!.save();
                                  String? password = password_?.text.toString();
                                  String? email = email_?.text.toString();
                                  // print(password);

                                  bool stopLogging = true;
                                  Timer timer = Timer(
                                      const Duration(seconds: 120), () async {
                                    debugPrint("Print after 10 seconds");
                                    if (stopLogging = true) {
                                      await hideProgress();
                                      andriodAlertDialogue(context, 'Oops',
                                          'Something Went Wrong, Please try again later');
                                    }
                                    ;
                                  });
                                  showProgress(
                                      context,
                                      'Please wait as we log you into your account',
                                      true);
                                  var login = await loginWithEmail(
                                      email, password, context);

                                  if (login == true) {
                                    timer.cancel();
                                    stopLogging = false;

                                    //set preferences for auto login
                                    await saveUserCredentials(
                                        email, password);
                                    debugPrint('returned true after loggin');
                                  }

                                  if (login == false) {
                                    timer.cancel();
                                    stopLogging = false;
                                    andriodAlertDialogue(
                                        context,
                                        'Login Failed',
                                        'No User Found, Check your email and password and try again');
                                  }

                                  if (login == 0) {
                                    timer.cancel();
                                    stopLogging = false;
                                    andriodAlertDialogue(
                                        context,
                                        'Login Failed',
                                        'No User Found, Check your email and password and try again');
                                  }

                                  if (login == 110) {
                                    timer.cancel();
                                    stopLogging = false;
                                    andriodAlertDialogue(context, 'Oops',
                                        'Something went wrong, please try again');
                                  }

                                  if (login == 'verify') {
                                    timer.cancel();
                                    stopLogging = false;
                                    andriodAlertDialogue(
                                        context,
                                        'Verify Your Account',
                                        'Your email address is not Verified, please verify your email address before logging in ');
                                  }
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}



      // TextFormField(
      //                   keyboardType: TextInputType.emailAddress,
      //                   // onSaved: (input) => loginRequestModel.email = input,
      //                   validator: (input) => !input.contains('@')
      //                       ? "Email Id should be valid"
      //                       : null,
      //                   decoration: new InputDecoration(
      //                     hintText: "Email Address",
      //                     enabledBorder: UnderlineInputBorder(
      //                         borderSide: BorderSide(
      //                             color: Theme.of(context)
      //                                 .accentColor
      //                                 .withOpacity(0.2))),
      //                     focusedBorder: UnderlineInputBorder(
      //                         borderSide: BorderSide(
      //                             color: Theme.of(context).accentColor)),
      //                     prefixIcon: Icon(
      //                       Icons.email,
      //                       color: Theme.of(context).accentColor,
      //                     ),
      //                   ),
      //                 ),
