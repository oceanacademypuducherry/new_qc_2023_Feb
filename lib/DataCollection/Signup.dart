import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:SFM/CommonWidgets/BackgroundContainer.dart';
import 'package:SFM/CommonWidgets/NextButton.dart';
import 'package:SFM/CommonWidgets/NormalButton.dart';
import 'package:SFM/CommonWidgets/QC_Colors.dart';
import 'package:SFM/CommonWidgets/TextInput.dart';
import 'package:SFM/DataCollection/Login.dart';
import 'package:SFM/DataCollection/QuitDate.dart';
import 'package:SFM/Get_X_Controller/API_Controller.dart';
import 'package:SFM/Get_X_Controller/DataCollectionController.dart';
import 'package:SFM/Get_X_Controller/Loading_contoller.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  APIController apiController = Get.find<APIController>();
  LoadingController loadingController = Get.find<LoadingController>();

  bool _nameValidate = true;

  bool _emailValidate = true;

  bool _passwordValidate = true;

  bool isConnected = true;

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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: BackgroundContainer(
          isDashboard: false,
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight / 1.05,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Image.asset(
                          'assets/images/hill.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextInput(
                                hintText: 'Name',
                                controller: _usernameController,
                                isValidate: _nameValidate,
                              ),
                              TextInput(
                                hintText: 'Email',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                isValidate: _emailValidate,
                              ),
                              TextInput(
                                hintText: 'Password',
                                controller: _passwordController,
                                isPassword: true,
                                showIcon: true,
                                isValidate: _passwordValidate,
                              ),
                              const SizedBox(),
                              NormalButton(
                                buttonName: "SignUp",
                                onPressed: () async {
                                  if (_emailController.text.isEmail) {
                                    _emailValidate = true;
                                    //TODO: check password from DB
                                    print(_usernameController.text.length < 3);
                                    if (_usernameController.text.length < 3) {
                                      setState(() {
                                        _nameValidate = false;
                                      });
                                      return;
                                    } else {
                                      setState(() {
                                        _nameValidate = true;
                                      });
                                    }

                                    if (_passwordController.text.length < 6) {
                                      setState(() {
                                        _passwordValidate = false;
                                      });
                                      return;
                                    } else {
                                      setState(() {
                                        _passwordValidate = true;
                                      });
                                    }

                                    if (isConnected) {
                                      OverlayEntry loading =
                                          await loadingController
                                              .overlayLoading();
                                      Overlay.of(context).insert(loading);

                                      bool isSigned =
                                          await apiController.signUp(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              uname: _usernameController.text);

                                      if (isSigned) {
                                        loading.remove();
                                        Get.to(() => QuitDatePicker(),
                                            arguments: "isRegister",
                                            transition: Transition.rightToLeft,
                                            curve: Curves.easeInOut);
                                      } else {
                                        loading.remove();
                                      }
                                    } else {
                                      print("signup else working");
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
                              height: 10,
                              width: MediaQuery.of(context).size.width - 50,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Colors.white10,
                                Colors.white70,
                                Colors.white10
                              ])),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NextButton(
                                    child: Image.asset(
                                      'assets/images/oauth/g.png',
                                      height: screenHeight / 25,
                                      width: screenHeight / 25,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  NextButton(
                                    child: Image.asset(
                                      'assets/images/oauth/apple.png',
                                      height: screenHeight / 25,
                                      width: screenHeight / 25,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  NextButton(
                                    child: Image.asset(
                                      'assets/images/oauth/fb.png',
                                      height: screenHeight / 25,
                                      width: screenHeight / 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Get.to(Login(),
                                        transition: Transition.rightToLeft,
                                        curve: Curves.easeInOut);
                                  },
                                  splashColor: Colors.white30,
                                  colorBrightness: Brightness.light,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "Already have an account?   ",
                                          style: TextStyle(
                                              color:
                                                  QCColors.secondaryTexColor)),
                                      TextSpan(
                                        text: 'Login',
                                        style: TextStyle(
                                            color: QCColors.inputTextColor),
                                      )
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
