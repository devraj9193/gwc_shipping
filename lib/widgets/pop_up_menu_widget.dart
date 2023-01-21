import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../utils/constants.dart';

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget({Key? key}) : super(key: key);

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(-20, 80),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ct) =>
                  //     const MessageScreen(),
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gTextColor,
                          fontSize: 7.sp),
                    ),
                    SvgPicture.asset(
                      "assets/images/noun-view-1041859.svg",
                      height: 1.2.h,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                height: 1,
                color: gGreyColor.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ct) =>
                  //     const MessageScreen(),
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Call",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 7.sp),
                    ),
                    Image(
                      image: const AssetImage("assets/images/Group 4890.png"),
                      color: gBlackColor,
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                height: 1,
                color: gGreyColor.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ct) =>
                  //     const MessageScreen(),
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Message",
                        style: TextStyle(
                            fontFamily: "GothamBook",
                            color: gTextColor,
                            fontSize: 7.sp),
                      ),
                    ),
                    Image(
                      image: const AssetImage("assets/images/Group 4891.png"),
                      height: 2.5.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      child: Icon(
        Icons.more_vert,
        color: gGreyColor.withOpacity(0.5),
        size: 2.5.h,
      ),
    );
  }
}
