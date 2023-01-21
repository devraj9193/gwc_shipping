import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/pending_list_model.dart';
import '../utils/gwc_apis.dart';

class PendingUserListController extends GetxController {
  PendingUserList? pendingUserList;

  @override
  void onInit() {
    super.onInit();
    getPendingUserListData();
    getPausedUserListData();
    getPackedUserListData();
    //getApprovedUserListData();
  }

  Future<List<Pending>?> getPendingUserListData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    final response =
        await http.get(Uri.parse(GwcApi.pendingUserListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      PendingUserList jsonData = pendingUserListFromJson(response.body);
      List<Pending>? arrData = jsonData.data?.pending;
      print("status: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }

  Future<List<Pending>?> getPausedUserListData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token")!;

      final response =
          await http.get(Uri.parse(GwcApi.pendingUserListApiUrl), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        PendingUserList jsonData = pendingUserListFromJson(response.body);
        List<Pending>? arrData = jsonData.data?.paused;
        return arrData;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<Approved>?> getPackedUserListData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token")!;

      final response =
          await http.get(Uri.parse(GwcApi.pendingUserListApiUrl), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        PendingUserList jsonData = pendingUserListFromJson(response.body);
        List<Approved>? arrData = jsonData.data?.packed;
        return arrData;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  // Future<List<Approved>?> getApprovedUserListData() async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     var token = preferences.getString("token")!;
  //
  //     final response =
  //         await http.get(Uri.parse(GwcApi.pendingUserListApiUrl), headers: {
  //       'Authorization': 'Bearer $token',
  //     });
  //     if (response.statusCode == 200) {
  //       PendingUserList jsonData = pendingUserListFromJson(response.body);
  //       List<Approved>? arrData = jsonData.data?.approved;
  //       return arrData;
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     throw Exception();
  //   }
  // }
}
