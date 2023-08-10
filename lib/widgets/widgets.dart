import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_animations/im_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../screens/dashboard_screens/notification_screen.dart';
import '../utils/common_screen_widget.dart';
import '../utils/constants.dart';

List shippingDetails = [
  {
    "title": "Mainfest",
    "image": "assets/images/Group 3007.png",
    "id": "1",
  },
  {
    "title": "Labels",
    "image": "assets/images/Group 3009.png",
    "id": "2",
  },
  {
    "title": "Welcome Letter",
    "image": "assets/images/Group 3009.png",
    "id": "3",
  }
];

Center buildLoadingBar() {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: gPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gMainColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      child: SizedBox(
        height: 2.5.h,
        width: 5.w,
        child: const CircularProgressIndicator(
          color: gMainColor,
          strokeWidth: 2.5,
        ),
      ),
    ),
  );
}

profileTile(String title, String subTitle) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AllListText().otherText(),
        ),
        Expanded(
          child: Text(
            subTitle,
            style: AllListText().subHeadingText(),
          ),
        ),
      ],
    ),
  );
}

SnackbarController buildSnackBar(String title, String subTitle) {
  return Get.snackbar(
    title,
    subTitle,
    titleText: Text(
      title,
      style: TextStyle(
        fontFamily: "PoppinsSemiBold",
        color: kWhiteColor,
        fontSize: 13.sp,
      ),
    ),
    messageText: Text(
      subTitle,
      style: TextStyle(
        fontFamily: "PoppinsMedium",
        color: kWhiteColor,
        fontSize: 12.sp,
      ),
    ),
    backgroundColor: kPrimaryColor.withOpacity(0.5),
    snackPosition: SnackPosition.BOTTOM,
    colorText: kWhiteColor,
    margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    borderRadius: 10,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.decelerate,
  );
}

Row buildDashboardAppBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        height: 7.h,
        child: const Image(
          image: AssetImage("assets/images/Gut wellness logo.png"),
        ),
      ),
      IconButton(
        onPressed: () {
          Get.to(() => const NotificationScreen());
        },
        icon: Icon(
          Icons.notifications_outlined,
          color: newBlackColor,
          size: 3.5.h,
        ),
      ),
    ],
  );
}

Row buildAppBar(VoidCallback func) {
  return Row(
    children: [
      SizedBox(
        height: 2.h,
        child: InkWell(
          onTap: func,
          child: const Image(
            color: gMainColor,
            image: AssetImage("assets/images/Icon ionic-ios-arrow-back.png"),
          ),
        ),
      ),
      SizedBox(width: 2.w),
      SizedBox(
        height: 7.h,
        child: const Image(
          image: AssetImage("assets/images/Gut wellness logo.png"),
        ),
      ),
    ],
  );
}

Center buildCircularIndicator() {
  return Center(
    child: HeartBeat(
        child: Image.asset(
      'assets/images/progress_logo.png',
      height: 15.h,
    )),
  );
}

buildThreeBounceIndicator({Color? color}) {
  return Center(
    child: SpinKitThreeBounce(
      color: color ?? gMainColor,
      size: 50,
    ),
  );
}

showSnackBar(BuildContext context, String message, Color color,
    {int? duration, bool? isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      content: Text(
        message,
        style: TextStyle(
          fontFamily: fontMedium,
          color: gWhiteColor,
          fontSize: fontSize10,
        ),
      ),
      duration: Duration(seconds: duration ?? 2),
    ),
  );
}

fixedSnackBar(
    BuildContext context, String message, Color color, String btnName, onPress,
    {Duration? duration, bool? isError}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      backgroundColor: (isError == null || isError == false)
          ? gPrimaryColor
          : Colors.redAccent,
      content: Text(
        message,
        style: TextStyle(
          fontFamily: "GothamMedium",
          color: kWhiteColor,
          fontSize: 12.sp,
        ),
      ),
      actions: [TextButton(onPressed: onPress, child: Text(btnName))],
    ),
  );
}
