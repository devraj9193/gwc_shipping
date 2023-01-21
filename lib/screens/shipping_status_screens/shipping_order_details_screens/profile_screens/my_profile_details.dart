import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/widgets.dart';

class MyProfileDetails extends StatefulWidget {
  const MyProfileDetails({Key? key}) : super(key: key);

  @override
  State<MyProfileDetails> createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.5.h, left: 4.w, right: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppBar(() {
                      Navigator.pop(context);
                    }),
                    SizedBox(height: 2.h),
                    Text(
                      "My Profile",
                      style: TextStyle(
                          fontFamily: "GothamBold",
                          color: gPrimaryColor,
                          fontSize: 8.sp),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(color: gMainColor, width: 0.1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: const AssetImage("assets/images/cheerful.png"),
                      fit: BoxFit.cover,
                      height: 40.h,
                      width: 80.w,
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profileTile("Name : ", "Gut-Wellness Club"),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2.5.h),
                              height: 1,
                              color: gBlackColor.withOpacity(0.1),
                            ),
                            profileTile("Age : ", "34"),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2.5.h),
                              height: 1,
                              color: gBlackColor.withOpacity(0.1),
                            ),
                            profileTile("Gender : ", "Female"),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2.5.h),
                              height: 1,
                              color: gBlackColor.withOpacity(0.1),
                            ),
                            profileTile("Email : ", "Gutwellness@nomail.com"),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2.5.h),
                              height: 1,
                              color: gBlackColor.withOpacity(0.1),
                            ),
                            profileTile("Mobile Number : ", "9940304777"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileTile(String title, String subTitle) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: gBlackColor,
            fontFamily: 'GothamBold',
            fontSize: 8.sp,
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            style: TextStyle(
              color: gBlackColor,
              fontFamily: 'GothamMedium',
              fontSize: 7.sp,
            ),
          ),
        ),
      ],
    );
  }
}
