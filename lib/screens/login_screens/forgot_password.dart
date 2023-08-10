import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h, bottom: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildAppBar(() {
                      Navigator.pop(context);
                    }),
                    Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "GothamRoundedBold_21016",
                          color: gPrimaryColor,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
