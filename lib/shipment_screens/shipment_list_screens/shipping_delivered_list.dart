import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/ship_rocket_login_controller.dart';
import '../../model/pending_list_model.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../widgets/customers_list_widgets.dart';
import '../shipping_details_screen.dart';

class ShippingDeliveredList extends StatefulWidget {
  final List<Approved> deliveredList;
  const ShippingDeliveredList({Key? key, required this.deliveredList}) : super(key: key);

  @override
  State<ShippingDeliveredList> createState() => _ShippingDeliveredListState();
}

class _ShippingDeliveredListState extends State<ShippingDeliveredList> {
  DateTime initialDate = DateTime.now();
  DateTime? selectedDate;

  ShipRocketLoginController shipRocketLoginController =
  Get.put(ShipRocketLoginController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(""),
                selectedDate == null
                    ? Text(
                  "All",
                  style: TabBarText().selectedText(),
                )
                    : Text(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(
                      (selectedDate.toString())))
                      .toString(),
                  style: TabBarText().selectedText(),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context), // Refer step 3
                  child: Icon(
                    Icons.date_range_outlined,
                    color: gBlackColor,
                    size: 3.5.h,
                  ),
                ),
              ],
            ),
          ),
          widget.deliveredList.isNotEmpty
              ? ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.deliveredList.length,
            itemBuilder: ((context, index) {
              var data = widget.deliveredList[index];
              return selectedDate == null
                  ? GestureDetector(
                onTap: () {
                  shipRocketLoginController
                      .shipRocketLogin();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ct) => ShippingDetailsScreen(
                        isTracking: true,
                        label: data.orders ?? [],
                        userId: data.patient?.user?.id.toString() ?? "",
                        userName:
                        data.patient?.user?.name ?? "",
                        address:
                        data.patient?.address2 ?? "",
                        status: data.patient?.status ?? "",
                        addressNo: data.patient?.user?.address ?? "",
                      ),
                      //     ApprovedOrderDetails(
                      //   label: data.orders ?? [],
                      //   userName:
                      //   data.patient?.user?.name ??
                      //       "",
                      //   address:
                      //   data.patient?.address2 ??
                      //       "",
                      //   shipmentId: data.orders?.first.shippingId ?? "",
                      //   orderId: data.orders?.first.orderId ??
                      //       "",
                      //   status: data.orders?.first.status ??
                      //       "",
                      //   addressNo: data.patient?.user?.address ??
                      //       "",
                      //   pickupDate: data.orders?.first.pickupScheduledDate ??
                      //       "",
                      //   awbNumber: data.orders?.first.awbCode ?? '', userId: data.patient?.user?.id.toString() ?? "",
                      // ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.h,
                          backgroundImage: NetworkImage(
                            "${data.patient?.user?.profile}",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.patient?.user?.name ?? '',
                                style: AllListText().headingText(),
                              ),
                              // SizedBox(height: 0.5.h),
                              // Text(
                              //   "${data?.appointmentDate} / ${data?.appointmentTime}",
                              //   style: AllListText().subHeadingText(),
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "Status : ",
                                    style: AllListText().otherText(),
                                  ),
                                  Text(
                                    buildStatusText(
                                        "${data.patient?.status}"),
                                    style: AllListText().deliveryDateText(
                                        "${data.patient?.status}"),
                                  ),
                                ],
                              ),
                              data.patient?.shippingDeliveryDate == null
                                  ? const SizedBox()
                                  : Row(
                                children: [
                                  Text(
                                    "Requested Delivery Date : ",
                                    style: AllListText().otherText(),
                                  ),
                                  Text(
                                    data.patient
                                        ?.shippingDeliveryDate ??
                                        '',
                                    style:
                                    AllListText().subHeadingText(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          data.updateTime ?? '',
                          style: AllListText().otherText(),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 2.5.h),
                      color: gBlackColor.withOpacity(0.5),
                    ),
                  ],
                ),
              )
                  : DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(
                  (selectedDate.toString())))
                  .toString() ==
                  data.patient?.shippingDeliveryDate.toString()
                  ? GestureDetector(
                onTap: () {
                  shipRocketLoginController
                      .shipRocketLogin();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ct) => ShippingDetailsScreen(
                        isTracking: true,
                        label: data.orders ?? [],
                        userId: data.patient?.user?.id.toString() ?? "",
                        userName:
                        data.patient?.user?.name ?? "",
                        address:
                        data.patient?.address2 ?? "",
                        status: data.patient?.status ?? "",
                        addressNo: data.patient?.user?.address ?? "",
                      ),
                      //     ApprovedOrderDetails(
                      //   label: data.orders ?? [],
                      //   userId: data.patient?.user?.id.toString() ?? "",
                      //   userName:
                      //   data.patient?.user?.name ??
                      //       "",
                      //   address:
                      //   data.patient?.address2 ??
                      //       "",
                      //   shipmentId: data.orders?.first.shippingId ?? "",
                      //   orderId: data.orders?.first.orderId ??
                      //       "",
                      //   status: data.orders?.first.status ??
                      //       "",
                      //   addressNo: data.patient?.user?.address ??
                      //       "",
                      //   pickupDate: data.orders?.first.pickupScheduledDate ??
                      //       "",
                      //   awbNumber: data.orders?.first.awbCode ?? '',
                      // ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.h,
                          backgroundImage: NetworkImage(
                            "${data.patient?.user?.profile}",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.patient?.user?.name ?? '',
                                style: AllListText().headingText(),
                              ),
                              // SizedBox(height: 0.5.h),
                              // Text(
                              //   "${data?.appointmentDate} / ${data?.appointmentTime}",
                              //   style: AllListText().subHeadingText(),
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "Status : ",
                                    style: AllListText().otherText(),
                                  ),
                                  Text(
                                    buildStatusText(
                                        "${data.patient?.status}"),
                                    style: AllListText().deliveryDateText(
                                        "${data.patient?.status}"),
                                  ),
                                ],
                              ),
                              data.patient?.shippingDeliveryDate == null
                                  ? const SizedBox()
                                  : Row(
                                children: [
                                  Text(
                                    "Requested Delivery Date : ",
                                    style: AllListText().otherText(),
                                  ),
                                  Text(
                                    data.patient
                                        ?.shippingDeliveryDate ??
                                        '',
                                    style:
                                    AllListText().subHeadingText(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          data.updateTime ?? '',
                          style: AllListText().otherText(),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 2.5.h),
                      color: gBlackColor.withOpacity(0.5),
                    ),
                  ],
                ),
              )
                  : const SizedBox();
            }),
          )
              : Image(
            image:
            const AssetImage("assets/images/Group 5294.png"),
            height: 25.h,
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate, // Refer step 1
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  saveUserId(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("user_id", userId);
  }
}
