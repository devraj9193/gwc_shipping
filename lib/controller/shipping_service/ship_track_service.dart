import '../shipping_repository/ship_track_repo.dart';

class ShipTrackService {
  final ShipTrackRepository repository;

  ShipTrackService({required this.repository});

  Future getShipRocketTokenService(String email, String password) async {
    return await repository.getShiprockeTokenRepo(email, password);
  }

  Future getUserProfileService(String awbNumber) async {
    return await repository.getTrackingDetailsRepo(awbNumber);
  }

  // Future getShoppingDetailsListService() async {
  //   return await repository.getShoppingDetailsListRepo();
  // }
  //
  // Future sendSippingApproveStatusService(String approveStatus) async {
  //   return await repository.sendSippingApproveStatusRepo(approveStatus);
  // }
}
