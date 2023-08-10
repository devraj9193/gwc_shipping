import 'package:flutter/material.dart';

import '../../repository/login_repo/login_otp_repository.dart';

class LoginWithOtpService extends ChangeNotifier{
  late final LoginOtpRepository repository;

  LoginWithOtpService({required this.repository});

  Future loginWithOtpService(String phone, String otp,String deviceToken) async{
    return await repository.loginWithOtpRepo(phone, otp,deviceToken);
  }

  Future logoutService() async{
    return await repository.logoutRepo();
  }
}