import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/screens/dashboard_screens/dashboard_screen.dart';
import 'package:shipping_app/widgets/widgets.dart';
import '../utils/gwc_apis.dart';

class ShippingStatusController extends GetxController {
  updateStatus(
    String status,
    String reason,
    String weight,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var userId = preferences.getInt("user_id");

      Map<String, dynamic> dataBody = {
        'status': status,
        'reason': reason,
        'weight': weight,
      };
      //   print(dataBody);
      var response = await http.post(
          Uri.parse("${GwcApi.shippingUpdateStatus}/$userId"),
          headers: {'Authorization': 'Bearer $token'},
          body: dataBody);
      print(dataBody);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(response.body);
        if (responseData['status'] == 200) {
          buildSnackBar("Shipping Status", "Successful");
          Get.to(const DashboardScreen());
        } else if (responseData['status'] == 401) {
          buildSnackBar("Shipping Status", responseData['message']);
        } else {
          buildSnackBar("Shipping Status", "API Problem");
        }
      }
    } catch (e) {
      throw Exception();
    }
  }
}
