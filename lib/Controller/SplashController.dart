// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zayed/core/services/notification_service.dart';
import 'package:zayed/core/services/services.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      final role = myServices.sharedPreferences.getString("role");
      final token = myServices.sharedPreferences.getString("token");

      if (token == null || token.isEmpty) {
        Get.offAllNamed('/GetStarted');
        return;
      }

      // 1. تحديد الصفحة الرئيسية بناءً على الدور
      String mainRoute = '';
      if (role == 'customer') {
        mainRoute = '/customer/Main';
      } else if (role == 'influencer') {
        mainRoute = '/influencer/Main';
      } else if (role == 'agent') {
        mainRoute = '/agent/Main';
      } else if (role == 'merchant') {
        mainRoute = '/merchant/Main';
      } else {
        Get.offAllNamed('/GetStarted');
        return;
      }

      // 2. التحقق: هل يوجد إشعار منتظر؟
      if (NotificationService.initialNotificationData != null) {
        print("🎯 التوجه للرئيسية ثم فتح الإشعارات فوقها");

        // تصفير بيانات الإشعار لمنع التكرار
        NotificationService.initialNotificationData = null;

        // أولاً: اذهب للرئيسية وامسح كل ما قبلها (الـ Splash)
        Get.offAllNamed(mainRoute);

        // ثانياً: افتح صفحة الإشعارات فوق الصفحة الرئيسية
        // نستخدم توقيت بسيط جداً للتأكد من استقرار الصفحة الأولى
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.toNamed('/Notifications');
        });
      } else {
        // التوجه الطبيعي إذا لم يكن هناك إشعار

        Get.offAllNamed(mainRoute);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
    );
  }
}
