import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/screens/shipping_status_screens/shipping_order_details_screens/approved_screens/approved_order_details.dart';
import 'package:shipping_app/screens/shipping_status_screens/shipping_order_details_screens/pending_paused_order_details.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/ship_rocket_login_controller.dart';
import '../../controller/pending_user_list_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../dashboard_screens/notification_screen.dart';

class ShippingStatus extends StatefulWidget {
  const ShippingStatus({Key? key}) : super(key: key);

  @override
  State<ShippingStatus> createState() => _ShippingStatusState();
}

class _ShippingStatusState extends State<ShippingStatus> {
  PendingUserListController pendingUserListController =
      Get.put(PendingUserListController());

  ShipRocketLoginController shipRocketLoginController =
      Get.put(ShipRocketLoginController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 1.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: const Image(
                        image: AssetImage(
                            "assets/images/Gut wellness logo green.png"),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ct) => const NotificationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: gMainColor,
                        size: 3.h,
                      ),
                    ),
                  ],
                ),
                TabBar(
                    labelColor: gPrimaryColor,
                    unselectedLabelColor: gTextColor.withOpacity(0.5),
                    isScrollable: false,
                    indicatorColor: gPrimaryColor,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: "GothamBook",
                        color: gPrimaryColor,
                        fontSize: 8.sp),
                    labelPadding:
                        EdgeInsets.only(right: 25.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 25.w),
                    labelStyle: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gPrimaryColor,
                        fontSize: 8.sp),
                    tabs: const [
                      Text('Pending'),
                      Text('Paused'),
                      Text("Packed"),
                      //  Text("Approved"),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    buildPending(),
                    buildPaused(),
                    //buildPacked(),
                    buildApproved(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPending() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: pendingUserListController.getPendingUserListData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 25.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: gBlackColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 1.5.h),
                  data.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ct) => PendingPausedOrderDetails(
                                      userName: data[index]
                                          .patient
                                          .user
                                          .name
                                          .toString(),
                                    ),
                                  ),
                                );
                                saveUserId(
                                  data[index].patient.user.id,
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 2.5.h,
                                        backgroundImage: NetworkImage(
                                          data[index]
                                              .patient
                                              .user
                                              .profile
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]
                                                  .patient
                                                  .user
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "GothamMedium",
                                                  color: gTextColor,
                                                  fontSize: 8.sp),
                                            ),
                                            SizedBox(height: 0.7.h),
                                            Text(
                                              "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "GothamBook",
                                                  color: gTextColor,
                                                  fontSize: 6.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data[index].updateTime.toString(),
                                        style: TextStyle(
                                            fontFamily: "GothamBook",
                                            color: gBlackColor.withOpacity(0.5),
                                            fontSize: 6.sp),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 2.5.h),
                                    color: gBlackColor.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : Image(
                          image:
                              const AssetImage("assets/images/Group 5295.png"),
                          height: 25.h,
                        ),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  buildPaused() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: pendingUserListController.getPausedUserListData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 25.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: gBlackColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 1.5.h),
                  data.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ct) => PendingPausedOrderDetails(
                                      userName: data[index]
                                          .patient
                                          .user
                                          .name
                                          .toString(),
                                    ),
                                  ),
                                );
                                saveUserId(
                                  data[index].patient.user.id,
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 2.5.h,
                                        backgroundImage: NetworkImage(
                                          data[index]
                                              .patient
                                              .user
                                              .profile
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]
                                                  .patient
                                                  .user
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "GothamMedium",
                                                  color: gTextColor,
                                                  fontSize: 8.sp),
                                            ),
                                            SizedBox(height: 0.7.h),
                                            Text(
                                              "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "GothamBook",
                                                  color: gTextColor,
                                                  fontSize: 6.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data[index].updateTime.toString(),
                                        style: TextStyle(
                                            fontFamily: "GothamBook",
                                            color: gBlackColor.withOpacity(0.5),
                                            fontSize: 6.sp),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 2.5.h),
                                    color: gBlackColor.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : Image(
                          image:
                              const AssetImage("assets/images/Group 5295.png"),
                          height: 25.h,
                        ),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  // buildPacked() {
  //   return SingleChildScrollView(
  //     physics: const BouncingScrollPhysics(),
  //     child: FutureBuilder(
  //         future: pendingUserListController.getPackedUserListData(),
  //         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //           if (snapshot.hasError) {
  //             return Padding(
  //               padding: EdgeInsets.symmetric(vertical: 5.h),
  //               child: Image(
  //                 image: const AssetImage("assets/images/Group 5294.png"),
  //                 height: 25.h,
  //               ),
  //             );
  //           } else if (snapshot.hasData) {
  //             var data = snapshot.data;
  //             return Column(
  //               children: [
  //                 Container(
  //                   height: 1,
  //                   color: gBlackColor.withOpacity(0.5),
  //                 ),
  //                 SizedBox(height: 1.5.h),
  //                 data.length != 0
  //                     ? ListView.builder(
  //                         scrollDirection: Axis.vertical,
  //                         padding: EdgeInsets.symmetric(horizontal: 1.w),
  //                         physics: const ScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemCount: data.length,
  //                         itemBuilder: ((context, index) {
  //                           return GestureDetector(
  //                             onTap: () {
  //                               Navigator.of(context).push(
  //                                 MaterialPageRoute(
  //                                   builder: (ct) => PendingPausedOrderDetails(
  //                                       userName: data[index]
  //                                           .patient
  //                                           .user
  //                                           .name
  //                                           .toString()),
  //                                   //     PackedOrderDetails(
  //                                   //   userName: data[index]
  //                                   //       .patient
  //                                   //       .user
  //                                   //       .name
  //                                   //       .toString(),
  //                                   // ),
  //                                 ),
  //                               );
  //                               saveUserId(
  //                                 data[index].patient.user.id,
  //                               );
  //                             },
  //                             child: Column(
  //                               children: [
  //                                 Row(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.center,
  //                                   children: [
  //                                     CircleAvatar(
  //                                       radius: 2.5.h,
  //                                       backgroundImage: NetworkImage(
  //                                         data[index]
  //                                             .patient
  //                                             .user
  //                                             .profile
  //                                             .toString(),
  //                                       ),
  //                                     ),
  //                                     SizedBox(width: 3.w),
  //                                     Expanded(
  //                                       child: Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Text(
  //                                             data[index]
  //                                                 .patient
  //                                                 .user
  //                                                 .name
  //                                                 .toString(),
  //                                             style: TextStyle(
  //                                                 fontFamily: "GothamMedium",
  //                                                 color: gTextColor,
  //                                                 fontSize: 8.sp),
  //                                           ),
  //                                           SizedBox(height: 0.7.h),
  //                                           Text(
  //                                             "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
  //                                             style: TextStyle(
  //                                                 fontFamily: "GothamBook",
  //                                                 color: gTextColor,
  //                                                 fontSize: 6.sp),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       data[index].updateTime.toString(),
  //                                       style: TextStyle(
  //                                           fontFamily: "GothamBook",
  //                                           color: gBlackColor.withOpacity(0.5),
  //                                           fontSize: 6.sp),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Container(
  //                                   height: 1,
  //                                   margin:
  //                                       EdgeInsets.symmetric(vertical: 2.5.h),
  //                                   color: gBlackColor.withOpacity(0.5),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         }),
  //                       )
  //                     : Image(
  //                         image:
  //                             const AssetImage("assets/images/Group 5294.png"),
  //                         height: 25.h,
  //                       ),
  //               ],
  //             );
  //           }
  //           return Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10.h),
  //             child: buildCircularIndicator(),
  //           );
  //         }),
  //   );
  // }

  buildApproved() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: pendingUserListController.getPackedUserListData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 25.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: gBlackColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 1.5.h),
                  data.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                shipRocketLoginController.shipRocketLogin();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ct) => ApprovedOrderDetails(
                                      label: data[index].orders,
                                      userName: data[index]
                                          .patient
                                          .user
                                          .name
                                          .toString(),
                                      address: data[index]
                                          .patient
                                          .address2
                                          .toString(),
                                      shipmentId: data[index]
                                          .orders
                                          .first
                                          .shippingId
                                          .toString(),
                                      orderId: data[index]
                                          .orders
                                          .first
                                          .orderId
                                          .toString(),
                                      status: data[index]
                                          .orders
                                          .first
                                          .status
                                          .toString(),
                                      addressNo: data[index]
                                          .patient
                                          .user
                                          .address
                                          .toString(),
                                      pickupDate: data[index]
                                          .orders
                                          .first
                                          .pickupScheduledDate
                                          .toString(),
                                    ),
                                  ),
                                );
                                saveUserId(
                                  data[index].patient.user.id,
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 2.5.h,
                                        backgroundImage: NetworkImage(
                                          data[index]
                                              .patient
                                              .user
                                              .profile
                                              .toString(),
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]
                                                  .patient
                                                  .user
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "GothamMedium",
                                                  color: gTextColor,
                                                  fontSize: 8.sp),
                                            ),
                                            SizedBox(height: 0.7.h),
                                            Text(
                                              "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
                                              style: TextStyle(
                                                  fontFamily: "GothamBook",
                                                  color: gTextColor,
                                                  fontSize: 6.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data[index].updateTime.toString(),
                                        style: TextStyle(
                                            fontFamily: "GothamBook",
                                            color: gBlackColor.withOpacity(0.5),
                                            fontSize: 6.sp),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 2.5.h),
                                    color: gBlackColor.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : Image(
                          image:
                              const AssetImage("assets/images/Group 5294.png"),
                          height: 25.h,
                        ),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  saveUserId(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("user_id", userId);
  }
}
