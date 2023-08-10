import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/repository/login_repo/login_otp_repository.dart';
import '../../controller/services/api_services.dart';
import '../../controller/services/login_service/login_otp_service.dart';
import '../../model/error_model.dart';
import '../../model/login_model/logout_model.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../utils/shipping_member_storage.dart';
import '../../widgets/widgets.dart';
import '../login_screens/shipping_login.dart';
import 'my_profile_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SharedPreferences _pref = GwcApi.preferences!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            top: 1.h,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDashboardAppBar(),
                SizedBox(height: 1.h),
                Text(
                  "My Profile",
                  style: ProfileScreenText().headingText(),
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 13),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 3.h,
                        backgroundImage: NetworkImage(
                          "${_pref.getString(ShippingMemberStorage.shippingMemberProfile)}",
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_pref.getString(ShippingMemberStorage.shippingMemberName)}",
                            style: AllListText().headingText(),
                          ),
                          Text(
                            "${_pref.getString(ShippingMemberStorage.shippingMemberPhone)}",
                            style: AllListText().otherText(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                profileTile("assets/images/Group 2753.png", "My Profile", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyProfileDetails(),
                    ),
                  );
                }),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  color: Colors.grey.withOpacity(0.3),
                ),
                // profileTile("assets/images/Group 2747.png", "FAQ", () {
                //   buildFAQ();
                // }),
                // Container(
                //   height: 1,
                //   margin: EdgeInsets.symmetric(vertical: 2.h),
                //   color: Colors.grey.withOpacity(0.3),
                // ),
                // profileTile("assets/images/Group 2748.png",
                //     "Terms & Conditions", () {
                //   buildTermsAndConditions(context);
                // }),
                // Container(
                //   height: 1,
                //   margin: EdgeInsets.symmetric(vertical: 2.h),
                //   color: Colors.grey.withOpacity(0.3),
                // ),
                profileTile("assets/images/Group 2744.png", "Logout", () {
                  logoutDialog(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileTile(String image, String title, func) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: gBlackColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image(
              image: AssetImage(image),
              height: 5.h,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              title,
              style: ProfileScreenText().subHeadingText(),
            ),
          ),
          GestureDetector(
            onTap: func,
            child: Icon(
              Icons.arrow_forward_ios,
              color: gBlackColor,
              size: 2.5.h,
            ),
          ),
        ],
      ),
    );
  }

  void logoutDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        barrierColor: gWhiteColor.withOpacity(0.8),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (_, setstate) {
            logoutProgressState = setstate;
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: gWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightTextColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Log Out ?",
                      style: TextStyle(
                        color: newBlackColor,
                        fontFamily: fontBold,
                        fontSize: fontSize11,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text('Are you sure you want to log out?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: fontBook,
                          color: newBlackColor,
                          fontSize: fontSize10,
                        )),
                    SizedBox(height: 2.5.h),
                    (showLogoutProgress)
                        ? Center(child: buildCircularIndicator())
                        : Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: gWhiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: lightTextColor),
                              ),
                              child: Text("Cancel",
                                  style: TextStyle(
                                    color: newBlackColor,
                                    fontFamily: fontMedium,
                                    fontSize: fontSize09,
                                  ))),
                        ),
                        SizedBox(width: 3.w),
                        GestureDetector(
                          onTap: () async {
                            logOut();
                            // SharedPreferences preferences =
                            //     await SharedPreferences.getInstance();
                            // preferences.clear();
                            // preferences.commit();
                            // Get.to(const DoctorLogin());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: gSecondaryColor,
                                borderRadius: BorderRadius.circular(8),
                                // border: Border.all(color: gMainColor),
                              ),
                              child: Text("Log Out",
                                  style: TextStyle(
                                    color: whiteTextColor,
                                    fontFamily: fontMedium,
                                    fontSize: fontSize09,
                                  ))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  bool showLogoutProgress = false;

  var logoutProgressState;

  final LoginOtpRepository repository = LoginOtpRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  void logOut() async {
    logoutProgressState(() {
      showLogoutProgress = true;
    });
    final res =
    await LoginWithOtpService(repository: repository).logoutService();

    if (res.runtimeType == LogoutModel) {
      clearAllUserDetails();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ShippingLogin(),
      ));
    } else {
      ErrorModel model = res as ErrorModel;
      Get.snackbar(
        "",
        model.message!,
        colorText: gWhiteColor,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: gSecondaryColor.withOpacity(0.55),
      );
    }

    logoutProgressState(() {
      showLogoutProgress = true;
    });
  }

  clearAllUserDetails() {
    _pref.setBool(GwcApi.isLogin, false);
    _pref.remove("token");

    _pref.remove(ShippingMemberStorage.shippingMemberName);
    _pref.remove(ShippingMemberStorage.shippingMemberPhone);
    // _pref.remove(AppConfig.User_Profile);
    // _pref.remove(AppConfig.User_Number);
  }

// void buildFAQ() {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) => Container(
//       margin: EdgeInsets.only(right: 30.w, left: 30.w, top: 15.h),
//       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
//       decoration: const BoxDecoration(
//         color: kWhiteColor,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 "FAQ",
//                 style: TextStyle(
//                   color: gMainColor,
//                   fontFamily: 'GothamMedium',
//                   fontSize: 9.sp,
//                 ),
//               ),
//             ),
//             Container(
//               height: 1,
//               margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 40.w),
//               color: Colors.grey.withOpacity(0.8),
//             ),
//             SizedBox(
//               height: 1.h,
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//             buildQuestions(
//                 "Lorem lpsum is simply dummy text of the printing ?"),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 2.h),
//               height: 1,
//               color: Colors.grey.withOpacity(0.4),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// buildQuestions(String title) {
//   return Text(
//     title,
//     style: TextStyle(
//       color: gTextColor,
//       fontFamily: 'GothamMedium',
//       fontSize: 6.sp,
//     ),
//   );
// }
//
// void buildTermsAndConditions(BuildContext context) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) => Container(
//       height: double.maxFinite,
//       width: double.maxFinite,
//       margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 1.h),
//       padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.5.h),
//       decoration: BoxDecoration(
//         color: gWhiteColor,
//         borderRadius: BorderRadius.circular(40),
//       ),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Center(
//               child: Text(
//                 "Terms & Conditions",
//                 style: TextStyle(
//                   color: gMainColor,
//                   fontFamily: 'GothamMedium',
//                   fontSize: 9.sp,
//                 ),
//               ),
//             ),
//             Container(
//               height: 1,
//               margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 40.w),
//               color: Colors.grey.withOpacity(0.8),
//             ),
//             Text(
//               'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.It has survived not only five centuries,but also the leap into electronic typesetting,remaining essentially unchanged.It was popularised in the 1960s with the release of Letraset sheets containing Lorem lpsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem lpsum. long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem lpsum is that it has amore_or_less normal distribution of letters, as opposed to using \'Content here,content here\',making it look like readable english. Many desktop publishing packages and web page editors now use Lorem lpsum as their default model text,and asearch for \'lorem lpsum\' will uncover many web sites still in their infancy.Various versions have evolved over the years,sometimes by accident, sometimes on purpose(injected humour and the like).',
//               style: TextStyle(
//                 height: 1.8,
//                 fontSize: 7.sp,
//                 color: gTextColor,
//                 fontFamily: "GothamMedium",
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

}
