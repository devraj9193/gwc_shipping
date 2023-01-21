import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/utils/gwc_apis.dart';

import '../../model/error_model.dart';
import '../../model/ship_track_model/shipping_track_model.dart';
import '../../model/ship_track_model/shiprocket_auth_model/shiprocket_auth_model.dart';

class ApiClient {
  ApiClient({
    required this.httpClient,
  }) : assert(httpClient != null);

  final http.Client httpClient;

  Future serverShippingTrackerApi(String awbNumber) async {
    print(awbNumber);
    final String path = '${GwcApi.shippingTrackingApiUrl}/14326390038775';
    dynamic result;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var shipRocketToken = preferences.getString("ship_rocket_token")!;

    Map<String, String> shipRocketHeader = {
      "Authorization": "Bearer $shipRocketToken",
      "Content-Type": "application/json"
    };

    print('shiptoken: $shipRocketToken');
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
      } else {
        final res = jsonDecode(response.body);
        result = ShippingTrackModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }

    return result;
  }

  Future getShippingTokenApi(String email, String password) async{
    final path = GwcApi.shipRocketLoginApiUrl;

    Map bodyParam =  {
      "email": email,
      "password": password
    };

    dynamic result;

    try{
      final response = await httpClient.post(Uri.parse(path),
          body: bodyParam
      ).timeout(Duration(seconds: 45));

      if(response.statusCode != 200){
        result = ErrorModel.fromJson(jsonDecode(response.body));
      }
      else{
        result = ShipRocketTokenModel.fromJson(jsonDecode(response.body));
    //    storeShipRocketToken(result);
      }
    }
    catch(e){
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

}
