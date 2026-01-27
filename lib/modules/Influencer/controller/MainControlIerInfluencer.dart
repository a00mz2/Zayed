import 'package:get/get.dart';

class MainControlIerInfluencer extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    if (index == 1) {
      // cartController.getCart();
    } else if (index == 2) {
      // walletController.getTransactions();
    } else if (index == 3) {
      // ordersController.getOrders();
    }
  }
}
