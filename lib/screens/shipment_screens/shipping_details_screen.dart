import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shipping_app/screens/shipment_screens/tracking/main_fest_screen.dart';
import 'package:shipping_app/screens/shipment_screens/tracking/welcome_letter.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../controller/repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../controller/repository/ship_rocket_repository/ship_track_repo.dart';
import '../../controller/services/api_services.dart';
import '../../controller/services/customer_status_service/customer_status_service.dart';
import '../../controller/services/ship_rocket_service/ship_track_service.dart';
import '../../model/error_model.dart';
import '../../model/pending_list_model.dart';
import '../../model/send_shipping_model.dart';
import '../../utils/app_config.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/customers_list_widgets.dart';
import '../../widgets/widgets.dart';
import 'tracking/labels_screen.dart';
import 'customer_order_products.dart';
import 'tracking/cook_kit_tracking.dart';

class ShippingDetailsScreen extends StatefulWidget {
  final String? userName;
  final List<Order>? label;
  final String? address;
  final String? addressNo;
  final String? status;
  final String? userId;
  final bool isTracking;
  const ShippingDetailsScreen({
    Key? key,
    this.userName,
    this.label,
    this.address,
    this.addressNo,
    this.status,
    this.userId,
    this.isTracking = false,
  }) : super(key: key);

