import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/notification_list_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationListController notificationListController =
      Get.put(NotificationListController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/eval_bg.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(gSecondaryColor, BlendMode.lighten)),
      ),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
                  child: buildAppBar(() {
                    Navigator.pop(context);
                  }),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(right: 3.w, top: 3.h, left: 3.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2, color: Colors.grey.withOpacity(0.5))
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Notification",
                            style: TextStyle(
                                fontFamily: "GothamBold",
                                color: gMainColor,
                                fontSize: 10.sp),
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 1.5.h),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        Expanded(
                          child: buildNotificationList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  buildNotificationList() {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: notificationListController.getNotificationList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image(
                image: const AssetImage("assets/images/Group 5294.png"),
                height: 35.h,
              ),
            );
          }
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (snapshot.data[index].notificationType == "meal_plan") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const Activities(),
                      //   ),
                      // );
                    } else if (snapshot.data[index].notificationType ==
                        "enquiry") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const TaskList(),
                      //   ),
                      // );
                    } else if (snapshot.data[index].notificationType ==
                        "report") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const Messages(),
                      //   ),
                      // );
                    } else if (snapshot.data[index].notificationType ==
                        "appointment") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const NoticeBoard(),
                      //   ),
                      // );
                    } else if (snapshot.data[index].notificationType ==
                        "shopping") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const NoticeBoard(),
                      //   ),
                      // );
                    } else {}
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildNotificationType(""),
                            SizedBox(width: 3.w),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment is done",
                                    style: TextStyle(
                                      fontFamily: "GothamBold",
                                      fontSize: 9.sp,
                                      color: gPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    "Your enquiry was successfully verified. Tap to sign it right now!",
                                    style: TextStyle(
                                      fontFamily: "GothamBook",
                                      height: 1.3,
                                      fontSize: 8.sp,
                                      color: gBlackColor,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    "1 month ago",
                                    style: TextStyle(
                                      fontFamily: "GothamBook",
                                      fontSize: 8.sp,
                                      color: gBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: buildCircularIndicator(),
          );
        },
      ),
    );
  }

  buildNotificationType(String type) {
    if (type == "meal_plan") {
      return buildContainer(image: 'assets/images/Group 5042.png');
    } else if (type == "enquiry") {
      return buildContainer(image: 'assets/images/noun-successful-payment-4652687.png');
    } else if (type == "report") {
      return buildContainer(image: 'assets/images/Group 4926.png');
    } else if (type == "appointment") {
      return buildContainer(image: "assets/images/noun-appointment-4878328.png");
    } else if (type == "shopping") {
      return buildContainer(image: "assets/images/Group 5058.png");
    } else {}
  }

  buildContainer({required String image}) {
    return Container(
      height: 4.7.h,
      width: 11.w,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.3.h),
      decoration: BoxDecoration(
        color: gMainColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Image(
        image: AssetImage(image),
      ),
    );
  }
}
