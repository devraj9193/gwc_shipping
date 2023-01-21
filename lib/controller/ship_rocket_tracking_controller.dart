import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/ship_tracking_model.dart';
import '../utils/gwc_apis.dart';

class ShipRocketTrackingController extends GetxController {
  ShipTrackingModel? shipTrackingModel;

  @override
  void onInit() {
    super.onInit();
    fetchTrackingDetails();
  }

  // String awb1 = '14326322712402';
  // String awb2 = '14326322712380';
  // String awb3 = '14326322704046';


  Future<ShipTrackingModel> fetchTrackingDetails() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var shipRocketToken = preferences.getString("ship_rocket_token");

    var response = await http.get(
      Uri.parse("${GwcApi.shippingTrackingApiUrl}/14326390038775"),
      headers: {
        "Content_Type": "application/json",
        'Authorization': 'Bearer $shipRocketToken',
      },
    );
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      shipTrackingModel = ShipTrackingModel.fromJson(res);
      print("Result: ${shipTrackingModel?.trackingData?.shipmentStatus}");
    } else {}
    return ShipTrackingModel.fromJson(res);
  }
}
