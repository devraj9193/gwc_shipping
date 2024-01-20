import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controller/repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../controller/services/api_services.dart';
import '../../controller/services/customer_status_service/customer_status_service.dart';
import '../../model/error_model.dart';
import '../../model/pending_list_model.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../widgets/customers_list_widgets.dart';
import '../../widgets/widgets.dart';
import 'shipment_list_screens/shipping_delivered_list.dart';
import 'shipment_list_screens/shipping_packed_list.dart';
import 'shipment_list_screens/shipping_paused_list.dart';
import 'shipment_list_screens/shipping_pending_list.dart';
import 'package:http/http.dart' as http;

class ShippingStatus extends StatefulWidget {
  const ShippingStatus({Key? key}) : super(key: key);

  @override
  State<ShippingStatus> createState() => _ShippingStatusState();
}

class _ShippingStatusState extends State<ShippingStatus> with SingleTickerProviderStateMixin {

  bool isLoading = false;
  bool isError = false;
  int pendingListCount = 0;
  int pausedListCount = 0;
  int packedListCount = 0;
  int deliveredListCount = 0;

  TabController? tabController;
  bool isScrollStory = true;

  late final CustomerStatusService customerStatusService =
  CustomerStatusService(customerStatusRepo: repository);

  PendingUserList? pendingUserList;

  @override
  void initState() {
    super.initState();
    getShipmentList();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  getShipmentList() async {
    setState(() {
      isLoading = true;
    });
    callProgressStateOnBuild(true);
    final result = await customerStatusService.getShipmentService();
    print("result: $result");

    if (result.runtimeType == PendingUserList) {
      print("Ticket List");
      PendingUserList model = result as PendingUserList;

      pendingUserList = model;

      int? pendingCount = pendingUserList?.data?.pending.length;

      int? pausedCount = pendingUserList?.data?.paused.length;

      int? packedCount = pendingUserList?.data?.packed.length;

      int? deliveredCount = pendingUserList?.data?.delivered.length;

      setState(() {
        pendingListCount = pendingCount!;
        pausedListCount = pausedCount!;
        packedListCount = packedCount!;
        deliveredListCount = deliveredCount!;
        print("Count = ${pendingListCount + pausedListCount + packedListCount}");
      });

    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    print(result);
  }

  callProgressStateOnBuild(bool value) {
    Future.delayed(Duration.zero).whenComplete(() {
      setState(() {
        isLoading = value;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            top: 1.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDashboardAppBar(),
              SizedBox(height: 1.h),
              TabBar(
                controller: tabController,
                labelColor: tapSelectedColor,
                unselectedLabelColor: gTextColor.withOpacity(0.5),
                isScrollable: true,
                labelPadding:
                    EdgeInsets.only(right: 25.w, top: 1.h, bottom: 1.h),
                indicatorPadding: EdgeInsets.only(right: 25.w),
                labelStyle: TabBarText().selectedText(),
                unselectedLabelStyle: TabBarText().unSelectedText(),
                indicatorColor: tapIndicatorColor,
                tabs:  [
                  buildTapCount('Pending', pendingListCount),
                  buildTapCount('Paused', pausedListCount),
                  buildTapCount('Packed', packedListCount),
                  buildTapCount('Delivered', deliveredListCount),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 0.w, bottom: 1.h),
                color: gGreyColor.withOpacity(0.3),
                width: double.maxFinite,
              ),
               Expanded(
                child: (isLoading)
                    ? Center(
                  child: buildCircularIndicator(),
                )
                    : TabBarView(
                  controller: tabController,
                  children: [
                    ShippingPendingList(pendingList: pendingUserList?.data?.pending ?? [],),
                    ShippingPausedList(pausedList: pendingUserList?.data?.paused ?? [],),
                    ShippingPackedList(packedList: pendingUserList?.data?.packed ?? [], ),
                    ShippingDeliveredList(deliveredList: pendingUserList?.data?.delivered ?? [],)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final CustomerStatusRepo repository = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
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
