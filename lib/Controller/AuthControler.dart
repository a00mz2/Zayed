// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:zayed/Data/authData.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/functions/handlingData.dart';
import 'package:zayed/core/functions/showRightSideSheet.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/modules/Customer/Data/DataCustomer.dart';
import 'package:zayed/view/Widget/AuthWidget/EmailAddFormWidget.dart';
import 'package:zayed/view/Widget/AuthWidget/ImageAddFormWidget.dart';
import 'package:zayed/view/Widget/AuthWidget/ReferralCodeFormWidget.dart';

class AuthController extends GetxController {
  AuthData data = AuthData(Get.find());
  DataCustomer accountDataCustomer = DataCustomer(Get.find());

  Rx<StatusRequest> statusRequest = StatusRequest.success.obs;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController passController;
  late TextEditingController passLoginController;
  late TextEditingController rePassController;
  late TextEditingController emailController;

  var obscureText1 = true.obs;
  var obscureText2 = true.obs;
  var obscureTextLogin = true.obs;

  String phoneNumber = '';

  var formstate = GlobalKey<FormState>().obs;
  var formstateRegister = GlobalKey<FormState>().obs;
  var formstateLogin = GlobalKey<FormState>().obs;
  var formstateEmail = GlobalKey<FormState>().obs;

