import '../../services/api_services.dart';

class ShipRocketRepository{
  ApiClient apiClient;

  ShipRocketRepository({required this.apiClient});

  Future getShipRocketLoginRepo(String email, String password) async{
    return await apiClient.getShipRocketLoginApi(email, password);
  }

  Future getTrackingDetailsRepo(String awbNumber) async{
    return await apiClient.serverShippingTrackerApi(awbNumber);
  }

}