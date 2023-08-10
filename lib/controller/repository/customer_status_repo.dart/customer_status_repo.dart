import '../../services/api_services.dart';

class CustomerStatusRepo {
  ApiClient apiClient;

  CustomerStatusRepo({required this.apiClient}) : assert(apiClient != null);

  Future getShipmentListRepo() async{
    return await apiClient.getShipmentListApi();
  }

  Future getShoppingItemRepo(String userId) async{
    return await apiClient.getShoppingItemApi(userId);
  }
}