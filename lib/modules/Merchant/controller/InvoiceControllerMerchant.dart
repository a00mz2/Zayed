// ignore_for_file: unnecessary_overrides, avoid_print, invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';

class InvoiceControllerMerchant extends GetxController {
  //==================== Status ====================
  Rx<StatusRequest> statusRequest = StatusRequest.loading.obs;
  Rx<StatusRequest> statusRequestPagination = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;

  //==================== Data Layer =================
  MerchantData data = MerchantData(Get.find());

  //==================== Pagination ======================
  int page = 1;

  late ScrollController scrollController;

  //==================== Controllers =================

  late TextEditingController searchController;

  //==================== Products ======================
  var listInvoice = [].obs;
  RxnInt totalInvoice = RxnInt();
  //==================== Debounce ======================
  Timer? debounce;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;

  //==================== Lifecycle ======================
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    searchController = TextEditingController();
    getInvoice();
  }

  @override
  void onClose() {
    debounce?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (isLoadingMore.value || !hasMore.value) return;

    final position = scrollController.position;

    // ✅ فقط عند نهاية التمرير (user stopped) + وصل فعليًا للنهاية
    if (position.atEdge && position.pixels == position.maxScrollExtent) {
      loadMore();
    }
  }

  //================== UI Helpers ===================
  search() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      getInvoice();
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) return;
    if (!hasMore.value) return;

    isLoadingMore.value = true;
    try {
      page += 1;
      statusRequestPagination.value = StatusRequest.loading;
      await getInvoice(append: true);
      print(
        "LOAD MORE => page=$page, loading=${isLoadingMore.value}, hasMore=${hasMore.value}",
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  //=================== API =====================

  getInvoice({bool append = false}) async {
    if (append) {
      statusRequestPagination.value = StatusRequest.loading;
    } else {
      page = 1;
      hasMore.value = true;
      statusRequest.value = StatusRequest.loading;
    }

    var response = await data.getInvoice(
      search: searchController.text.toString(),
      page: append ? page : 1,
    );
    print(response);
    if (handlingData(response) == StatusRequest.success) {
      List items = (response['data']['data'] ?? []) as List;
      totalInvoice.value = response['data']['total'];
      if (append) {
        listInvoice.addAll(items);
        if (items.isEmpty) {
          hasMore.value = false;
        }
      } else {
        listInvoice.value = items;
      }
    } else {
      AppSnackBar.error(response['message'] ?? "خطاء في الاتصال بالخادم");
    }

    statusRequestPagination.value = StatusRequest.success;

    statusRequest.value = handlingData(response);
    statusCode.value = handlingStatusCode(response);
  }
}
