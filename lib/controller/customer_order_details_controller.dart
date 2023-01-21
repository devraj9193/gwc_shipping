import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customer_order_details_model.dart';
import '../utils/gwc_apis.dart';

class CustomerOrderDetailsController extends GetxController {
  CustomerOrderDetails? customerOrderDetails;

  @override
  void onInit() {
    super.onInit();
    getOrderDetails();
  }

  Future<List<GetShoppingListElement>?> getOrderDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;
    var userId = preferences.getInt("user_id");

    final response = await http
        .get(Uri.parse("${GwcApi.userOrderDetailsApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      CustomerOrderDetails jsonData =
          customerOrderDetailsFromJson(response.body);
      List<GetShoppingListElement>? arrData =
          jsonData.data?.shippingProductList;
      return arrData;
    } else {
      print(response.body);
      throw Exception();
    }
  }
}
