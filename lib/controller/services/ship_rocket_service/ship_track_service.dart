
import '../../repository/ship_rocket_repository/ship_track_repo.dart';

class ShipRocketService{
  final ShipRocketRepository shipRocketRepository;

  ShipRocketService({required this.shipRocketRepository});

  Future getShipRocketTokenService(String email, String password) async{
    return await shipRocketRepository.getShipRocketLoginRepo(email, password);
  }

  Future getShipRocketTrackingService(String awbNumber) async{
    return await shipRocketRepository.getTrackingDetailsRepo(awbNumber);
  }

}