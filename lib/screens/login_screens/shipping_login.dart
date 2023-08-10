import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/repository/login_repo/login_otp_repository.dart';
import '../../controller/services/api_services.dart';
import '../../controller/services/login_service/login_otp_service.dart';
import '../../model/error_model.dart';
import '../../model/login_model/login_model.dart';
import '../../model/user_profile_model.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/shipping_member_storage.dart';
import '../dashboard_screens/dashboard_screen.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/widgets.dart';
import '../../widgets/will_pop_widget.dart';
import 'package:http/http.dart' as http;

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
  String? deviceToken = "";
  GetUserModel? getUserModel;

  late LoginWithOtpService _loginWithOtpService;

  final SharedPreferences _pref = GwcApi.preferences!;

  @override
  void initState() {
    super.initState();
    _loginWithOtpService = LoginWithOtpService(repository: repository);
    passwordVisibility = false;
    doctorDeviceToken();
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  void doctorDeviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    deviceToken = preferences.getString("device_token");
    setState(() {});
    print("deviceToken111: $deviceToken");
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
              width: 65.w,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image:
                        const AssetImage("assets/images/Gut wellness logo.png"),
                    height: 10.h,
                  ),
                ),
                SizedBox(height: 3.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "WELCOME TO",
                    style: LoginScreen().welcomeText(),
                  ),
                ),
                SizedBox(height: 1.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Shipping App",
                    style: LoginScreen().doctorAppText(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  cursorColor: newBlackColor,
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email ID';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter your valid Email ID';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline_sharp,
                      color: newBlackColor,
                      size: 12.sp,
                    ),
                    hintText: "   Email",
                    hintStyle: LoginScreen().hintTextField(),
                    suffixIcon: (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.value.text))
                        ? emailController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : InkWell(
                                onTap: () {
                                  emailController.clear();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: newBlackColor,
                                  size: 15,
                                ),
                              )
                        : Icon(
                            Icons.check_circle,
                            color:gSecondaryColor,
                            size: 15.sp,
                          ),
                  ),
                  style: LoginScreen().mainTextField(),
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 5.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: newBlackColor,
                  controller: passwordController,
                  obscureText: !passwordVisibility,
                  textAlignVertical: TextAlignVertical.center,
                  style: LoginScreen().mainTextField(),
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
                      color: newBlackColor,
                      size: 12.sp,
                    ),
                    hintText: "   Password",
                    hintStyle: LoginScreen().hintTextField(),
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
                        color: passwordVisibility
                            ? gSecondaryColor
                            : mediumTextColor,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (ct) => const ForgotPassword()));
                //     },
                //     child: Text(
                //       'Forgot Password?',
                //       style: TextStyle(
                //         fontFamily: "GothamBook",
                //         color: gMainColor,
                //         fontSize: 8.sp,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: (isLoading)
                      ? null
                      : () {
                    if (formKey.currentState!.validate() &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      buildLogin(
                        emailController.text.toString(),
                        passwordController.text.toString(),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      color: gSecondaryColor,
                      // (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //             .hasMatch(emailController.value.text) ||
                      //         !RegExp('[a-zA-Z]')
                      //             //  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                      //             .hasMatch(passwordController.value.text))
                      //     ? gMainColor
                      //     : gPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: (isLoading)
                        ? buildThreeBounceIndicator(color: gWhiteColor)
                        : Center(
                            child: Text(
                              'LOGIN',
                              style: LoginScreen().buttonText(whiteTextColor),
                              // TextStyle(
                              //   fontFamily: "GothamMedium",
                              //   color: gWhiteColor,
                              //   // (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              //   //             .hasMatch(
                              //   //                 emailController.value.text) ||
                              //   //         !RegExp('[a-zA-Z]')
                              //   //             //  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                              //   //             .hasMatch(
                              //   //                 passwordController.value.text))
                              //   //     ? gPrimaryColor
                              //   //     : gMainColor,
                              //   fontSize: 9.sp,
                              // ),
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

  final LoginOtpRepository repository = LoginOtpRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  buildLogin(String phone, String pwd) async {
    setState(() {
      isLoading = true;
    });
    print("---------Login---------");

    final result = await _loginWithOtpService.loginWithOtpService(
        phone, pwd, "$deviceToken");

    if (result.runtimeType == LoginModel) {
      LoginModel model = result as LoginModel;
      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
      _pref.setString(ShippingMemberStorage.shippingMemberName, model.user?.name ?? "");
      _pref.setString(ShippingMemberStorage.shippingMemberEmail, model.user?.email ?? "");
      _pref.setString(ShippingMemberStorage.shippingMemberAddress, model.user?.uvUserId ?? "");

      print("Success Member Email : ${_pref.getString(ShippingMemberStorage.shippingMemberEmail)}");
      saveData(
        model.accessToken ?? '',
        model.user?.loginUsername ?? "",
        // model.user?.chatId ?? "",
        // model.user?.kaleyraUserId ?? "",
      );

      print("Login_Username : ${model.user?.loginUsername}");
      print("chat_id : ${model.user?.chatId}");
      storeUserProfile("${model.accessToken}");
    } else {
      setState(() {
        isLoading = false;
      });
      _pref.setBool(GwcApi.isLogin, false);

      ErrorModel response = result as ErrorModel;
      GwcApi().showSnackBar(context, response.message!, isError: true);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
  }

  storeUserProfile(String accessToken) async {
    dynamic res;

    final response =
    await http.get(Uri.parse(GwcApi.getUserProfileApiUrl), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    print("User Response: ${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      getUserModel = GetUserModel.fromJson(res);
      print(getUserModel!.data!.name);
      _pref.setString(ShippingMemberStorage.shippingMemberName, getUserModel?.data?.name ?? "");
      _pref.setString(ShippingMemberStorage.shippingMemberProfile, getUserModel?.data?.profile ?? "");
      _pref.setString(ShippingMemberStorage.shippingMemberPhone, getUserModel?.data?.phone ?? "");

      print("Success Name : ${_pref.getString(ShippingMemberStorage.shippingMemberName)}");
      print(
          "Success Profile : ${_pref.getString(ShippingMemberStorage.shippingMemberProfile)}");
      print(
          "Success Address : ${_pref.getString(ShippingMemberStorage.shippingMemberAddress)}");
    } else {
      throw Exception();
    }
    return GetUserModel.fromJson(res);
  }

  saveData(String token, String s) async {
    _pref.setBool(GwcApi.isLogin, true);
    _pref.setString("token", token);
  }
}
