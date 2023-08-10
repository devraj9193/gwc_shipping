import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/pending_list_model.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../widgets/customers_list_widgets.dart';
import '../../screens/shipping_order_details_screens/pending_paused_order_details.dart';
import '../shipping_details_screen.dart';

class ShippingPausedList extends StatefulWidget {
  final List<Pending> pausedList;

  const ShippingPausedList({Key? key, required this.pausedList})
      : super(key: key);

  @override
  State<ShippingPausedList> createState() => _ShippingPausedListState();
}

class _ShippingPausedListState extends State<ShippingPausedList> {
  DateTime initialDate = DateTime.now();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
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
                            .format(DateTime.parse((selectedDate.toString())))
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
          widget.pausedList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.pausedList.length,
                  itemBuilder: ((context, index) {
                    var data = widget.pausedList[index];
                    return selectedDate == null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ct) => ShippingDetailsScreen(
                                    userName: data.patient?.user?.name ?? '',
                                    address: data.patient?.address2 ?? '',
                                    addressNo:
                                        data.patient?.user?.address ?? '',
                                    userId:
                                        data.patient?.user?.id.toString() ?? '',
                                    status: data.patient?.status ?? '',
                                  ),
                                  // PendingPausedOrderDetails(
                                  //   userName: data.patient?.user?.name ?? '',
                                  //   address: data.patient?.address2 ?? '',
                                  //   addressNo: data.patient?.user?.address ?? '',
                                  //   userId: data.patient?.user?.id.toString() ?? '',
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
                                        data.patient?.user?.profile ?? '',
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.patient?.user?.name ?? "",
                                            style: AllListText().headingText(),
                                          ),
                                          // Text(
                                          //   "${data.appointmentDate.toString()} / ${data.appointmentTime.toString()}",
                                          //   style: AllListText()
                                          //       .subHeadingText(),
                                          // ),
                                          Row(
                                            children: [
                                              Text(
                                                "Status : ",
                                                style:
                                                    AllListText().otherText(),
                                              ),
                                              Text(
                                                buildStatusText(
                                                    "${data.patient?.status}"),
                                                style: AllListText()
                                                    .deliveryDateText(
                                                        "${data.patient?.status}"),
                                              ),
                                            ],
                                          ),
                                          data.patient?.shippingDeliveryDate ==
                                                  null
                                              ? const SizedBox()
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "Shipping Delivery Date : ",
                                                      style: AllListText()
                                                          .otherText(),
                                                    ),
                                                    Text(
                                                      data.patient
                                                              ?.shippingDeliveryDate ??
                                                          '',
                                                      style: AllListText()
                                                          .subHeadingText(),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      data.updateTime.toString(),
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ct) => ShippingDetailsScreen(
                                        userName:
                                            data.patient?.user?.name ?? '',
                                        address: data.patient?.address2 ?? '',
                                        addressNo:
                                            data.patient?.user?.address ?? '',
                                        userId:
                                            data.patient?.user?.id.toString() ??
                                                '',
                                        status: data.patient?.status ?? '',
                                      ),
                                      // PendingPausedOrderDetails(
                                      //   userName: data.patient?.user?.name ?? '',
                                      //   address: data.patient?.address2 ?? '',
                                      //   addressNo: data.patient?.user?.address ?? '',
                                      //   userId: data.patient?.user?.id.toString() ?? '',
                                      // ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 3.h,
                                          backgroundImage: NetworkImage(
                                            data.patient?.user?.profile ?? '',
                                          ),
                                        ),
                                        SizedBox(width: 3.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.patient?.user?.name ?? "",
                                                style:
                                                    AllListText().headingText(),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status : ",
                                                    style: AllListText()
                                                        .otherText(),
                                                  ),
                                                  Text(
                                                    buildStatusText(
                                                        "${data.patient?.status}"),
                                                    style: AllListText()
                                                        .deliveryDateText(
                                                            "${data.patient?.status}"),
                                                  ),
                                                ],
                                              ),
                                              data.patient?.shippingDeliveryDate ==
                                                      null
                                                  ? const SizedBox()
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          "Shipping Delivery Date : ",
                                                          style: AllListText()
                                                              .otherText(),
                                                        ),
                                                        Text(
                                                          data.patient
                                                                  ?.shippingDeliveryDate ??
                                                              '',
                                                          style: AllListText()
                                                              .subHeadingText(),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          data.updateTime.toString(),
                                          style: AllListText().otherText(),
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
                              )
                            : const SizedBox();
                  }),
                )
              : Image(
                  image: const AssetImage("assets/images/Group 5295.png"),
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
