import 'package:SFM/DataCollection/o_auth_widgets.dart';
import 'package:SFM/practice/error_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/NextButton.dart';
import 'package:SFM/CommonWidgets/NormalButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/CommonWidgets/TextInput.dart';
import 'package:SFM/Dashboard/Dashboard.dart';
import 'package:SFM/DataCollection/QuitDate.dart';
import 'package:SFM/DataCollection/Signup.dart';
import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/Loading_contoller.dart';

import 'package:SFM/Get_X_Controller/UserStatusController.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  APIController apiController = Get.find<APIController>();
  UserStatusController userStatus = Get.find<UserStatusController>();
  LoadingController loadingController = Get.find<LoadingController>();

  bool _emailValidate = true;

  bool _passwordValidate = true;

  GetStorage storage = GetStorage();
  ScrollController scrollController = ScrollController();
  bool isConnected = true;

  Future<String> googleOAuth() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final data = await googleSignIn.signIn();
      if (data == null) return '';
      final gAuth = await data.authentication;

      final gaCredintial = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(gaCredintial);
      print("${data.email}${data.displayName}");
      String userType =
          await apiController.oauth(email: data.email, uname: data.displayName);
      return userType;
    } catch (e) {
      Get.snackbar('Google', "Something went wrong for google");
      print(e);
      return "Error";
    }
  }

  void oauthFunction() async {
    if (isConnected) {
      OverlayEntry loading = await loadingController.overlayLoading();
      Overlay.of(context).insert(loading);
      String page = await googleOAuth();

      if (page == "newUser") {
        Get.to(() => QuitDatePicker(),
            arguments: "isRegister",
            transition: Transition.rightToLeft,
            curve: Curves.easeInOut);
      } else if (page == "OldUser") {
        userStatus.stopTimer(runTimer: true);
        Get.to(() => const Dashboard(),
            transition: Transition.rightToLeft,
            arguments: "isLogged",
            curve: Curves.easeInOut);
      }
      loading.remove();
    } else {
      // Get.to(() => ErrorTest(errorText: errorText));
      print("oauth else working");
      checkInternetConnection();
    }
  }

  checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    print(result);

    if (result == true) {
      if (isConnected != true) {
        setState(() {
          isConnected = true;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text("Make sure your Internet Connection"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text("Close"))
              ],
              // backgroundColor: Colors.transparent,
              elevation: 0,
              // contentPadding: EdgeInsets.zero,
            );
          });
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // bool isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: BackgroundContainer(
            isDashboard: false,
            child: Container(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      height: screenSize.height / 1.05,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Container(
                              padding: const EdgeInsets.only(top: 30),
                              child: Image.asset(
                                'assets/images/hill.png',
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextInput(
                                    controller: _emailController,
                                    hintText: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    isValidate: _emailValidate,
                                  ),
                                  const SizedBox(height: 15),
                                  TextInput(
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    showIcon: true,
                                    isPassword: true,
                                    isValidate: _passwordValidate,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            apiController.forgetPassword(
                                                context,
                                                email: _emailController.text);
                                          },
                                          child: Text(
                                            'Forgot Password',
                                            style: TextStyle(
                                                color:
                                                    QCColors.secondaryTexColor),
                                          ))
                                    ],
                                  ),
                                  NormalButton(
                                    buttonName: "Login",
                                    onPressed: () async {
                                      if (_emailController.text.isEmail) {
                                        _emailValidate = true;

                                        if (_passwordController.text.length <
                                            6) {
                                          setState(() {
                                            _passwordValidate = false;
                                          });
                                          return;
                                        }
                                        if (isConnected) {
                                          OverlayEntry loading =
                                              await loadingController
                                                  .overlayLoading();
                                          Overlay.of(context).insert(loading);

                                          bool isLogged =
                                              await apiController.login(
                                                  password:
                                                      _passwordController.text,
                                                  email: _emailController.text);
                                          if (isLogged) {
                                            // userStatus.readSessionData();
                                            loading.remove();
                                            userStatus.stopTimer(
                                                runTimer: true);
                                            Get.to(() => const Dashboard(),
                                                transition:
                                                    Transition.rightToLeft,
                                                arguments: "isLogged",
                                                curve: Curves.easeInOut);
                                          } else {
                                            loading.remove();
                                          }
                                        } else {
                                          print("login else working");
                                          checkInternetConnection();
                                        }
                                      } else {
                                        setState(() {
                                          _emailValidate = false;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 5,
                                  width: MediaQuery.of(context).size.width - 50,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Colors.white10,
                                    Colors.white70,
                                    Colors.white10
                                  ])),
                                ),
                                OAUthWidgets(onPressed: oauthFunction),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Get.to(() => Signup(),
                                            transition: Transition.leftToRight,
                                            curve: Curves.easeInOut);
                                      },
                                      splashColor: Colors.white30,
                                      colorBrightness: Brightness.light,
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "Not a Member?   ",
                                              style: TextStyle(
                                                  color: QCColors
                                                      .secondaryTexColor,
                                                  fontSize: 18)),
                                          TextSpan(
                                            text: 'Register Now',
                                            style: TextStyle(
                                                color: QCColors.inputTextColor,
                                                fontSize: 18),
                                          )
                                        ]),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      )),
    );
  }
}
