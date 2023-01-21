import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_animations/im_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';

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

Row buildAppBar(VoidCallback func) {
  return Row(
    children: [
      SizedBox(
        height: 1.5.h,
        child: InkWell(
          onTap: func,
          child: const Image(
            image: AssetImage("assets/images/Icon ionic-ios-arrow-back.png"),
          ),
        ),
      ),
      SizedBox(
        height: 6.h,
        child: const Image(
          image: AssetImage("assets/images/Gut wellness logo green.png"),
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
      // width: 75,
      // height: 75,
    )),
  );
}

buildThreeBounceIndicator({Color? color}) {
  return Center(
    child: SpinKitThreeBounce(
      color: color ?? gMainColor,
      size: 30,
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
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      content: Text(
        message,
        style: TextStyle(
          fontFamily: "GothamMedium",
          color: kWhiteColor,
          fontSize: 7.sp,
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
