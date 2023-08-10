import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../utils/common_screen_widget.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/widgets.dart';
import '../../shipment_screens/shipment_list_screens/customer_order_products.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/screens/dashboard_screens/dashboard_screen.dart';

class PendingPausedOrderDetails extends StatefulWidget {
  final String userName;
  final String address;
  final String addressNo;
  final String userId;
  const PendingPausedOrderDetails(
      {Key? key,
      required this.userName,
      required this.address,
      required this.addressNo, required this.userId})
      : super(key: key);

  @override
  State<PendingPausedOrderDetails> createState() =>
      _PendingPausedOrderDetailsState();
}

class _PendingPausedOrderDetailsState extends State<PendingPausedOrderDetails> {
  TextEditingController commentController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  bool isLoading = false;
  String selectedValue = "";
  String selectedValue1 = "";

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      setState(() {});
    });
    otherController.addListener(() {
      setState(() {});
    });
    updateStatus;
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
    otherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedValue1);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.h, left: 5.w),
                child: buildAppBar(() {
                  Navigator.pop(context);
                }),
              ),
              profileTile("Name : ", widget.userName),
              profileTile(
                  "Address : ", "${widget.addressNo}, ${widget.address}"),
              CustomerOrderProducts(userId: widget.userId,),
              buildRadioButtons(),
              SizedBox(height: 3.h),
              buildStatusText(),
              SizedBox(height: 8.h),
              StatefulBuilder(builder: (_, setState) {
                return Center(
                  child: GestureDetector(
                    onTap: (isLoading)
                        ? null
                        : () {
                            print("ISLOADING : $isLoading");
                            updateStatus(setState);
                          },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
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
                );
              }),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
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
                              fontFamily: (selectedValue1 ==
                                  "Packets are out of stock")
                                  ? fontMedium
                                  : fontBook,
                              color: (selectedValue1 ==
                                  "Packets are out of stock")
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
                              fontFamily:
                              (selectedValue1 == "Technical issue")
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

  profileTile(String title, String subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
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

  buildPausedText() {
    return StatefulBuilder(builder: (_, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Text(
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

  void updateStatus(Function setstate) async {
    if (selectedValue.isEmpty) {
      setstate(() {
        isLoading = false;
      });
      showSnackBar(context, "Please Select the status", gSecondaryColor);
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var userId = preferences.getInt("user_id");

      Map<String, dynamic> dataBody = {
        'status': selectedValue,
        'reason': selectedValue1,
        'weight': commentController.text.toString(),
      };
      print("--- status ---");
      print(dataBody);
      print("${GwcApi.shippingUpdateStatus}/$userId");
      var response = await http.post(
          Uri.parse("${GwcApi.shippingUpdateStatus}/$userId"),
          headers: {'Authorization': 'Bearer $token'},
          body: dataBody);
      print("Submit Response: ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == 200) {
          setstate(() {
            isLoading = true;
          });
          Get.to(const DashboardScreen());
          showSnackBar(context, responseData['data'], gPrimaryColor);
        } else if (responseData['status'] == 401) {
          setstate(() {
            isLoading = false;
          });
          showSnackBar(context, responseData['message'], gSecondaryColor);
        } else {
          setstate(() {
            isLoading = false;
          });
          showSnackBar(context, "API Problem", gSecondaryColor);
        }
      }
    }
  }

  buildStatusText() {
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
}
