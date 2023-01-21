import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/login_screens/shipping_login.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants.dart';
import 'my_profile_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                SizedBox(
                  height: 5.h,
                  child: const Image(
                    image:
                        AssetImage("assets/images/Gut wellness logo green.png"),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "My Profile",
                  style: TextStyle(
                      fontFamily: "GothamBold",
                      color: gPrimaryColor,
                      fontSize: 8.sp),
                ),
                SizedBox(height: 1.5.h),
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
                        radius: 2.5.h,
                        backgroundImage:
                            const AssetImage("assets/images/cheerful.png"),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lorem Ipsum dadids",
                            style: TextStyle(
                                fontFamily: "GothamMedium",
                                color: gBlackColor,
                                fontSize: 8.sp),
                          ),
                          SizedBox(height: 0.8.h),
                          Text(
                            "Bangalore, India",
                            style: TextStyle(
                                fontFamily: "GothamBook",
                                color: gBlackColor.withOpacity(0.5),
                                fontSize: 6.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
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
                profileTile("assets/images/Group 2747.png", "FAQ", () {
                  buildFAQ();
                }),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  color: Colors.grey.withOpacity(0.3),
                ),
                profileTile(
                    "assets/images/Group 2748.png", "Terms & Conditions", () {
                  buildTermsAndConditions(context);
                }),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  color: Colors.grey.withOpacity(0.3),
                ),
                profileTile("assets/images/Group 2744.png", "Logout", () {
                  dialog(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileTile(String image, String title, func) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: gBlackColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Image(
            image: AssetImage(image),
            height: 3.h,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'GothamMedium',
              fontSize: 7.sp,
            ),
          ),
        ),
        GestureDetector(
          onTap: func,
          child: Icon(
            Icons.arrow_forward_ios,
            color: gBlackColor,
            size: 2.h,
          ),
        ),
      ],
    );
  }

  void buildFAQ() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.only(right: 30.w,left: 30.w,top: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "FAQ",
                  style: TextStyle(
                    color: gMainColor,
                    fontFamily: 'GothamMedium',
                    fontSize: 9.sp,
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 40.w),
                color: Colors.grey.withOpacity(0.8),
              ),
              SizedBox(
                height: 1.h,
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
              buildQuestions(
                  "Lorem lpsum is simply dummy text of the printing ?"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                height: 1,
                color: Colors.grey.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildQuestions(String title) {
    return Text(
      title,
      style: TextStyle(
        color: gTextColor,
        fontFamily: 'GothamMedium',
        fontSize: 6.sp,
      ),
    );
  }

  void buildTermsAndConditions(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: gMainColor,
                    fontFamily: 'GothamMedium',
                    fontSize: 9.sp,
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 40.w),
                color: Colors.grey.withOpacity(0.8),
              ),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.It has survived not only five centuries,but also the leap into electronic typesetting,remaining essentially unchanged.It was popularised in the 1960s with the release of Letraset sheets containing Lorem lpsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem lpsum. long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem lpsum is that it has amore_or_less normal distribution of letters, as opposed to using \'Content here,content here\',making it look like readable english. Many desktop publishing packages and web page editors now use Lorem lpsum as their default model text,and asearch for \'lorem lpsum\' will uncover many web sites still in their infancy.Various versions have evolved over the years,sometimes by accident, sometimes on purpose(injected humour and the like).',
                style: TextStyle(
                  height: 1.8,
                  fontSize: 7.sp,
                  color: gTextColor,
                  fontFamily: "GothamMedium",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: gWhiteColor.withOpacity(0.8),
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: gWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gMainColor, width: 0.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Log Out ?",
                style: TextStyle(
                  color: gTextColor,
                  fontFamily: "GothamMedium",
                  fontSize: 9.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text('Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "GothamBook",
                    color: gTextColor,
                    fontSize: 8.sp,
                  )),
              SizedBox(height: 2.5.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gWhiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: gMainColor),
                        ),
                        child: Text("Cancel",
                            style: TextStyle(
                              color: gPrimaryColor,
                              fontFamily: "GothamMedium",
                              fontSize: 7.sp,
                            ))),
                  ),
                  SizedBox(width: 3.w),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      preferences.commit();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ShippingLogin(),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: gMainColor),
                        ),
                        child: Text("Log Out",
                            style: TextStyle(
                              color: gMainColor,
                              fontFamily: "GothamMedium",
                              fontSize: 7.sp,
                            ))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
