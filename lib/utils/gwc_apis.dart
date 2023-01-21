import 'constants.dart';

class GwcApi {
  static String shipRocketLoginApiUrl =
      "https://apiv2.shiprocket.in/v1/external/auth/login";

  static String shippingTrackingApiUrl =
      "https://apiv2.shiprocket.in/v1/external/courier/track/awb";

  static String loginApiUrl = "$baseUrl/api/login";

  static String pendingUserListApiUrl =
      "$baseUrl/api/getshippingData/shipping_customer_list";

  static String userOrderDetailsApiUrl =
      "$baseUrl/api/getshippingData/customer_order_details";

  static String shippingUpdateStatus =
      "$baseUrl/api/shippingUpdateData/update_status";

  static String notificationListUrl = "$baseUrl/api/getData/notification_list";

  static String shipRocketEmail = "disoltech22@gmail.com";
  static String shipRocketPassword = "adithya7224";
}
