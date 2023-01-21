import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shipping_app/screens/shipping_status_screens/shipping_order_details_screens/approved_screens/welcome_letter.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/pending_list_model.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/widgets.dart';
import '../../customer_order_products.dart';
import '../../tracking/cook_kit_tracking.dart';
import 'labels_screen.dart';
import 'main_fest_screen.dart';

class ApprovedOrderDetails extends StatefulWidget {
  final String userName;
  final List<Order> label;
  final String address;
  final String addressNo;
  final String shipmentId;
  final String orderId;
  final String status;
  final String pickupDate;

  const ApprovedOrderDetails({
    Key? key,
    required this.label,
    required this.userName,
    required this.address,
    required this.shipmentId,
    required this.orderId,
    required this.status,
    required this.addressNo,
    required this.pickupDate,
  }) : super(key: key);

  @override
  State<ApprovedOrderDetails> createState() => _ApprovedOrderDetailsState();
}

class _ApprovedOrderDetailsState extends State<ApprovedOrderDetails> {
  List shippingDetails = [
    {
      "title": "Mainfest",
      "image": "assets/images/Group 3007.png",
      "id": "1",
    },
    {
      "title": "Labels",
      "image": "assets/images/Group 3009.png",
      "id": "2",
    },
    {
      "title": "Welcome Letter",
      "image": "assets/images/Group 3009.png",
      "id": "3",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildAppBar(() {
                      Navigator.pop(context);
                    }),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (ct) => CookKitTracking(
                    //           currentStage: '',
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: SvgPicture.asset(
                    //     'assets/images/Filter.svg',
                    //     color: gPrimaryColor,
                    //     height: 2.h,
                    //   ),
                    // ),
                  ],
                ),
              ),
              customerDetails(),
              SizedBox(height: 1.h),
              buildDetails(),
              // SizedBox(height: 1.h),
              const CustomerOrderProducts(),
            ],
          ),
        ),
      ),
    );
  }

  customerDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileTile("Name : ", widget.userName),
          profileTile("Address : ", "${widget.addressNo}, ${widget.address}"),
          profileTile("Shipment Id : ", widget.shipmentId),
          profileTile("Order Id : ", widget.orderId),
          profileTile("Status : ", widget.status),
          profileTile("Pickup Schedule : ", widget.pickupDate),
        ],
      ),
    );
  }

  profileTile(String title, String subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: gBlackColor,
              fontFamily: 'GothamBold',
              fontSize: 8.sp,
            ),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: TextStyle(
                color: gBlackColor,
                fontFamily: 'GothamMedium',
                fontSize: 7.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildDetails() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 10,
          mainAxisExtent: 9.h,
        ),
        itemCount: shippingDetails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (shippingDetails[index]["id"] == "1") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ct) => MainFestScreen(mainFest: widget.label)),
                );
              } else if (shippingDetails[index]["id"] == "2") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => LabelsScreen(
                      label: widget.label,
                    ),
                  ),
                );
              } else if (shippingDetails[index]["id"] == "3") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => WelcomeLetterScreen(
                      label: widget.label,
                      userName: widget.userName,
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: gPrimaryColor,
                //  border: Border.all(color: gMainColor, width: 1),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.3),
                //       blurRadius: 5,
                //       offset: const Offset(2, 6),
                //     ),
                //   ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 6.h,
                    image: AssetImage(shippingDetails[index]["image"]),
                    color: gMainColor,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    shippingDetails[index]["title"],
                    style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gMainColor,
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
