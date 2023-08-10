
import '../../services/api_services.dart';

class LoginOtpRepository{
  ApiClient apiClient;

  LoginOtpRepository({required this.apiClient}) : assert(apiClient != null);

  Future loginWithOtpRepo(String phone, String otp, String deviceToken) async{
    return await apiClient.serverLoginWithOtpApi(phone, otp,deviceToken);
  }

  Future logoutRepo() async{
    return await apiClient.serverLogoutApi();
  }

}