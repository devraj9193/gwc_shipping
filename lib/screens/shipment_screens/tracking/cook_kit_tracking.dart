import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';

import '../../../controller/repository/ship_rocket_repository/ship_track_repo.dart';
import '../../../controller/services/api_services.dart';
import '../../../controller/services/ship_rocket_service/ship_track_service.dart';
import '../../../model/error_model.dart';
import '../../../model/shiprocket_auth_model/ship_tracking_model.dart';
import '../../../utils/app_config.dart';
import '../../../utils/common_screen_widget.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class CookKitTracking extends StatefulWidget {
  final String userName;
  final String awbNumber;
  const CookKitTracking(
      {Key? key, required this.awbNumber, required this.userName})
      : super(key: key);

  @override
  State<CookKitTracking> createState() => _CookKitTrackingState();
}

class _CookKitTrackingState extends State<CookKitTracking> {
  int activeStep = -1;
  double gap = 23.0;

  Timer? timer;
  int upperBound = -1;
  List<ShipmentTrackActivity> trackerList = [];
  String estimatedDate = '';
  String estimatedDay = '';
  String shipAddress = '';

  String awb1 = '119982675';
  String awb2 = '14326322712380';
  String awb3 = '14326322704046';

  bool isDelivered = false;

  bool showErrorText = false;

  String errorTextResponse = '';

  bool showTrackingProgress = false;

  @override
  void initState() {
    super.initState();
    shippingTracker();
  }

  late final ShipRocketService shipRocketService =
  ShipRocketService(shipRocketRepository: repository);

