import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controller/user_profile_controller.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';

class MyProfileDetails extends StatefulWidget {
  const MyProfileDetails({Key? key}) : super(key: key);

  @override
  State<MyProfileDetails> createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  UserProfileController userProfileController =
      Get.put(UserProfileController());

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
                    SizedBox(height: 1.h),
                    Text(
                      "My Profile",
                      style: ProfileScreenText().headingText(),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              buildUserDetails(),
            ],
          ),
        ),
      ),
    );
  }

  buildUserDetails() {
    return FutureBuilder(
        future: userProfileController.fetchUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              child: Image(
                image: const AssetImage("assets/images/Group 5294.png"),
                height: 35.h,
              ),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(color: lightTextColor, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image:
                    // const AssetImage("assets/images/cheerful.png"),
                     NetworkImage(data.data.profile.toString(),),
                    fit: BoxFit.fill,
                    height: 40.h,
                    width: 70.w,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileTile("Name : ", data.data.name ?? ""),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.5.h),
                            height: 1,
                            color: gBlackColor.withOpacity(0.1),
                          ),
                          profileTile("Age : ", data.data.age ?? ""),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.5.h),
                            height: 1,
                            color: gBlackColor.withOpacity(0.1),
                          ),
                          profileTile("Gender : ", data.data.gender ?? ""),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.5.h),
                            height: 1,
                            color: gBlackColor.withOpacity(0.1),
                          ),
                          profileTile("Email : ", data.data.email ?? ""),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.5.h),
                            height: 1,
                            color: lightTextColor.withOpacity(0.2),
                          ),
                          profileTile("Mobile Number : ", data.data.phone ?? ""),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: buildCircularIndicator(),
          );
        });
  }

  profileTile(String title, String subTitle) {
    return Row(
      children: [
        Text(title, style: ProfileScreenText().nameText()),
        Expanded(
          child: Text(subTitle, style: ProfileScreenText().otherText()),
        ),
      ],
    );
  }
}
