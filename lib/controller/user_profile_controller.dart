import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user_profile_model.dart';
import '../utils/gwc_apis.dart';

class UserProfileController extends GetxController {
  GetUserModel? getUserModel;
  final SharedPreferences _pref = GwcApi.preferences!;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<GetUserModel> fetchUserProfile() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    final response =
        await http.get(Uri.parse(GwcApi.getUserProfileApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    print("User Response: ${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      getUserModel = GetUserModel.fromJson(res);
      print(getUserModel!.data!.name);
      // _pref.setString(GwcApi.successMemberName, getUserModel?.data?.name ?? "");
      // _pref.setString(
      //     GwcApi.successMemberProfile, getUserModel?.data?.profile ?? "");
      // _pref.setString(
      //     GwcApi.successMemberAddress, getUserModel?.data?.phone ?? "");
      //
      // print("Success Name : ${_pref.getString(GwcApi.successMemberName)}");
      // print(
      //     "Success Profile : ${_pref.getString(GwcApi.successMemberProfile)}");
      // print(
      //     "Success Address : ${_pref.getString(GwcApi.successMemberAddress)}");
    } else {
      throw Exception();
    }
    return GetUserModel.fromJson(res);
  }
}