  shippingTracker() async {
    setState(() {
      showTrackingProgress = true;
    });

    final result = await shipRocketService.getShipRocketTrackingService(widget.awbNumber);
    print("result: $result");

    if (result.runtimeType == ShipTrackingModel) {
      print("Ticket List");
      ShipTrackingModel model = result as ShipTrackingModel;

      if (model.trackingData!.error != null) {
        setState(() {
          showErrorText = true;
          errorTextResponse = model.trackingData?.error ?? '';
        });
      } else {
        print(model.trackingData!.shipmentTrackActivities);
        for (var element in model.trackingData!.shipmentTrackActivities!) {
          trackerList.add(element);
          if (element.srStatusLabel!.toLowerCase() == 'delivered') {
            setState(() {
              isDelivered = true;
            });
          }
        }
        shipAddress = model.trackingData?.shipmentTrack?.first.deliveredTo ?? '';
        estimatedDate = model.trackingData!.etd!;
        estimatedDay = DateFormat('EEEE').format(DateTime.parse(estimatedDate));
        //print("estimatedDay: $estimatedDay");
        setState(() {
          upperBound = trackerList.length;
          activeStep = 0;
        });

        timer = Timer.periodic(const Duration(milliseconds: 500), (timer1) {
          //print(timer1.tick);
          //print('activeStep: $activeStep');
          //print('upperBound:$upperBound');
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          } else {
            timer1.cancel();
          }
        });
      }

    } else {
      ErrorModel model = result as ErrorModel;
      if (model.message!.contains("Token has expired")) {
        print("called shiprocket token from cook kit tracking");
        getShipRocketToken();
      }
      print("error: ${model.message}");
      setState(() {
        showTrackingProgress = false;
      });
    }
    setState(() {
      showTrackingProgress = false;
    });
    print(result);
  }

  void getShipRocketToken() async{
    print("getShipRocketToken called");
    ShipRocketService shipRocketService = ShipRocketService(shipRocketRepository: repository);
    final getToken = await shipRocketService.getShipRocketTokenService(AppConfig().shipRocketEmail, AppConfig().shipRocketPassword);
    print(getToken);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(top: 1.h, left: 4.w, right: 4.w, bottom: 1.w),
          child: Column(
            children: [
              buildAppBar(() {
                Navigator.pop(context);
              }),
              Expanded(
                child: shipRocketUI(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  shipRocketUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileTile("Name : ", widget.userName),
          profileTile(
            "Estimated Delivery Date : ",estimatedDate,
            // DateFormat('dd MMM yyyy')
            //     .format(
            //     DateTime.parse((estimatedDate.toString())))
            //     .toString(),
          ),
          ListView.builder(
            itemCount: trackerList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
               var data = trackerList[index];
              return TimelineTile(
                alignment: TimelineAlign.manual,
                axis: TimelineAxis.vertical,
                lineXY: 0.05,
                isFirst: index == 0,
                isLast: index ==
                    trackerList.length - 1,
                indicatorStyle: IndicatorStyle(
                  width: 60,
                  height: 60,
                  indicator: index == 0
                      ? data.srStatusLabel ==
                      "DELIVERED" ||
                      data.srStatusLabel ==
                          "PICKUP EXCEPTION"
                      ? Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: gPrimaryColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.circle,
                      color: gPrimaryColor,
                      size: 2.5.h,
                    ),
                  )
                      : RippleAnimation(
                    color: gPrimaryColor,
                    delay: const Duration(milliseconds: 300),
                    repeat: true,
                    minRadius: 30,
                    ripplesCount: 2,
                    duration:
                    const Duration(milliseconds: 6 * 300),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: gPrimaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        color: gPrimaryColor,
                        size: 2.5.h,
                      ),
                    ),
                  )
                      : Icon(
                    Icons.check_circle,
                    color: data.srStatusLabel ==
                        "DELIVERED" ||
                        data.srStatusLabel ==
                            "PICKUP EXCEPTION"
                        ? gPrimaryColor
                        : (index == 0)
                        ? newLightGreyColor
                        : gPrimaryColor,
                    size: 3.h,
                  ),
                  // _IndicatorExample(number: '${index + 1}'),
                  drawGap: true,
                ),
                beforeLineStyle: const LineStyle(
                  color: gPrimaryColor,
                ),
                endChild: Padding(
                  padding: EdgeInsets.only(left: 2.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.srStatusLabel ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: AllListText().headingText(),
                            ),
                          ),
                          data.srStatusLabel ==
                              "DELIVERED" ||
                              data.srStatusLabel ==
                                  "PICKUP EXCEPTION"
                              ? buildMealPlanStatus(
                            "Complete",
                            gPrimaryColor.withOpacity(0.6),
                                () {
                              buildTrackingDetails(
                                data.srStatusLabel ?? '',
                                data.activity ?? '',
                                data.location ?? '',
                                DateTime.parse("${data.date}"),
                              );
                            },
                          )
                              : (index == 0)
                              ? buildMealPlanStatus(
                            "On Progress",
                            newLightGreyColor,
                                () {
                              buildTrackingDetails(
                                data.srStatusLabel ?? '',
                                data.activity ?? '',
                                data.location ?? '',
                                DateTime.parse("${data.date}"),
                              );
                            },
                          )
                              : buildMealPlanStatus(
                            "Complete",
                            gPrimaryColor.withOpacity(0.6),
                                () {
                              buildTrackingDetails(
                                data.srStatusLabel ?? '',
                                data.activity ?? '',
                                data.location ?? '',
                                DateTime.parse("${data.date}"),
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        data.location ?? '',
                        textAlign: TextAlign.start,
                        style: AllListText().subHeadingText(),
                      ),
                      Text(
                        buildTimeDate(DateTime.parse("${data.date}")),
                        textAlign: TextAlign.start,
                        style: AllListText().otherText(),
                      ),
                      SizedBox(height: 0.5.h),
                    ],
                  ),
                ),
              );
            },
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 1.h),
          //   child: AnotherStepper(
          //     stepperList: getStepper1(
          //         data.trackingData.shipmentTrackActivities),
          //     stepperDirection: Axis.horizontal,
          //     gap: gap,
          //     isInitialText: true,
          //     initialText: getStepperInitialValue(),
          //     scrollPhysics: const NeverScrollableScrollPhysics(),
          //     inverted: true,
          //     horizontalStepperHeight: 50,
          //     dotWidget: getIcons(),
          //     activeBarColor: gPrimaryColor,
          //     inActiveBarColor: Colors.grey.shade200,
          //     activeIndex: activeStep,
          //     barThickness: 5,
          //     titleTextStyle: TextStyle(
          //       fontSize: 10.sp,
          //       fontFamily: "GothamMedium",
          //     ),
          //     subtitleTextStyle: TextStyle(
          //       fontSize: 8.sp,
          //     ),
          //   ),
          // ),
          // AnotherStepper(
          //   stepperList: getStepper1(data.trackingData.shipmentTrackActivities),
          //   stepperDirection: Axis.vertical,
          //   inverted: false,
          //   activeIndex: 2,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 1.h),
          //   child: EasyStepper(
          //     activeStep: activeStep,
          //     lineLength: 100,
          //     lineSpace: 0,
          //     lineType: LineType.normal,
          //     activeStepTextColor: Colors.black87,
          //     finishedStepTextColor: Colors.black87,
          //     showLoadingAnimation: false,
          //     stepRadius: 30,
          //     showStepBorder: false,
          //     direction: Axis.horizontal,
          //     // unreachedStepBackgroundColor: newLightGreyColor,
          //     // unreachedStepTextColor: newLightGreyColor,
          //     // unreachedStepBorderColor: newLightGreyColor,
          //     unreachedStepIconColor: gPrimaryColor,
          //     // unreachedStepBorderType: BorderType.normal,
          //     // activeStepBackgroundColor: gMainColor,
          //     // activeStepBorderColor: gMainColor,
          //     // activeStepBorderType: BorderType.normal,
          //     activeStepIconColor: gPrimaryColor,
          //     // activeStepTextColor: gMainColor,
          //     // finishedStepBackgroundColor: gPrimaryColor,
          //     // finishedStepBorderColor: gPrimaryColor,
          //     // finishedStepBorderType: BorderType.normal,
          //     finishedStepIconColor: gPrimaryColor,
          //     // finishedStepTextColor: gPrimaryColor,
          //     lineDotRadius: 2,
          //     lineColor: gPrimaryColor,
          //     padding: 5,
          //     // enableStepTapping: false,
          //     // showStepBorder: false,
          //     // loadingAnimation: 'assets/loading_circle.json',
          //     steps: getStepper(
          //         data.trackingData.shipmentTrackActivities),
          //     onStepReached: (index) =>
          //         setState(() => activeStep = index),
          //   ),
          // ),
          SizedBox(height: 3.h),
          Text(
            "Delivery Address",
            style: TextStyle(
              fontFamily: "GothamBook",
              color: gBlackColor,
              fontSize: 9.sp,
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
                  border:
                  Border.all(color: newLightGreyColor, width: 1),
                ),
                child: Icon(
                  Icons.location_on,
                  color: gSecondaryColor,
                  size: 3.h,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                shipAddress,
                style: TextStyle(
                    fontFamily: "GothamMedium",
                    color: gBlackColor,
                    fontSize: 10.sp),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  buildMealPlanStatus(String status, Color color, VoidCallback func) {
    return InkWell(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 8.sp,
            fontFamily: fontMedium,
            color: newBlackColor,
          ),
        ),
      ),
    );
  }

  profileTile(String title, String subTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.2.h),
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

  buildTimeDate(DateTime date) {
    String amPm = 'AM';
    if (date.hour >= 12) {
      amPm = 'PM';
    }
    String hour = date.hour.toString();
    if (date.hour > 12) {
      hour = (date.hour - 12).toString();
    }

    String minute = date.minute.toString();
    if (date.minute < 10) {
      minute = '0${date.minute}';
    }
    return "${DateFormat('dd MMMM yyyy').format(date)} / $hour : $minute $amPm";
  }

  buildTrackingDetails(
      String status, String activity, String location, DateTime date) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Center(
              child: Column(
                children: [
                  Text(
                    'Tracking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontBold,
                      color: newBlackColor,
                      fontSize: fontSize13,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 40.w,
                    margin: EdgeInsets.symmetric(vertical: 0.5.h),
                    color: newLightGreyColor,
                  ),
                ],
              ),
            ),
            content: Container(
              width: 120.w,
              height: 350, // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(30),
              //   color: gWhiteColor,
              // ),
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    status,
                    textAlign: TextAlign.center,
                    style: AllListText().headingText(),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    activity,
                    textAlign: TextAlign.center,
                    style: AllListText().subHeadingText(),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    location,
                    textAlign: TextAlign.center,
                    style: AllListText().otherText(),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    buildTimeDate(date),
                    textAlign: TextAlign.center,
                    style: AllListText().otherText(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 1.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: gSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'close',
                      style: LoginScreen().buttonText(whiteTextColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  final ShipRocketRepository repository = ShipRocketRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

// getStepper1(List<ShipmentTrackActivity> activity) {
  //   List<StepperData> stepper = [];
  //   List<ShipmentTrackActivity> trackerList = activity;
  //   trackerList.map((e) {
  //     String txt = 'Location: ${e.location}';
  //     print("txt.length${txt.length}");
  //     stepper.add(StepperData(
  //       // title: e.srStatusLabel!.contains('NA') ? 'Activity: ${e.activity}' : 'Activity: ${e.srStatusLabel}',
  //       title: StepperText('Activity: ${e.srStatusLabel}'),
  //       subtitle: StepperText('Location: ${e.location}'),
  //     ));
  //   }).toList();
  //   gap = trackerList.any((element) => element.location!.length > 60) ? 33 : 23;
  //   return stepper;
  // }
  //
  // getStepper(List<ShipmentTrackActivity> activity) {
  //   List<EasyStep> stepper = [];
  //   List<ShipmentTrackActivity> trackerList = activity;
  //   print("Track : $trackerList");
  //   trackerList.map((e) {
  //     stepper.add(
  //       EasyStep(
  //         icon: const Icon(
  //           Icons.check_circle,
  //         ),
  //         title: '${e.location}',
  //         lineText: '${e.srStatusLabel}',
  //       ),
  //     );
  //   }).toList();
  //   // setState(() {
  //   //   gap =
  //   //       trackerList.any((element) => element.location!.length > 60) ? 33 : 23;
  //   // });
  //   return stepper;
  // }
  //
  // List<Step> stepList() => [
  //       const Step(title: Text('Account'), content: Text('Account number')),
  //       const Step(title: Text('Address'), content: Text('Address')),
  //       const Step(title: Text('Confirm'), content: Text('Confirm'))
  //     ];

  // buildTracking() {
  //   return SizedBox(
  //     height: 20.h,
  //     child: Timeline.tileBuilder(
  //       builder: TimelineTileBuilder.fromStyle(
  //         contentsAlign: ContentsAlign.alternating,
  //         contentsBuilder: (context, index) =>
  //             Text('Timeline Event $index'),
  //         itemCount: 10,
  //         oppositeContentsBuilder: (context, index) =>
  //             Text('Timeline Event $index'),
  //          indicatorPositionBuilder: (_, index) => 10,
  //         connectorStyle: ConnectorStyle.solidLine,
  //         endConnectorStyle: ConnectorStyle.transparent,
  //         itemExtent: 150,
  //         indicatorStyle: IndicatorStyle.dot,
  //         // addRepaintBoundaries: false,
  //         // addAutomaticKeepAlives: false,
  //         // addSemanticIndexes: false,
  //       ),
  //       scrollDirection: Axis.horizontal,
  //       // theme: TimelineTheme.of(context).copyWith(
  //       //   nodePosition: 0,
  //       // ),
  //       shrinkWrap: false,
  //     ),
  //   );
  // }

  // getStepperInitialValue() {
  //   List<StepperData> stepper = [];
  //   trackerList.map((e) {
  //     stepper.add(StepperData(
  //       title: DateFormat('dd MMM').format(DateTime.parse(e.date!)),
  //       subtitle: DateFormat('hh:mm a').format(DateTime.parse(e.date!)),
  //     ));
  //   }).toList();
  //   return stepper;
  // }

  // getIcons() {
  //   // print("activeStep==> $activeStep  trackerList.length => ${trackerList.length}");
  //   List<Widget> widgets = [];
  //   for (var i = 0; i < trackerList.length; i++) {
  //     // print('-i----$i');
  //     // print(trackerList[i].srStatus != '7');
  //     if (i == 0 && trackerList[i].srStatus != '7') {
  //       widgets.add(Container(
  //           padding: const EdgeInsets.all(2),
  //           decoration: const BoxDecoration(
  //               color: gPrimaryColor,
  //               borderRadius: BorderRadius.all(Radius.circular(20))),
  //           child: Icon(
  //             Icons.radio_button_checked_sharp,
  //             color: Colors.white,
  //             size: 15.sp,
  //           )
  //           // (!trackerList.every((element) => element.srStatus!.contains('7')) && trackerList.length-1) ? Icon(Icons.radio_button_checked_sharp, color: Colors.white, size: 15.sp,) : Icon(Icons.check, color: Colors.white, size: 15.sp,),
  //           ));
  //     } else {
  //       widgets.add(Container(
  //           padding: const EdgeInsets.all(2),
  //           decoration: const BoxDecoration(
  //               color: gPrimaryColor,
  //               borderRadius: BorderRadius.all(Radius.circular(20))),
  //           child: Icon(
  //             Icons.check,
  //             color: Colors.white,
  //             size: 15.sp,
  //           )
  //           // (!trackerList.every((element) => element.srStatus!.contains('7')) && trackerList.length-1) ? Icon(Icons.radio_button_checked_sharp, color: Colors.white, size: 15.sp,) : Icon(Icons.check, color: Colors.white, size: 15.sp,),
  //           ));
  //     }
  //   }
  //   return widgets;
  // }
}
