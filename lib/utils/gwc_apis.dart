import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class GwcApi {
  static String shipRocketLoginApiUrl =
      "https://apiv2.shiprocket.in/v1/external/auth/login";

  static String shippingTrackingApiUrl =
      "https://apiv2.shiprocket.in/v1/external/courier/track/awb";

  static String loginApiUrl = "$baseUrl/api/login";

  static String logoutApiUrl = "$baseUrl/api/logout";

  static String pendingUserListApiUrl =
      "$baseUrl/api/getshippingData/shipping_customer_list";

  static String userOrderDetailsApiUrl =
      "$baseUrl/api/getshippingData/customer_order_details";

  static String shippingUpdateStatus =
      "$baseUrl/api/shippingUpdateData/update_status";

  static String notificationListUrl = "$baseUrl/api/getData/notification_list";

  static String getUserProfileApiUrl = "$baseUrl/api/user";

  static String oopsMessage = "OOps ! Something went wrong.";
  static const String isLogin = "login";

  static String shipRocketEmail = "disoltech22@gmail.com";
  static String shipRocketPassword = "adithya7224";

  static String uvDeskAccessToken = "HBTCAEHAAAOTTVECVMNJGLWYVXVN3GBJUR0XVZNOJTO4N1Y4LD7LT3LE4PVONODF";

  static SharedPreferences? preferences;
  static Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  showSnackBar(BuildContext context, String message,{int? duration, bool? isError, SnackBarAction? action, double? bottomPadding}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:(isError == null || isError == false) ? gPrimaryColor : gSecondaryColor.withOpacity(0.55),
        content: Text(message),
        margin: (bottomPadding != null) ? EdgeInsets.only(bottom: bottomPadding) : null,
        duration: Duration(seconds: duration ?? 3),
        action: action,
      ),
    );
  }
}
