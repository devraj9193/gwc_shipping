import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/gwc_apis.dart';
import '../widgets/widgets.dart';

class ShipRocketLoginController extends GetxController {
  shipRocketLogin() async {
    try {
      Map<String, dynamic> dataBody = {
        "email": GwcApi.shipRocketEmail,
        "password": GwcApi.shipRocketPassword,
      };
      var response = await http.post(
        Uri.parse(GwcApi.shipRocketLoginApiUrl),
        body: dataBody,
        headers: {
          "Content_Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
     //   print(response.body);
        saveData(responseData["token"]);
        if (responseData['status'] == 200) {
          buildSnackBar("Login", "Successful");
        } else if (responseData['status'] == 401) {
          buildSnackBar("Login Failed", responseData['message']);
        }
      } else {
        buildSnackBar("Login Failed", "API Problem");
      }
    } catch (e) {
      throw Exception();
    }
  }

  saveData(String shipRocketToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ship_rocket_token", shipRocketToken);
  }
}
