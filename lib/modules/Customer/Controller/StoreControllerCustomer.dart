import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Customer/Data/MerchantDataCustomer.dart';

class StoreControllerCustomer extends GetxController {
  final String storeId;
  StoreControllerCustomer({required this.storeId});

  MerchantDataCustomer merchantData = MerchantDataCustomer(Get.find());

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  RxInt statusCode = 200.obs;

  var storeDetails = {}.obs;
  var categories = [].obs;
  var newlyArrived = [].obs;
  var bestSelling = [].obs;

  @override
  void onInit() {
    super.onInit();
    getStoreData();
  }

  getStoreData() async {
    statusRequest.value = StatusRequest.loading;
    
    // Fetch Store Details
    var responseDetails = await merchantData.getMerchantDetails(storeId);
    print("=======================");
    print(responseDetails);
    print("=======================");
    statusRequest.value = handlingData(responseDetails);
    if (statusRequest.value == StatusRequest.success) {
      storeDetails.value = responseDetails['data'] ?? {};
    }

    print(storeDetails);

    // Fetch Categories
    var responseCategories = await merchantData.getMerchantCategories(storeId);
    if (handlingData(responseCategories) == StatusRequest.success) {
      categories.value = responseCategories['data'] ?? [];
    }

    // Fetch Products (Newly Arrived)
    var responseProducts = await merchantData.getMerchantProducts(storeId);
    if (handlingData(responseProducts) == StatusRequest.success) {
      newlyArrived.value = responseProducts['data'] ?? [];
      bestSelling.value = responseProducts['data'] ?? []; // For now using same data or filter if possible
    }

    update();
  }
}
