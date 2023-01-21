import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../screens/dashboard_screens/dashboard_screen.dart';
import '../utils/constants.dart';
import '../utils/gwc_apis.dart';
import '../widgets/widgets.dart';
import '../widgets/will_pop_widget.dart';
import 'forgot_password.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ShippingLogin extends StatefulWidget {
  const ShippingLogin({Key? key}) : super(key: key);

  @override
  State<ShippingLogin> createState() => _ShippingLoginState();
}

class _ShippingLoginState extends State<ShippingLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisibility;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: const AssetImage("assets/images/Group 5022.png"),
              fit: BoxFit.fill,
              height: double.maxFinite,
              width: 80.w,
            ),
            buildForm(),
          ],
        ),
      ),
    );
  }

  buildForm() {
    return Form(
      key: formKey,
      child: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: const AssetImage(
                        "assets/images/Gut wellness logo green.png"),
                    height: 10.h,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "Shipping App",
                  style: TextStyle(
                      fontFamily: "GothamBold",
                      color: gPrimaryColor,
                      fontSize: 10.sp),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: "GothamMedium",
                        color: gSecondaryColor,
                        fontSize: 8.sp),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  cursorColor: gMainColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email ID';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter your valid Email ID';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline_sharp,
                      color: gMainColor,
                      size: 1.h,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      fontFamily: "GothamBook",
                      color: gMainColor,
                      fontSize: 7.sp,
                    ),
                    suffixIcon: (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.value.text))
                        ? emailController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : InkWell(
                                onTap: () {
                                  emailController.clear();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: gMainColor,
                                  size: 3.h,
                                ),
                              )
                        : Padding(
                            padding: EdgeInsets.only(bottom: 1.5.h, top: 1.5.h),
                            child: Image(
                              height: 2.h,
                              image: const AssetImage(
                                "assets/images/Icon awesome-check-circle.png",
                              ),
                            ),
                          ),
                  ),
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gMainColor,
                      fontSize: 7.sp),
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 3.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: kSecondaryColor,
                  controller: passwordController,
                  obscureText: !passwordVisibility,
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gMainColor,
                      fontSize: 7.sp),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Password';
                    }
                    if (!RegExp('[a-zA-Z]')
                        // RegExp(
                        //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                        .hasMatch(value)) {
                      return 'Password may contains alpha numeric';
                    }
                    if (value.length < 6 || value.length > 20) {
                      return 'Password must me 6 to 20 characters';
                    }
                    if (!RegExp('[a-zA-Z]')
                        // RegExp(
                        //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                        .hasMatch(value)) {
                      return 'Password must contains \n '
                          '1-symbol 1-alphabet 1-number';
                    }
                    return null;
                  },
                  onFieldSubmitted: (val) {
                    formKey.currentState!.validate();
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline_sharp,
                      color: gMainColor,
                      size: 1.h,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      fontFamily: "GothamBook",
                      color: gMainColor,
                      fontSize: 7.sp,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: gMainColor,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ct) => const ForgotPassword()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: "GothamBook",
                        color: gSecondaryColor,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: (isLoading)
                      ? null
                      : () {
                          buildLogin();
                        },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      color: (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.value.text) ||
                              !RegExp('[a-zA-Z]')
                                  //  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                                  .hasMatch(passwordController.value.text))
                          ? gMainColor
                          : gPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: (isLoading)
                        ? buildThreeBounceIndicator(color: gMainColor)
                        : Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontFamily: "GothamMedium",
                                color: (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(
                                                emailController.value.text) ||
                                        !RegExp('[a-zA-Z]')
                                            //  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                                            .hasMatch(
                                                passwordController.value.text))
                                    ? gPrimaryColor
                                    : gMainColor,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buildLogin() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        Map<String, dynamic> dataBody = {
          "email": emailController.text.toString(),
          "password": passwordController.text.toString(),
        };
        var response = await http.post(Uri.parse(GwcApi.loginApiUrl),
            body: dataBody);
        if (response.statusCode == 200) {
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> responseData = jsonDecode(response.body);
          saveData(responseData["access_token"]);
          print("Token : ${responseData["access_token"]}");
          if (responseData['status'] == 200) {
            setState(() {
              isLoading = true;
            });
            Get.to(() => const DashboardScreen());
            buildSnackBar("Login", "Successful");
          } else if (responseData['status'] == 401) {
            setState(() {
              isLoading = false;
            });
            buildSnackBar("Login Failed", responseData['message']);
          }
        } else {
          setState(() {
            isLoading = false;
          });
          buildSnackBar("Login Failed", "API Problem");
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        throw Exception();
      }
    } else {
      setState(() {
        isLoading = false;
      });
      buildSnackBar("Invalid Form", "Please complete the form Properly");
    }
  }

  saveData(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
  }
}
