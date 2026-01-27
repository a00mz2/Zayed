// ignore_for_file: unnecessary_overrides, use_build_context_synchronously, avoid_print, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Agent/Controller/HomeControllerAgent.dart';
import 'package:zayed/modules/Agent/Data/AgentData.dart';
import 'package:zayed/modules/Agent/View/widget/WithdrawalWidget/WithdrawalOtpForm.dart';
import 'package:zayed/modules/Agent/View/widget/WithdrawalWidget/WithdrawalSuccessForm.dart';

class WithdrawalControllerAgent extends GetxController
    with WidgetsBindingObserver {
  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  RxInt statusCode = 200.obs;
  AgentData data = AgentData(Get.find());
  HomeControllerAgent homeControllerAgent = Get.find<HomeControllerAgent>();

  @override
  void onInit() {
    super.onInit();
    qrController = MobileScannerController();
    codWithdrawalController = TextEditingController();
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
  late TextEditingController codWithdrawalController;

  // =====================var=====================

  RxDouble lastKeyboardHeight = 100.0.obs;
  final isFlashOn = false.obs;
  RxBool isProcessingQr = false.obs;

  //===================Data=======================

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

  //======================API=====================
  submitCode(
    String code,
    BuildContext context, {
    bool isValidate = false,
    bool fromQr = false, // ⭐ جديد
  }) async {
    if (isValidate) {
      if (formstate.value.currentState!.validate()) {
      } else {
        return;
      }
    }

    statusRequest.value = StatusRequest.loading;
    try {
      final response = await data.submitCode(code);

      if (handlingData(response) == StatusRequest.success) {
        if (isValidate) Get.back();
        AppSnackBar.success(response['message']);

        showBottomSlideSheet(
          context,
          WithdrawalOtpForm(
            balance: response['data']['balance'],
            code: code,
            name: response['data']['name'],
            phoneNumber: response['data']['phone'],
            avatarUrl: response['data']['avatarUrl'],
          ),
          height: Get.size.height - 80,
        );
      } else {
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

  void confirmCode(code, otp) async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.confirmCode(code, otp);
    if (handlingData(response) == StatusRequest.success) {
      Get.back();
      codWithdrawalController.text = "";
      homeControllerAgent.getDataWallet();

      showBottomSlideSheet(
        Get.context!,
        WithdrawalSuccessForm(balance: response['data']['amount']),
      );

      AppSnackBar.success(response['message']);
      statusRequest.value = handlingData(response);
    } else if (handlingData(response) == StatusRequest.offlineFailure) {
      AppSnackBar.error("لا يوجد اتصال بالشبكة");
      clearOtpField();
    } else {
      statusRequest.value = StatusRequest.success;
      AppSnackBar.error(response['message']);
      clearOtpField();
    }
    statusRequest.value = handlingData(response);
  }

  //=========================otp=========================
  var secondsRemaining = 30.obs;
  var enableResend = false.obs;
  Timer? timer;
  var otpCode = ''.obs;
  final OtpFieldController otpFieldController = OtpFieldController();
  void startTimer() {
    secondsRemaining.value = 30;
    enableResend.value = false;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        t.cancel();
      }
    });
  }

  //تفريغ حقول  otp
  void clearOtpField() {
    try {
      otpFieldController.clear();
    } catch (_) {}
    otpCode.value = '';
  }
}
