import 'package:get/get.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/Data/authData.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/modules/Merchant/controller/AllProductControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/HomeControllerMerchant.dart';
import 'package:zayed/modules/Merchant/controller/InvoiceControllerMerchant.dart';

class MainControllerMerchant extends GetxController {
  final currentIndex = 0.obs;

  AuthData authData = AuthData(Get.find());

  void changeTab(int index) {
    currentIndex.value = index;

    if (index == 0) {
      try {
        var homeControllerMerchant = Get.find<HomeControllerMerchant>();
        homeControllerMerchant.getDataHome();
      } catch (e) {}
    } else if (index == 1) {
      var invoiceControllerMerchant = Get.find<InvoiceControllerMerchant>();

      invoiceControllerMerchant.getInvoice();
    } else if (index == 3) {
      try {
        var allProductControllerMerchant =
            Get.find<AllProductControllerMerchant>();
        allProductControllerMerchant.getProduct();
      } catch (e) {}
    }
  }

  getNnreadCountNotifications() async {
    var response = await authData.getNotifications();
    if (handlingData(response) == StatusRequest.success) {
      unreadCount.value = response['data']['unreadCount'] ?? 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNnreadCountNotifications();
  }
}
