import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constants.dart';

String statusText = "";

buildTapCount(String title, int count) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title),
      SizedBox(width: 1.w),
      count == 0
          ? const SizedBox()
          : Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: kNumberCircleRed,
          shape: BoxShape.circle,
        ),
        child: Text(
          count.toString(),
          style: TextStyle(
            fontSize: 8.sp,
            fontFamily: "GothamMedium",
            color: gWhiteColor,
          ),
        ),
      )
    ],
  );
}

String buildStatusText(String status) {
  if (status == "report_upload") {
    return "MR Upload";
  } else if (status == "check_user_reports") {
    return "Check User Reports";
  } else if (status == "meal_plan_completed") {
    return "Meal Plan Completed";
  } else if (status == "shipping_paused") {
    return "Shipment Paused";
  } else if (status == "shipping_packed") {
    return "Shipment Packed";
  } else if (status == "shipping_approved") {
    return "Shipment Approved";
  } else if (status == "shipping_delivered") {
    return "Shipment Delivered";
  } else if (status == "prep_meal_plan_completed") {
    return "Meal Plan Pending";
  }
  return statusText;
}


