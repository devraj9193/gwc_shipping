import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../controller/repository/ship_rocket_repository/ship_track_repo.dart';
import '../controller/services/api_services.dart';
import '../controller/services/ship_rocket_service/ship_track_service.dart';
import '../model/pending_list_model.dart';
import '../screens/shipping_order_details_screens/approved_screens/labels_screen.dart';
import '../screens/shipping_order_details_screens/approved_screens/main_fest_screen.dart';
import '../screens/shipping_order_details_screens/approved_screens/welcome_letter.dart';
import '../utils/app_config.dart';
import '../utils/common_screen_widget.dart';
import '../utils/gwc_apis.dart';
import '../widgets/customers_list_widgets.dart';
import 'shipment_list_screens/customer_order_products.dart';
import 'tracking/cook_kit_tracking.dart';
import '../utils/constants.dart';
import '../widgets/widgets.dart';

class ShippingDetailsScreen extends StatefulWidget {
  final String? userName;
  final List<Order>? label;
  final String? address;
  final String? addressNo;
  final String? status;
  final String? userId;
  final bool isTracking;
  final bool isTap;
  const ShippingDetailsScreen({
    Key? key,
    this.userName,
    this.label,
    this.address,
    this.addressNo,
    this.status,
    this.userId,
    this.isTracking = false,
    this.isTap = false,
  }) : super(key: key);

  @override
  State<ShippingDetailsScreen> createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {
  final _pref = GwcApi.preferences;

  @override
  void initState() {
    super.initState();
    if (_pref!.getString(AppConfig().shipRocketBearer) == null ||
        _pref!.getString(AppConfig().shipRocketBearer)!.isEmpty) {
      getShipRocketToken();
    } else {
      String token = _pref!.getString(AppConfig().shipRocketBearer)!;
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      print('shipRocketToken : $payload');
      var date = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      if (!DateTime.now().difference(date).isNegative) {
        getShipRocketToken();
      }
    }
  }

  void getShipRocketToken() async {
    print("getShipRocketToken called");
    ShipRocketService shipRocketService =
    ShipRocketService(shipRocketRepository: shipTrackRepository);
    final getToken = await shipRocketService.getShipRocketTokenService(
        AppConfig().shipRocketEmail, AppConfig().shipRocketPassword);
    print(getToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      appBar: widget.isTap ? AppBar(
        backgroundColor: gWhiteColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: gSecondaryColor,
                size: 2.h,
              ),
            ),
            SizedBox(width: 2.w),
            SizedBox(
              height: 5.h,
              child: const Image(
                image: AssetImage("assets/images/Gut wellness logo.png"),
              ),
            ),
          ],
        ),
        actions: [
          widget.isTracking
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ct) => CookKitTracking(
                          awbNumber: widget.label?.first.awbCode ?? '',
                          userName: widget.userName ?? '',
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
                )
              : const SizedBox(),
          SizedBox(width: 2.w),
        ],
      ) : null,
      body: SafeArea(
        child: widget.isTracking
            ? buildPackedAndDeliveredDetails()
            : buildPendingAndPausedDetails(),
      ),
    );
  }

  buildPendingAndPausedDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileTile("Name : ", "${widget.userName}"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
            child: Row(
              children: [
                Text(
                  "Status : ",
                  style: AllListText().otherText(),
                ),
                Text(
                  buildStatusText("${widget.status}"),
                  style: AllListText().deliveryDateText("${widget.status}"),
                ),
              ],
            ),
          ),
          profileTile("Address : ", "${widget.addressNo}, ${widget.address}"),
          CustomerOrderProducts(
            userId: "${widget.userId}",
          ),
        ],
      ),
    );
  }

  buildPackedAndDeliveredDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileTile("Name : ", widget.userName ?? ''),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
            child: Row(
              children: [
                Text(
                  "Status : ",
                  style: AllListText().otherText(),
                ),
                Text(
                  buildStatusText("${widget.status}"),
                  style: AllListText().deliveryDateText("${widget.status}"),
                ),
              ],
            ),
          ),
          profileTile("Address : ", "${widget.addressNo}, ${widget.address}"),
          widget.label!.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profileTile(
                        "Shipment Id : ", widget.label?.first.shippingId ?? ''),
                    profileTile(
                        "Order Id : ", widget.label?.first.orderId ?? ''),
                    profileTile("Ship Rocket Status : ",
                        widget.label?.first.status ?? ''),
                    profileTile("Pickup Schedule : ",
                        widget.label?.first.pickupScheduledDate ?? ''),
                  ],
                )
              : const SizedBox(),
          SizedBox(height: 1.h),
          buildDetails(),
          CustomerOrderProducts(
            userId: "${widget.userId}",
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
                      builder: (ct) =>
                          MainFestScreen(mainFest: widget.label ?? [])),
                );
              } else if (shippingDetails[index]["id"] == "2") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => LabelsScreen(
                      label: widget.label ?? [],
                    ),
                  ),
                );
              } else if (shippingDetails[index]["id"] == "3") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => WelcomeLetterScreen(
                      label: widget.label ?? [],
                      userName: widget.userName ?? '',
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

  final ShipRocketRepository shipTrackRepository = ShipRocketRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
