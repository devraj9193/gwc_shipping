import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../../utils/gwc_apis.dart';
import '../../../widgets/widgets.dart';
import '../customer_order_products.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/screens/dashboard_screens/dashboard_screen.dart';

class PendingPausedOrderDetails extends StatefulWidget {
  final String userName;
  const PendingPausedOrderDetails({Key? key, required this.userName})
      : super(key: key);

  @override
  State<PendingPausedOrderDetails> createState() =>
      _PendingPausedOrderDetailsState();
}

class _PendingPausedOrderDetailsState extends State<PendingPausedOrderDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
    otherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  child: buildAppBar(() {
                    Navigator.pop(context);
                  }),
                ),
                profileTile("Name : ", widget.userName),
                const CustomerOrderProducts(),
                buildProductDetails(),
                selectedValue == "packed"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          "${commentController.text.toString()} Kg",
                          style: TextStyle(
                            color: gPrimaryColor,
                            fontFamily: 'GothamMedium',
                            fontSize: 8.sp,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          "${selectedValue1.toString()} ${otherController.text.toString()}",
                          style: TextStyle(
                            color: gPrimaryColor,
                            fontFamily: 'GothamMedium',
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                SizedBox(height: 1.h),
                buildSubmitButton(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileTile(String title, String subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: gBlackColor,
              fontFamily: 'GothamBold',
              fontSize: 9.sp,
            ),
          ),
          Expanded(
            child: Text(
              subTitle,
              style: TextStyle(
                color: gBlackColor,
                fontFamily: 'GothamMedium',
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildProductDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.0,
            child: Radio(
              value: "paused",
              fillColor: MaterialStateProperty.all(gPrimaryColor),
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                  buildPauseDetails();
                });
              },
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            'Paused',
            style: TextStyle(
              fontSize: 9.sp,
              color: gMainColor,
              fontFamily: "GothamMedium",
            ),
          ),
          SizedBox(width: 5.w),
          Transform.scale(
            scale: 1.0,
            child: Radio(
              value: "packed",
              fillColor: MaterialStateProperty.all(gPrimaryColor),
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
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
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            'Packed',
            style: TextStyle(
              fontSize: 9.sp,
              color: gMainColor,
              fontFamily: "GothamMedium",
            ),
          ),
        ],
      ),
    );
  }

  buildPauseDetails() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          height: size.height * 100,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Paused",
                    style: TextStyle(
                      color: gMainColor,
                      fontFamily: 'GothamMedium',
                      fontSize: 9.sp,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 50.w),
                  color: Colors.grey.withOpacity(0.8),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Packets are out of stock',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Transform.scale(
                      scale: 1.0,
                      child: Radio(
                        value: "Packets are out of stock",
                        fillColor: MaterialStateProperty.all(gMainColor),
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
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items are out of stock',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Transform.scale(
                      scale: 1.0,
                      child: Radio(
                        value: "Items are out of stock",
                        fillColor: MaterialStateProperty.all(gMainColor),
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
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Technical issue',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Transform.scale(
                      scale: 1.0,
                      child: Radio(
                        value: "Technical issue",
                        fillColor: MaterialStateProperty.all(gMainColor),
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
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Others :',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Transform.scale(
                      scale: 1.0,
                      child: Radio(
                        value: "Others :",
                        fillColor: MaterialStateProperty.all(gMainColor),
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
                selectedValue1 == "Others :"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          TextField(
                            controller: otherController,
                            cursorColor: gMainColor,
                            style: TextStyle(
                                fontFamily: "GothamMedium",
                                color: gMainColor,
                                fontSize: 8.sp),
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              hintText: "Enter comments",
                              hintStyle: TextStyle(
                                fontFamily: "GothamBook",
                                color: gMainColor,
                                fontSize: 7.sp,
                              ),
                              suffixIcon: otherController.text.isEmpty
                                  ? Container(width: 0)
                                  : InkWell(
                                      onTap: () {
                                        otherController.clear();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: gMainColor,
                                        size: 2.h,
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
                                        gMainColor);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 5.w),
                                decoration: BoxDecoration(
                                  color: (otherController.text.isEmpty)
                                      ? gMainColor
                                      : gPrimaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: gMainColor, width: 1),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: (otherController.text.isEmpty)
                                        ? gPrimaryColor
                                        : gMainColor,
                                    fontSize: 7.sp,
                                  ),
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
      }),
    );
  }

  buildPackedDetails(BuildContext context) {
    return Material(
      color: gBlackColor.withOpacity(0.1),
      child: Center(
        child: Container(
          height: 25.h,
          width: 80.w,
          //margin: EdgeInsets.symmetric(horizontal: 30.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: gWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Packed",
                    style: TextStyle(
                      color: gMainColor,
                      fontFamily: 'GothamMedium',
                      fontSize: 9.sp,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 25.w),
                  color: Colors.grey.withOpacity(0.8),
                ),
                SizedBox(height: 1.h),
                Text(
                  "Enter the Total weight of Package",
                  style: TextStyle(
                      fontSize: 7.sp,
                      fontFamily: "GothamMedium",
                      color: gPrimaryColor),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: commentController,
                  keyboardType: TextInputType.number,
                  cursorColor: gMainColor,
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gMainColor,
                      fontSize: 8.sp),
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: "Enter weight in Kg",
                    hintStyle: TextStyle(
                      fontFamily: "GothamBook",
                      color: gMainColor,
                      fontSize: 6.sp,
                    ),
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
                SizedBox(height: 3.h),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      commentController.text.isNotEmpty
                          ? Get.back()
                          : showSnackBar(
                              context, "Please Enter The Weight", gMainColor);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: (commentController.text.isEmpty)
                            ? gMainColor
                            : gPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: gMainColor, width: 1),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: "GothamMedium",
                          color: (commentController.text.isEmpty)
                              ? gPrimaryColor
                              : gMainColor,
                          fontSize: 7.sp,
                        ),
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
  }

  buildSubmitButton() {
    return Center(
      child: GestureDetector(
        onTap: (isLoading)
            ? null
            : () {
                updateStatus();
              },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
          decoration: BoxDecoration(
            color: (selectedValue.isEmpty) ? gMainColor : gPrimaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gMainColor, width: 1),
          ),
          child: (isLoading)
              ? buildThreeBounceIndicator(color: gMainColor)
              : Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: "GothamMedium",
                    color: (selectedValue.isEmpty) ? gPrimaryColor : gMainColor,
                    fontSize: 9.sp,
                  ),
                ),
        ),
      ),
    );
  }

  void updateStatus() async {
    if (selectedValue.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Please Select the status", gMainColor);
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
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == 200) {
          setState(() {
            isLoading = true;
          });
          Get.to(const DashboardScreen());
          buildSnackBar("", responseData['data']);
        } else if (responseData['status'] == 401) {
          setState(() {
            isLoading = false;
          });
          buildSnackBar(
            "Failed",
            responseData['message'],
          );
        } else {
          setState(() {
            isLoading = false;
          });
          buildSnackBar("Failed", "API Problem");
        }
      }
    }
  }
}
