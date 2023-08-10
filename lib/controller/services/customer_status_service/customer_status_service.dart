import 'package:flutter/cupertino.dart';
import '../../repository/customer_status_repo.dart/customer_status_repo.dart';

class CustomerStatusService extends ChangeNotifier {
  late final CustomerStatusRepo customerStatusRepo;

  CustomerStatusService({required this.customerStatusRepo});

  Future getShipmentService() async {
    return await customerStatusRepo.getShipmentListRepo();
  }

  Future getShoppingItemService(String userId) async {
    return await customerStatusRepo.getShoppingItemRepo(userId);
  }

}
