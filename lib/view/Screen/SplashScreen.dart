// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/SplashController.dart';
import 'package:zayed/core/constant/assets/images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    // تفعيل وضع ملء الشاشة الفعلي (يمتد خلف النظام)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // // جعل الشريطين شفافين تمامًا
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true, // ✅ لتغطية المساحة خلف الشريط العلوي
      backgroundColor: const Color(0xffCE0070),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.2, end: 1.0),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Image.asset(AppImage.logo, width: 94.68, height: 125.33),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
