import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';

class HomeControllerMerchant extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDataHome();
  }

  @override
  void onClose() {
    super.onClose();
  }

  MerchantData data = MerchantData(Get.find());

  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  RxInt statusCode = 200.obs;

  //=========================data====================
  var summary = {}.obs;
  var growthChart = [].obs;
  var latestInvoices = [].obs;
  var latestProducts = [].obs;
  var categories = [].obs;

  RxInt maxAmount = 0.obs;
  RxInt percent = 0.obs;

  //================api======================

  getDataHome() async {
    statusRequest.value = StatusRequest.loading;

    var response = await data.getDataHome();

    var responsegetProduct = await data.getProduct(categoryId: "");

    if (handlingData(response) == StatusRequest.success) {
      var responseData = response['data'];

      summary.value = responseData['summary'] ?? {};
      growthChart.value = responseData['growthChart'] ?? [];
      latestInvoices.value = responseData['latestInvoices'] ?? [];
      latestProducts.value = responseData['latestProducts'] ?? [];
      categories.value = responseData['categories'] ?? [];

      try {
        percent.value =
            responsegetProduct['data']['merchantDiscount']['percent'] ?? 0;
        maxAmount.value =
            responsegetProduct['data']['merchantDiscount']['maxAmount'] ?? 0;
      } catch (e) {}
    } else {
      AppSnackBar.error(response['message'] ?? "مشكلة في الاتصال بالخادم");
    }

    statusCode.value = handlingStatusCode(response);
    statusRequest.value = handlingData(response);
  }
}
