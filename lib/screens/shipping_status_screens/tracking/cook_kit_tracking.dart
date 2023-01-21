import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/ship_rocket_tracking_controller.dart';
import '../../../model/ship_track_model/ship_track_activity_model.dart';
import '../../../model/ship_track_model/shopping_model/child_get_shopping_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../model/ship_tracking_model.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/stepper/another_stepper.dart';
import '../../../widgets/stepper/stepper_data.dart';
import '../../../widgets/widgets.dart';

class CookKitTracking extends StatefulWidget {
  final String currentStage;
  final String? awbNumber;
  const CookKitTracking({Key? key, this.awbNumber, required this.currentStage})
      : super(key: key);

  @override
  State<CookKitTracking> createState() => _CookKitTrackingState();
}

class _CookKitTrackingState extends State<CookKitTracking> {
  double gap = 23.0;
  int activeStep = -1;

  Timer? timer;
  int upperBound = -1;

  bool isDelivered = false;

  List<ShipmentTrackActivities> trackerList = [];
  String estimatedDate = '';
  String estimatedDay = '';

  final _pref = AppConfig().preferences;
  List<ChildGetShoppingModel> shoppingData = [];

  ShipRocketTrackingController shipRocketTrackingController =
      Get.put(ShipRocketTrackingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildAppBar(() {
                  Navigator.pop(context);
                }),
                shipRocketUI(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shipRocketUI(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
              future: shipRocketTrackingController.fetchTrackingDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return const Text("");
                } else if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Column(
                    // shrinkWrap: true,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      estimatedDateView(data.trackingData.etd),
                      Visibility(
                        // visible: trackerList.isNotEmpty,
                        child: SizedBox(
                          height: 20.h,
                          child: AnotherStepper(
                            stepperList: getStepper(
                                data.trackingData.shipmentTrackActivities),
                            gap: gap,
                            isInitialText: true,
                            initialText: getStepperInitialValue(),
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            stepperDirection: Axis.horizontal,
                            horizontalStepperHeight: 5,
                            dotWidget: getIcons(),
                            activeBarColor: gPrimaryColor,
                            inActiveBarColor: Colors.grey.shade200,
                            activeIndex: activeStep,
                            barThickness: 5,
                            titleTextStyle: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: "GothamMedium",
                            ),
                            subtitleTextStyle: TextStyle(
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                      // trackingField(),
                      SizedBox(height: 5.h),
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontFamily: "GothamMedium",
                          fontSize: 9.sp,
                          color: gPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.5.h, horizontal: 1.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: gMainColor, width: 1),
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: gPrimaryColor,
                              size: 4.h,
                            ),
                          ),
                          Text(
                            _pref?.getString(AppConfig.SHIPPING_ADDRESS) ?? "",
                            style: TextStyle(
                              height: 1.5,
                              fontFamily: "GothamBook",
                              fontSize: 11.sp,
                              color: gTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: buildCircularIndicator(),
                );
              }),
        ],
      ),
    );
  }

  getStepper(List<ShipmentTrackActivity> activity) {
    List<StepperData> stepper = [];
    List<ShipmentTrackActivity> trackerList = activity;
    print("Track : $trackerList");
    trackerList.map((e) {
      String txt = 'Location: ${e.location}';
      print("txt.length$txt");
      stepper.add(StepperData(
        // title: e.srStatusLabel!.contains('NA') ? 'Activity: ${e.activity}' : 'Activity: ${e.srStatusLabel}',
        title: 'Activity: ${e.srStatusLabel}',
        subtitle: 'Location: ${e.location}',
      ));
    }).toList();
    // setState(() {
    //   gap =
    //       trackerList.any((element) => element.location!.length > 60) ? 33 : 23;
    // });
    return stepper;
  }

  getStepperInitialValue() {
    List<StepperData> stepper = [];
    trackerList.map((e) {
      stepper.add(StepperData(
        title: DateFormat('dd MMM').format(DateTime.parse(e.date!)),
        subtitle: DateFormat('hh:mm a').format(DateTime.parse(e.date!)),
      ));
    }).toList();
    return stepper;
  }

  estimatedDateView(DateTime etd) {
    estimatedDate = etd.toString();
    estimatedDay = DateFormat('EEEE').format(DateTime.parse(estimatedDate));
    if (isDelivered == false) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
              text: 'Estimated Delivery Date - ',
              style: TextStyle(
                  fontFamily: "GothamMedium",
                  color: gPrimaryColor,
                  fontSize: 9.sp),
              children: [
                TextSpan(
                  text: estimatedDate ?? '',
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gMainColor,
                      fontSize: 8.sp),
                )
              ]),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Delivered On: ',
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gPrimaryColor,
                      fontSize: 9.sp),
                  children: [
                    TextSpan(
                      text: estimatedDay ?? '',
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gMainColor,
                          fontSize: 8.sp),
                    )
                  ]),
            ),
            Text(
              estimatedDate,
              style: TextStyle(
                  fontFamily: "GothamBook",
                  color: gPrimaryColor,
                  fontSize: 8.sp),
            )
          ],
        ),
      );
    }
  }

  getIcons() {
    // print("activeStep==> $activeStep  trackerList.length => ${trackerList.length}");
    List<Widget> widgets = [];
    for (var i = 0; i < trackerList.length; i++) {
      // print('-i----$i');
      // print(trackerList[i].srStatus != '7');
      if (i == 0 && trackerList[i].srStatus != '7') {
        widgets.add(Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: gPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Icon(
              Icons.radio_button_checked_sharp,
              color: Colors.white,
              size: 15.sp,
            )
            // (!trackerList.every((element) => element.srStatus!.contains('7')) && trackerList.length-1) ? Icon(Icons.radio_button_checked_sharp, color: Colors.white, size: 15.sp,) : Icon(Icons.check, color: Colors.white, size: 15.sp,),
            ));
      } else {
        widgets.add(Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                color: gPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15.sp,
            )
            // (!trackerList.every((element) => element.srStatus!.contains('7')) && trackerList.length-1) ? Icon(Icons.radio_button_checked_sharp, color: Colors.white, size: 15.sp,) : Icon(Icons.check, color: Colors.white, size: 15.sp,),
            ));
      }
    }
    return widgets;
  }
}
