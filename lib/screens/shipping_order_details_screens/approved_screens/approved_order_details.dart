import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../model/pending_list_model.dart';
import '../../../utils/common_screen_widget.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import '../../shipment_screens/customer_order_products.dart';
import '../../shipment_screens/tracking/cook_kit_tracking.dart';
import '../../shipment_screens/tracking/labels_screen.dart';
import '../../shipment_screens/tracking/main_fest_screen.dart';
import '../../shipment_screens/tracking/welcome_letter.dart';

class ApprovedOrderDetails extends StatefulWidget {
  final String userName;
  final List<Order> label;
  final String address;
  final String addressNo;
  final String shipmentId;
  final String orderId;
  final String status;
  final String pickupDate;
  final String awbNumber;
  final String userId;

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
    required this.awbNumber, required this.userId,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ct) => CookKitTracking(
                              awbNumber: widget.awbNumber,
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: const AssetImage(
                          'assets/images/Group 62759.png',
                        ),
                        color: gBlackColor,
                        height: 4.h,
                      ),
                    ),
                  ],
                ),
              ),
              customerDetails(),
              SizedBox(height: 1.h),
              buildDetails(),
              // SizedBox(height: 1.h),
               CustomerOrderProducts(userId: widget.userId,),
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
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AllListText().otherText(),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: AllListText().subHeadingText(),
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
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: gSecondaryColor,
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
                    height: 5.h,
                    image: AssetImage(shippingDetails[index]["image"]),
                    color: gWhiteColor,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    shippingDetails[index]["title"],
                    style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gWhiteColor,
                      fontSize: fontSize09,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
