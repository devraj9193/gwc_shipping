import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';

class WillPopWidget extends StatefulWidget {
  final Widget? child;
  const WillPopWidget({Key? key, this.child}) : super(key: key);

  @override
  _WillPopWidgetState createState() => _WillPopWidgetState();
}

class _WillPopWidgetState extends State<WillPopWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child!,
    );
  }

  moveToScreen() async {
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    // ignore: avoid_print
    print('back pressed');
    return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0.sp))),
              contentPadding: EdgeInsets.only(top: 1.h),
              content: Container(
                // margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: gWhiteColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: lightTextColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Are you sure?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fontBold,
                          color: newBlackColor,
                          fontSize: fontSize11),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 8.w),
                      height: 1,
                      color: lightTextColor,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Do you want to exit an App?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: fontBook,
                          color: newBlackColor,
                          fontSize: fontSize10),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 1.5.h),
                              decoration: BoxDecoration(
                                color: gWhiteColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: lightTextColor),
                              ),
                              child: Text("No",
                                  style: TextStyle(
                                    color: newBlackColor,
                                    fontFamily: fontMedium,
                                    fontSize: fontSize09,
                                  ))
                          ),
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () => SystemNavigator.pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                              color: gSecondaryColor,
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: gMainColor),
                            ),
                            child: Text("Yes",
                              style: TextStyle(
                                color: whiteTextColor,
                                fontFamily: fontMedium,
                                fontSize: fontSize09,
                              ),),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h)
                  ],
                ),
              ),
            )) ??
        false;
  }
}
