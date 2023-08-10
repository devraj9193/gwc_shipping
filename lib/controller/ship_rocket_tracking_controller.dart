import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/shiprocket_auth_model/ship_tracking_model.dart';
import '../utils/gwc_apis.dart';

class ShipRocketTrackingController extends GetxController {
  ShipTrackingModel? shipTrackingModel;

  @override
  void onInit() {
    super.onInit();
    fetchTrackingDetails;
  }

  // String awb1 = '14326322712402';
  // String awb2 = '14326322712380';
  // String awb3 = '14326322704046';


  Future<ShipTrackingModel> fetchTrackingDetails(String awbNumber) async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var shipRocketToken = preferences.getString("ship_rocket_token");
    // 14326390038775
    var response = await http.get(
      Uri.parse("${GwcApi.shippingTrackingApiUrl}/$awbNumber"),
      headers: {
        "Content_Type": "application/json",
        'Authorization': 'Bearer $shipRocketToken',
      },
    );
    print("awbNumber : $awbNumber");
    print("tracking url : ${"${GwcApi.shippingTrackingApiUrl}/$awbNumber"}");
    print("tracking response body : ${response.body}");

    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      shipTrackingModel = ShipTrackingModel.fromJson(res);
      print("Result: ${shipTrackingModel?.trackingData?.shipmentStatus}");
    } else {
      print("Error : ${Exception()}");
      throw Exception();
    }
    return ShipTrackingModel.fromJson(res);
  }
}
