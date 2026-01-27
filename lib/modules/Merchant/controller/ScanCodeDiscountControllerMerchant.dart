// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, avoid_print, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Merchant/Data/MerchantData.dart';
import 'package:zayed/modules/Merchant/view/Widget/ScanCodeDiscountWidget/CreateInvoiceForm.dart';
import 'package:zayed/modules/Merchant/view/Widget/ScanCodeDiscountWidget/EnterCodeManuallyFormMerchant.dart';
import 'package:zayed/modules/Merchant/view/screen/DetailsInvoiceScreenInMerchant.dart';

class ScanCodeDiscountControllerMerchant extends GetxController
    with WidgetsBindingObserver {
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;
  MerchantData data = MerchantData(Get.find());

  @override
  void onInit() {
    super.onInit();
    qrController = MobileScannerController();
    discountCodeController = TextEditingController();
    priceController = TextEditingController();
    priceAfterDiscountController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    qrController.stop();
    qrController.dispose();
  }

  // =====================Controller=====================
  late final MobileScannerController qrController;

  var formstate = GlobalKey<FormState>().obs;

  late TextEditingController discountCodeController;
  late TextEditingController priceController;
  late TextEditingController priceAfterDiscountController;

  // =====================var=====================

  RxDouble lastKeyboardHeight = 100.0.obs;
  final isFlashOn = false.obs;
  RxBool isProcessingQr = false.obs;

  //===================Data=======================

  int? discountPercent;
  int? discountMaxAmount;

  //=================Function====================

  Future<void> toggleFlash() async {
    try {
      if (isFlashOn.value) {
        await qrController.toggleTorch();
      } else {
        await qrController.toggleTorch();
      }
      isFlashOn.toggle();
    } catch (e) {
      print(e);
    }
  }

  Timer? debounce;
  calculatePrice() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      final text = priceController.text.trim();

      if (text.isEmpty) {
        priceAfterDiscountController.clear();
        return;
      }

      final price = int.tryParse(text);
      if (price == null) {
        priceAfterDiscountController.clear();
        return;
      }

      priceAfterDiscountController.text = calculatePriceAfterDiscount(
        price: price,
      ).toString();
    });
  }

  num calculatePriceAfterDiscount({required int price}) {
    num discountValue = price * (discountPercent! / 100);
    if (discountMaxAmount! > 0 && discountValue > discountMaxAmount!) {
      discountValue = discountMaxAmount!;
    }
    num finalPrice = price - discountValue;
    // حماية من القيم السالبة
    if (finalPrice < 0) finalPrice = 0;
    return finalPrice;
  }

  //======================API=====================
  verifyInvoice(
    String code,
    BuildContext context, {
    bool isValidate = false,
    bool fromQr = false,
  }) async {
    if (isValidate) {
      if (formstate.value.currentState!.validate()) {
      } else {
        return;
      }
    }

    statusRequest.value = StatusRequest.loading;

    try {
      if (isValidate) {
        Get.back();
      }

      final response = await data.verifyInvoice(code);

      if (handlingData(response) == StatusRequest.success) {
        discountCodeController.text = "";

        discountPercent = response['data']['discountPercent'];
        discountMaxAmount = response['data']['discountMaxAmount'];
        showBottomSlideSheet(Get.context, CreateInvoiceForm(code: code));
        AppSnackBar.success(response['message']);
      } else {
        if (isValidate) {
          showBottomSlideSheet(
            Get.context,
            EnterCodeManuallyFormMerchant(titleEror: response['message']),
          );
        }

        AppSnackBar.error(response['message']);
      }
    } catch (e) {
      AppSnackBar.error("حدث خطأ غير متوقع");
    } finally {
      statusRequest.value = StatusRequest.success;
      if (fromQr) {
        isProcessingQr.value = false;
        await qrController.start();
      }
    }
  }

  createInvoice(code) async {
    if (formstate.value.currentState!.validate()) {
      Get.back();
      statusRequest.value = StatusRequest.loading;
      var response = await data.createInvoice(code, priceController.text);

      if (handlingData(response) == StatusRequest.success) {
        priceController.text = "";
        priceAfterDiscountController.text = "";
        Get.to(DetailsInvoiceScreenInMerchant(data: response['data']));

        AppSnackBar.success(response['message']);
      } else {
        showBottomSlideSheet(
          Get.context,
          CreateInvoiceForm(code: code, title: response['message']),
        );
        AppSnackBar.error(response['message']);
      }

      statusRequest.value = StatusRequest.success;
    } else {}
  }
}
