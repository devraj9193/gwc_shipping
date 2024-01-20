import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/customer_order_details_model.dart';
import '../../model/error_model.dart';
import '../../model/login_model/login_model.dart';
import '../../model/login_model/logout_model.dart';
import '../../model/pending_list_model.dart';
import '../../model/send_shipping_model.dart';
import '../../model/shiprocket_auth_model/ship_tracking_model.dart';
import '../../model/shiprocket_auth_model/shiprocket_auth_model.dart';
import '../../model/user_profile_model.dart';
import '../../screens/dashboard_screens/dashboard_screen.dart';
import '../../utils/app_config.dart';
import '../../utils/gwc_apis.dart';
import '../../utils/shipping_member_storage.dart';
import '../../widgets/widgets.dart';

class ApiClient {
  ApiClient({
    required this.httpClient,
  });

  final http.Client httpClient;
  SharedPreferences? preferences;

  final _prefs = GwcApi.preferences;

  String getHeaderToken() {
    if (_prefs != null) {
      final token = _prefs!.getString("token");
      // AppConfig().tokenUser
      // .substring(2, AppConstant().tokenUser.length - 1);
      return "Bearer $token";
    } else {
      return "Bearer ${""}";
    }
  }

  serverLoginWithOtpApi(String phone, String otp, String deviceToken) async {
    var path = GwcApi.loginApiUrl;

    dynamic result;

    Map bodyParam = {
      'email': phone,
      'password': otp,
      'device_token': deviceToken
    };
    print("Login Details : $bodyParam");

    try {
      final response = await httpClient
          .post(Uri.parse(path), body: bodyParam)
          .timeout(const Duration(seconds: 45));

      print('serverLoginWithOtpApi Response header: $path');
      print('serverLoginWithOtpApi Response status: ${response.statusCode}');
      print('serverLoginWithOtpApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (res['status'] == 200) {
          result = loginFromJson(response.body);
        } else {
          result = ErrorModel.fromJson(res);
        }
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  serverLogoutApi() async {
    var path = GwcApi.logoutApiUrl;

    dynamic result;

    try {
      final response = await httpClient.post(
        Uri.parse(path),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": getHeaderToken(),
        },
      ).timeout(Duration(seconds: 45));

      print('serverLogoutApi Response header: $path');
      print('serverLogoutApi Response status: ${response.statusCode}');
      print('serverLogoutApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (res['status'] == 200) {
          result = LogoutModel.fromJson(res);
          // inMemoryStorage.cache.clear();
        } else {
          result = ErrorModel.fromJson(res);
        }
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  getShipmentListApi() async {
    String url = GwcApi.pendingUserListApiUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    dynamic result;
    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          'Authorization': "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        result = PendingUserList.fromJson(json);
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getShoppingItemApi(String userId) async {
    String url = "${GwcApi.userOrderDetailsApiUrl}/$userId";
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    dynamic result;
    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          'Authorization': "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShoppingItemApi Url: $url');
      print('getShoppingItemApi Response status: ${response.statusCode}');
      print('getShoppingItemApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        result = CustomerOrderDetails.fromJson(json);
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  sendShippingStatusApi(
    String status,
    String reason,
    String weight,
      String userId,
  ) async {
    final String path = "${GwcApi.shippingUpdateStatus}/$userId";

    Map<String, dynamic> bodyParam = {
      'status': status,
      'reason': reason,
      'weight': weight,
    };

    print(bodyParam);
    dynamic result;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    try {
      final response = await httpClient.post(
        Uri.parse(path),
        headers: {
          "Authorization": "Bearer $token",
        },
        body: bodyParam,
      );

      print('sendShippingStatusApi Response header: $path');
      print('sendShippingStatusApi Response status: ${response.statusCode}');
      print('sendShippingStatusApi Response body: ${response.body}');

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskSendReplyApi result: $json');
        result = SendShippingStatusModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(json);
      }
    } catch (e) {
      print("catch error: $e");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future getShippingMemberProfileApi(String accessToken) async {
    final path = GwcApi.getUserProfileApiUrl;
    var result;

    print("token: $accessToken");
    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(const Duration(seconds: 45));

      print(
          "getUserProfileApi response code:" + response.statusCode.toString());
      print("getUserProfileApi response body:" + response.body);

      final res = jsonDecode(response.body);
      print('${res['status'].runtimeType} ${res['status']}');
      if (res['status'].toString() == '200') {
        print("name : ${res['data']['name']}");
        result = GetUserModel.fromJson(res);
        preferences?.setString(ShippingMemberStorage.shippingMemberName,
            res['data']['name'] ?? '');
        preferences?.setString(ShippingMemberStorage.shippingMemberProfile,
            res['data']['profile'] ?? '');
        preferences?.setString(ShippingMemberStorage.shippingMemberAddress,
            res['data']['address'] ?? '');
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      print("getUserProfileApi catch error ${e}");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  // --- Ship Rocket --- //
  Future getShipRocketLoginApi(String email, String password) async {
    final path = GwcApi.shipRocketLoginApiUrl;

    Map bodyParam = {"email": email, "password": password};

    dynamic result;

    try {
      final response = await httpClient
          .post(Uri.parse(path), body: bodyParam)
          .timeout(Duration(seconds: 45));

      if (response.statusCode != 200) {
        result = ErrorModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ShipRocketTokenModel.fromJson(jsonDecode(response.body));
        storeShipRocketToken(result);
        print("ship rocket url : $path");
        print("ship rocket body : $bodyParam");
        print("ship rocket response : ${response.body}");
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future serverShippingTrackerApi(String awbNumber) async {
    print(awbNumber);
    final String path = '${GwcApi.shippingTrackingApiUrl}/$awbNumber';
    dynamic result;

    String shipToken = _prefs?.getString(AppConfig().shipRocketBearer) ?? '';

    Map<String, String> shipRocketHeader = {
      "Authorization": "Bearer $shipToken",
      "Content-Type": "application/json"
    };

    print('shiptoken: $shipToken');
    try {
      final response = await httpClient
          .get(
            Uri.parse(path),
            headers: shipRocketHeader,
          )
          .timeout(const Duration(seconds: 45));

      print('serverShippingTrackerApi Response header: $path');
      print('serverShippingTrackerApi Response status: ${response.statusCode}');
      print('serverShippingTrackerApi Response body: ${response.body}');

      if (response.statusCode != 200) {
        final res = jsonDecode(response.body);
        result = ErrorModel.fromJson(res);
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      } else {
        final res = jsonDecode(response.body);
        result = ShipTrackingModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }

    return result;
  }

  void storeShipRocketToken(ShipRocketTokenModel result) {
    _prefs!.setString(AppConfig().shipRocketBearer, result.token ?? '');
  }
}
