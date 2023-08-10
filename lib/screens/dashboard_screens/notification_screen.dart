import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/notification_list_controller.dart';
import '../../utils/common_screen_widget.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:
              EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.w),
          child: Column(
            children: [
              buildAppBar(() {
                Navigator.pop(context);
              }),
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Notification",
                  textAlign: TextAlign.center,
                  style: ProfileScreenText().headingText(),
                ),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: buildNotificationList(),
              ),
            ],
          ),
        ),
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
                    if (data[index].notificationType == "meal_plan") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const Activities(),
                      //   ),
                      // );
                    } else if (data[index].notificationType == "enquiry") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const TaskList(),
                      //   ),
                      // );
                    } else if (data[index].notificationType == "report") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const Messages(),
                      //   ),
                      // );
                    } else if (data[index].notificationType == "appointment") {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const NoticeBoard(),
                      //   ),
                      // );
                    } else if (data[index].notificationType == "shopping") {
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
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildNotificationType(
                              data[index].type.toString(),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].subject ?? "",
                                      style: AllListText().headingText()),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(data[index].message ?? "",
                                        style: AllListText()
                                            .notificationSubHeadingText()),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(data[index].createdAt ?? "",
                                      style: AllListText()
                                          .notificationOtherText()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
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
      return buildContainer(
          image: 'assets/images/noun-successful-payment-4652687.png');
    } else if (type == "report") {
      return buildContainer(image: 'assets/images/Group 4926.png');
    } else if (type == "appointment") {
      return buildContainer(
          image: "assets/images/noun-appointment-4878328.png");
    } else if (type == "shopping") {
      return buildContainer(image: "assets/images/Group 5058.png");
    } else if (type == "preparatory_started") {
      return buildContainer(
          image: 'assets/images/noun-successful-payment-4652687.png');
    } else if (type == "new_appointment") {
      return buildContainer(image: 'assets/images/Group 4926.png');
    } else if (type == "program_completed") {
      return buildContainer(
          image: "assets/images/noun-appointment-4878328.png");
    } else if (type == "transition_completed") {
      return buildContainer(image: "assets/images/Group 5058.png");
    } else if (type == "preparatory_completed") {
      return buildContainer(
          image: 'assets/images/noun-successful-payment-4652687.png');
    } else if (type == "transition_started") {
      return buildContainer(image: 'assets/images/Group 4926.png');
    } else if (type == "start_program") {
      return buildContainer(
          image: "assets/images/noun-appointment-4878328.png");
    } else if (type == "order") {
      return buildContainer(image: "assets/images/Group 5058.png");
    } else if (type == "consultation_rejected") {
      return buildContainer(
          image: 'assets/images/noun-successful-payment-4652687.png');
    } else if (type == "reminder_appointment") {
      return buildContainer(image: 'assets/images/Group 4926.png');
    } else {
      return Container(
        height: 4.5.h,
        width: 10.w,
        color: gSecondaryColor,
      );
    }
  }

  buildContainer({required String image}) {
    return Container(
      height: 4.5.h,
      width: 10.w,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: gWhiteColor,
        // borderRadius: BorderRadius.circular(5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     blurRadius: 3,
        //     offset: const Offset(2, 3),
        //   ),
        // ],
      ),
      child: Image(
        color: gBlackColor,
        image: AssetImage(image),
      ),
    );
  }
}