  Rxn<Uint8List> imageElmint = Rxn<Uint8List>();

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    nameController = TextEditingController();
    passController = TextEditingController();
    rePassController = TextEditingController();
    passLoginController = TextEditingController();
    emailController = TextEditingController();
  }

  showPassword(bool obscure) {
    if (Get.currentRoute == '/Login') {
      obscureTextLogin.value = !obscureTextLogin.value;
      return;
    }
    if (obscure) {
      obscureText1.value = !obscureText1.value;
    } else {
      obscureText2.value = !obscureText2.value;
    }
  }

  //=======================Api==========================
  login(BuildContext context) async {
    if (formstateLogin.value.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      var response = await data.login(
        phoneController.text,
        passLoginController.text,
      );
      if (handlingData(response) == StatusRequest.success) {
        AppSnackBar.success(response['message'] ?? "");
        saveData(response, context);
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.error("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message'] ?? "");
      }

      statusRequest.value = handlingData(response);
    } else {}
  }

  sendOtp(String type) async {
    if (formstate.value.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;
      var response = await data.sendOtp(phoneController.text, type);
      if (handlingData(response) == StatusRequest.success) {
        phoneNumber = phoneController.text;
        Get.toNamed('/Otp', arguments: {"type": type});
        startTimer();
        AppSnackBar.success(response['message'] ?? "");
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.error("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message'] ?? "");
      }
      statusRequest.value = handlingData(response);
    } else {}
  }

  void verifyCode(String type) async {
    statusRequest.value = StatusRequest.loading;
    var response = await data.verifyOtp(phoneNumber, type, otpCode.value);

    if (handlingData(response) == StatusRequest.success) {
      AppSnackBar.success(response['message']);
      statusRequest.value = handlingData(response);
      await Get.offNamed('/Register', arguments: {"type": type});
    } else if (handlingData(response) == StatusRequest.offlineFailure) {
      AppSnackBar.error("لا يوجد اتصال بالشبكة");
    } else {
      statusRequest.value = StatusRequest.success;
      AppSnackBar.error(response['message']);
      clearOtpField();
    }
    statusRequest.value = handlingData(response);
  }

  register(BuildContext context, String type) async {
    if (formstateRegister.value.currentState!.validate()) {
      if (passController.text != rePassController.text) {
        return AppSnackBar.error("كلمة المرور غير متطابقة");
      }
      statusRequest.value = StatusRequest.loading;

      var response = type == 'register'
          ? await data.register(
              phoneNumber,
              passController.text,
              nameController.text,
            )
          : await data.resetPassword(phoneNumber, passController.text);

      if (handlingData(response) == StatusRequest.success) {
        AppSnackBar.success(response['message'] ?? "");
        if (type == 'register') {
          await saveData(response, context);
        } else {
          Get.offAllNamed('/Login');
        }
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.error("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message'] ?? "");
      }
      statusRequest.value = handlingData(response);
    } else {}
  }

  saveData(response, BuildContext context) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(
      response['data']['token'],
    );
    myServices.sharedPreferences.setString('role', decodedToken['role']);
    myServices.sharedPreferences.setString('id', decodedToken['id']);
    myServices.sharedPreferences.setString('token', response['data']['token']);

    String? fcmToken = "noFcmToken";

    try {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? "noFcmToken";
    } catch (e) {
      print("خطأ في الحصول على رمز FCM: $e");
    }

    myServices.sharedPreferences.setString('FcmToken', fcmToken!);

    await data.notificationToken(fcmToken, decodedToken['role']);

    if (decodedToken['role'] == 'customer') {
      myServices.sharedPreferences.setString('route', '/customer/Main');

      statusRequest.value = StatusRequest.success;
      await showBottomSlideSheet(
        context,
        ImageAddFormWidget(),
        height: Get.size.height - 30,
      );
      statusRequest.value = StatusRequest.success;
      await showBottomSlideSheet(
        context,
        EmailAddFormWidget(),
        height: Get.size.height - 30,
      );
      statusRequest.value = StatusRequest.success;
      await showBottomSlideSheet(
        context,
        ReferralCodeFormWidget(),
        height: Get.size.height - 30,
      );

      Get.offAllNamed('/customer/Main');
    } else if (decodedToken['role'] == 'influencer') {
      myServices.sharedPreferences.setString('route', '/influencer/Main');
      Get.offAllNamed('/influencer/Main');
    } else if (decodedToken['role'] == 'agent') {
      myServices.sharedPreferences.setString('route', '/agent/Main');
      Get.offAllNamed('/agent/Main');
    } else if (decodedToken['role'] == 'merchant') {
      myServices.sharedPreferences.setString('route', '/merchant/Main');
      Get.offAllNamed('/merchant/Main');
    }
  }

  addImage(BuildContext context) async {
    statusRequest.value = StatusRequest.loading;
    if (imageElmint.value == null) return AppSnackBar.warning("يجب اظافة صورة");

    var response = await accountDataCustomer.updateDataAccount(
      customerAvatar: imageElmint.value,
    );
    if (handlingData(response) == StatusRequest.success) {
      Get.back();
      AppSnackBar.success("تم اضافة صورتك بنجاح");
    } else if (handlingData(response) == StatusRequest.offlineFailure) {
      AppSnackBar.error("لا يوجد اتصال بالشبكة");
    } else {
      AppSnackBar.error(response['message'] ?? "حدث خطاء ما ");
    }
    statusRequest.value = handlingData(response);
  }

  addEmail(BuildContext context) async {
    if (formstateEmail.value.currentState!.validate()) {
      statusRequest.value = StatusRequest.loading;

      var response = await accountDataCustomer.updateDataAccount(
        email: emailController.text,
      );

      if (handlingData(response) == StatusRequest.success) {
        Get.back();
        AppSnackBar.success("تم اضافة البريد بنجاح");
      } else if (handlingData(response) == StatusRequest.offlineFailure) {
        AppSnackBar.error("لا يوجد اتصال بالشبكة");
      } else {
        AppSnackBar.error(response['message'] ?? "حدث خطاء ما ");
      }
      statusRequest.value = handlingData(response);
    } else {}
  }

  test(BuildContext context) async {
    await showBottomSlideSheet(
      context,
      ReferralCodeFormWidget(),
      height: Get.size.height - 30,
    );
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

  void resendCode() async {
    if (enableResend.value) {
      var response = await data.sendOtp(phoneController.text, 'register');
      startTimer();
      clearOtpField();
      Get.snackbar(
        response['message'] ?? "إعادة الإرسال",
        "تم إرسال الكود مجددًا ✅",
      );
    }
  }

  //تفريغ حقول  otp
  void clearOtpField() {
    try {
      otpFieldController.clear();
    } catch (_) {}
    otpCode.value = '';
  }
}