  @override
  State<ShippingDetailsScreen> createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {
  final _pref = GwcApi.preferences;
  TextEditingController commentController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  bool isLoading = false;
  String selectedValue = "";
  String selectedValue1 = "";

  late final CustomerStatusService customerStatusService =
      CustomerStatusService(customerStatusRepo: customerStatusRepo);

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      setState(() {});
    });
    otherController.addListener(() {
      setState(() {});
    });
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
  void dispose() {
    super.dispose();
    commentController.dispose();
    otherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                            image: AssetImage(
                                "assets/images/Gut wellness logo.png"),
                          ),
                        ),
                      ],
                    ),
                    widget.isTracking
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ct) => CookKitTracking(
                                    awbNumber:
                                        widget.label?.first.awbCode ?? '',
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
                  ],
                ),
              ),
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
              profileTile(
                  "Address : ", "${widget.addressNo}, ${widget.address}"),
              widget.isTracking
                  ? buildPackedAndDeliveredDetails()
                  : buildPendingAndPausedDetails(),
            ],
          ),
        ),
      ),
    );
  }

  buildPackedAndDeliveredDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileTile(
                      "Shipment Id : ", widget.label?.first.shippingId ?? ''),
                  profileTile("Order Id : ", widget.label?.first.orderId ?? ''),
                  profileTile("Ship Rocket Status : ",
                      widget.label?.first.status ?? ''),
                  profileTile("Pickup Schedule : ",
                      widget.label?.first.pickupScheduledDate ?? ''),
                ],
              )
            : const SizedBox(),
        SizedBox(height: 1.h),
        GridView.builder(
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
            }),
        CustomerOrderProducts(
          userId: "${widget.userId}",
        ),
      ],
    );
  }

  buildPendingAndPausedDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerOrderProducts(
          userId: "${widget.userId}",
        ),
        buildRadioButtons(),
        SizedBox(height: 3.h),
        buildShippingStatusText(),
        SizedBox(height: 8.h),
        Center(
          child: IntrinsicWidth(
            child: GestureDetector(
              onTap: (isLoading)
                  ? null
                  : () {
                      print("ISLOADING : $isLoading");
                      sendStatus();
                    },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                decoration: BoxDecoration(
                  color: gSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gMainColor, width: 1),
                ),
                child: (isLoading)
                    ? buildThreeBounceIndicator(color: gMainColor)
                    : Text(
                        'Submit',
                        style: LoginScreen().buttonText(gWhiteColor),
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildRadioButtons() {
    return StatefulBuilder(builder: (_, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = "paused";
                  buildPauseDetails(context);
                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //     barrierColor: gBlackColor.withOpacity(0.3),
                  //     barrierDismissible: true,
                  //     opaque: false, // set to false
                  //     pageBuilder: (ct, _, ___) => buildPauseDetails(context),
                  //   ),
                  // );
                });
              },
              child: Row(
                children: [
                  Transform.scale(
                    scale: 2.0,
                    child: Radio(
                      value: "paused",
                      activeColor: gSecondaryColor,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                          buildPauseDetails(context);
                          // Navigator.of(context).push(
                          //   PageRouteBuilder(
                          //     barrierColor: gBlackColor.withOpacity(0.3),
                          //     barrierDismissible: true,
                          //     opaque: false, // set to false
                          //     pageBuilder: (ct, _, ___) =>
                          //         buildPauseDetails(context),
                          //   ),
                          // );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Paused',
                    style: TextStyle(
                      fontFamily: fontMedium,
                      color: (selectedValue == "paused")
                          ? gSecondaryColor
                          : newBlackColor,
                      fontSize: fontSize10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = "packed";
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      barrierColor: gBlackColor.withOpacity(0.3),
                      barrierDismissible: true,
                      opaque: false, // set to false
                      pageBuilder: (ct, _, ___) => buildPackedDetails(context),
                    ),
                  );
                });
              },
              child: Row(
                children: [
                  Transform.scale(
                    scale: 2.0,
                    child: Radio(
                      value: "packed",
                      activeColor: gSecondaryColor,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              barrierColor: gBlackColor.withOpacity(0.3),
                              barrierDismissible: true,
                              opaque: false, // set to false
                              pageBuilder: (ct, _, ___) =>
                                  buildPackedDetails(context),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Packed',
                    style: TextStyle(
                      fontFamily: fontMedium,
                      color: (selectedValue == "packed")
                          ? gSecondaryColor
                          : newBlackColor,
                      fontSize: fontSize10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  buildPauseDetails(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
        backgroundColor: gWhiteColor.withOpacity(0),
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            height: size.height * 2.2,
            width: double.maxFinite,
            margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h),
            padding: EdgeInsets.only(left: 5.w, top: 3.h, right: 5.w),
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Paused",
                      style: BottomSheetTextStyle().headingText(),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 40.w,
                      margin: EdgeInsets.symmetric(vertical: 0.5.h),
                      color: newLightGreyColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue1 = "Packets are out of stock";
                          print("selectedValue1 : $selectedValue1");
                          Get.back();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Packets are out of stock',
                            style: TextStyle(
                              fontFamily:
                                  (selectedValue1 == "Packets are out of stock")
                                      ? fontMedium
                                      : fontBook,
                              color:
                                  (selectedValue1 == "Packets are out of stock")
                                      ? gSecondaryColor
                                      : newBlackColor,
                              fontSize: fontSize09,
                            ),
                          ),
                          Transform.scale(
                            scale: 2.0,
                            child: Radio(
                              value: "Packets are out of stock",
                              activeColor: gSecondaryColor,
                              groupValue: selectedValue1,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value as String;
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue1 = "Items are out of stock";
                          print("selectedValue1 : $selectedValue1");

                          Get.back();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items are out of stock',
                            style: TextStyle(
                              fontFamily:
                                  (selectedValue1 == "Items are out of stock")
                                      ? fontMedium
                                      : fontBook,
                              color:
                                  (selectedValue1 == "Items are out of stock")
                                      ? gSecondaryColor
                                      : newBlackColor,
                              fontSize: fontSize09,
                            ),
                          ),
                          Transform.scale(
                            scale: 2.0,
                            child: Radio(
                              value: "Items are out of stock",
                              activeColor: gSecondaryColor,
                              groupValue: selectedValue1,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value as String;
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue1 = "Technical issue";
                          print("selectedValue1 : $selectedValue1");

                          Get.back();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Technical issue',
                            style: TextStyle(
                              fontFamily: (selectedValue1 == "Technical issue")
                                  ? fontMedium
                                  : fontBook,
                              color: (selectedValue1 == "Technical issue")
                                  ? gSecondaryColor
                                  : newBlackColor,
                              fontSize: fontSize09,
                            ),
                          ),
                          Transform.scale(
                            scale: 2.0,
                            child: Radio(
                              value: "Technical issue",
                              // fillColor:
                              //     MaterialStateProperty.all(gSecondaryColor),
                              groupValue: selectedValue1,
                              activeColor: gSecondaryColor,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value as String;
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue1 = "Others :";
                          print("selectedValue1 : $selectedValue1");
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Others :',
                            style: TextStyle(
                              fontFamily: (selectedValue1 == "Others :")
                                  ? fontMedium
                                  : fontBook,
                              color: (selectedValue1 == "Others :")
                                  ? gSecondaryColor
                                  : newBlackColor,
                              fontSize: fontSize09,
                            ),
                          ),
                          Transform.scale(
                            scale: 2.0,
                            child: Radio(
                              value: "Others :",
                              activeColor: gSecondaryColor,
                              groupValue: selectedValue1,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value as String;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  selectedValue1 == "Others :"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              margin: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: gWhiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(2, 3),
                                    blurRadius: 5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                maxLines: null,
                                controller: otherController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                cursorColor: gSecondaryColor,
                                style: LoginScreen().mainTextField(),
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter comments",
                                  hintStyle: LoginScreen().hintTextField(),
                                  suffixIcon: otherController.text.isEmpty
                                      ? Container(width: 0)
                                      : InkWell(
                                          onTap: () {
                                            otherController.clear();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: newBlackColor,
                                            size: 2.h,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  (otherController.text.isNotEmpty)
                                      ? Get.back()
                                      : showSnackBar(
                                          context,
                                          "Please Enter your Comments",
                                          gSecondaryColor);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 5.w),
                                  decoration: BoxDecoration(
                                    color: gSecondaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: gSecondaryColor, width: 1),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style:
                                        LoginScreen().buttonText(gWhiteColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
    // return StatefulBuilder(builder: (_, setState) {
    //   return Material(
    //     color: gBlackColor.withOpacity(0.1),
    //     child: Center(
    //       child: Container(
    //         height: double.maxFinite,
    //         width: double.maxFinite,
    //         margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
    //         padding: EdgeInsets.only(left: 5.w, top: 3.h, right: 5.w),
    //         decoration: const BoxDecoration(
    //           color: kWhiteColor,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(40),
    //             topRight: Radius.circular(40),
    //           ),
    //         ),
    //         child: SingleChildScrollView(
    //           physics: const BouncingScrollPhysics(),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Center(
    //                 child: Text(
    //                   "Paused",
    //                   style: BottomSheetTextStyle().headingText(),
    //                 ),
    //               ),
    //               Container(
    //                 height: 1,
    //                 margin:
    //                     EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 30.w),
    //                 color: newLightGreyColor,
    //               ),
    //               SizedBox(height: 2.h),
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       selectedValue1 = "Packets are out of stock";
    //                       print("selectedValue1 : $selectedValue1");
    //                       Get.back();
    //                     });
    //                   },
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Packets are out of stock',
    //                         style: TextStyle(
    //                           fontFamily:
    //                               (selectedValue1 == "Packets are out of stock")
    //                                   ? fontMedium
    //                                   : fontBook,
    //                           color:
    //                               (selectedValue1 == "Packets are out of stock")
    //                                   ? gSecondaryColor
    //                                   : newBlackColor,
    //                           fontSize: fontSize09,
    //                         ),
    //                       ),
    //                       Transform.scale(
    //                         scale: 1.0,
    //                         child: Radio(
    //                           value: "Packets are out of stock",
    //                           fillColor:
    //                               MaterialStateProperty.all(gSecondaryColor),
    //                           groupValue: selectedValue1,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               selectedValue1 = value as String;
    //                               Get.back();
    //                             });
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 height: 1,
    //                 margin: EdgeInsets.symmetric(vertical: 1.h),
    //                 color: Colors.grey.withOpacity(0.5),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       selectedValue1 = "Items are out of stock";
    //                       print("selectedValue1 : $selectedValue1");
    //
    //                       Get.back();
    //                     });
    //                   },
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Items are out of stock',
    //                         style: TextStyle(
    //                           fontFamily:
    //                               (selectedValue1 == "Items are out of stock")
    //                                   ? fontMedium
    //                                   : fontBook,
    //                           color:
    //                               (selectedValue1 == "Items are out of stock")
    //                                   ? gSecondaryColor
    //                                   : newBlackColor,
    //                           fontSize: fontSize09,
    //                         ),
    //                       ),
    //                       Transform.scale(
    //                         scale: 1.0,
    //                         child: Radio(
    //                           value: "Items are out of stock",
    //                           fillColor:
    //                               MaterialStateProperty.all(gSecondaryColor),
    //                           groupValue: selectedValue1,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               selectedValue1 = value as String;
    //                               Get.back();
    //                             });
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 height: 1,
    //                 margin: EdgeInsets.symmetric(vertical: 1.h),
    //                 color: Colors.grey.withOpacity(0.5),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       selectedValue1 = "Technical issue";
    //                       print("selectedValue1 : $selectedValue1");
    //
    //                       Get.back();
    //                     });
    //                   },
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Technical issue',
    //                         style: TextStyle(
    //                           fontFamily: (selectedValue1 == "Technical issue")
    //                               ? fontMedium
    //                               : fontBook,
    //                           color: (selectedValue1 == "Technical issue")
    //                               ? gSecondaryColor
    //                               : newBlackColor,
    //                           fontSize: fontSize09,
    //                         ),
    //                       ),
    //                       Transform.scale(
    //                         scale: 1.0,
    //                         child: Radio(
    //                           value: "Technical issue",
    //                           fillColor:
    //                               MaterialStateProperty.all(gSecondaryColor),
    //                           groupValue: selectedValue1,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               selectedValue1 = value as String;
    //                               Get.back();
    //                             });
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 height: 1,
    //                 margin: EdgeInsets.symmetric(vertical: 1.h),
    //                 color: Colors.grey.withOpacity(0.5),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       selectedValue1 = "Others :";
    //                       print("selectedValue1 : $selectedValue1");
    //                     });
    //                   },
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         'Others :',
    //                         style: TextStyle(
    //                           fontFamily: (selectedValue1 == "Others :")
    //                               ? fontMedium
    //                               : fontBook,
    //                           color: (selectedValue1 == "Others :")
    //                               ? gSecondaryColor
    //                               : newBlackColor,
    //                           fontSize: fontSize09,
    //                         ),
    //                       ),
    //                       Transform.scale(
    //                         scale: 1.0,
    //                         child: Radio(
    //                           value: "Others :",
    //                           fillColor:
    //                               MaterialStateProperty.all(gSecondaryColor),
    //                           groupValue: selectedValue1,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               selectedValue1 = value as String;
    //                             });
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 height: 1,
    //                 margin: EdgeInsets.symmetric(vertical: 1.h),
    //                 color: Colors.grey.withOpacity(0.5),
    //               ),
    //               selectedValue1 == "Others :"
    //                   ? Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           padding: EdgeInsets.symmetric(
    //                               horizontal: 2.w, vertical: 1.h),
    //                           margin: EdgeInsets.symmetric(
    //                               vertical: 2.h, horizontal: 5.w),
    //                           decoration: BoxDecoration(
    //                             color: gWhiteColor,
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.grey.withOpacity(0.5),
    //                                 offset: const Offset(2, 3),
    //                                 blurRadius: 5,
    //                               ),
    //                             ],
    //                             borderRadius: BorderRadius.circular(10),
    //                           ),
    //                           child: TextField(
    //                             maxLines: null,
    //                             controller: otherController,
    //                             textCapitalization:
    //                                 TextCapitalization.sentences,
    //                             cursorColor: gSecondaryColor,
    //                             style: LoginScreen().mainTextField(),
    //                             textInputAction: TextInputAction.next,
    //                             textAlign: TextAlign.start,
    //                             decoration: InputDecoration(
    //                               border: InputBorder.none,
    //                               hintText: "Enter comments",
    //                               hintStyle: LoginScreen().hintTextField(),
    //                               suffixIcon: otherController.text.isEmpty
    //                                   ? Container(width: 0)
    //                                   : InkWell(
    //                                       onTap: () {
    //                                         otherController.clear();
    //                                       },
    //                                       child: Icon(
    //                                         Icons.close,
    //                                         color: newBlackColor,
    //                                         size: 2.h,
    //                                       ),
    //                                     ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: 3.h),
    //                         Center(
    //                           child: GestureDetector(
    //                             onTap: () {
    //                               (otherController.text.isNotEmpty)
    //                                   ? Get.back()
    //                                   : showSnackBar(
    //                                       context,
    //                                       "Please Enter your Comments",
    //                                       gSecondaryColor);
    //                             },
    //                             child: Container(
    //                               padding: EdgeInsets.symmetric(
    //                                   vertical: 1.h, horizontal: 5.w),
    //                               decoration: BoxDecoration(
    //                                 color: gSecondaryColor,
    //                                 borderRadius: BorderRadius.circular(10),
    //                                 border: Border.all(
    //                                     color: gSecondaryColor, width: 1),
    //                               ),
    //                               child: Text(
    //                                 'Submit',
    //                                 style:
    //                                     LoginScreen().buttonText(gWhiteColor),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   : Container(),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }

  buildPackedDetails(BuildContext context) {
    return StatefulBuilder(builder: (_, setState) {
      return Material(
        color: gBlackColor.withOpacity(0.1),
        child: Center(
          child: Container(
            height: 35.h,
            width: 80.w,
            //margin: EdgeInsets.symmetric(horizontal: 30.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: gWhiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Packed",
                      style: BottomSheetTextStyle().headingText(),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin:
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 25.w),
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Enter the Total weight of Package",
                    style: BottomSheetTextStyle().subHeadingText(),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      color: gWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(2, 3),
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: commentController,
                      keyboardType: TextInputType.number,
                      cursorColor: gMainColor,
                      style: LoginScreen().mainTextField(),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter weight in Kg",
                        hintStyle: LoginScreen().hintTextField(),
                        suffixIcon: commentController.text.isEmpty
                            ? Container(width: 0)
                            : InkWell(
                                onTap: () {
                                  commentController.clear();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: gMainColor,
                                  size: 2.h,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        commentController.text.isNotEmpty
                            ? Get.back()
                            : showSnackBar(context, "Please Enter The Weight",
                                gSecondaryColor);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: gSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: gSecondaryColor, width: 1),
                        ),
                        child: Text(
                          'Submit',
                          style: LoginScreen().buttonText(gWhiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  buildShippingStatusText() {
    return StatefulBuilder(builder: (_, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: selectedValue == "packed"
            ? Text(
                commentController.text.isEmpty
                    ? " "
                    : "${commentController.text.toString()} Kg",
                style: TextStyle(
                  color: newBlackColor,
                  fontFamily: fontMedium,
                  fontSize: fontSize09,
                ),
              )
            : Text(
                "${selectedValue1.toString()} ${otherController.text.toString()}",
                style: TextStyle(
                  color: newBlackColor,
                  fontFamily: fontMedium,
                  fontSize: fontSize09,
                ),
              ),
      );
    });
  }

  sendStatus() async {
    setState(() {
      isLoading = true;
    });
    print("---------Send Shipping Status---------");

    final result = await customerStatusService.sendShippingStatusService(
      selectedValue,
      selectedValue1,
      commentController.text.toString(),
      "${widget.userId}",
    );

    if (result.runtimeType == SendShippingStatusModel) {
      SendShippingStatusModel model = result as SendShippingStatusModel;
      setState(() {
        isLoading = false;
      });
      GwcApi().showSnackBar(context, model.errorMsg, isError: false);
    } else {
      setState(() {
        isLoading = false;
      });
      ErrorModel response = result as ErrorModel;
      GwcApi().showSnackBar(context, response.message!, isError: true);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
  }

  final CustomerStatusRepo customerStatusRepo = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  final ShipRocketRepository shipTrackRepository = ShipRocketRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
