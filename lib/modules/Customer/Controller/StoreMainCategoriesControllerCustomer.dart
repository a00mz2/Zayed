import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';

class StoreMainCategoriesControllerCustomer extends GetxController {

final String storeId; 

 StoreMainCategoriesControllerCustomer({
   required this.storeId
 });
  
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;
}
