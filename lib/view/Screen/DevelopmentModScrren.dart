// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/core/services/services.dart';

class DevelopmentModScrren extends StatelessWidget {
  const DevelopmentModScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              AppLottie.DevelopmentMod,
              width: 150,
              height: 150,
            ),
            Text(
              "الصفحة قيد التطوير",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              "نعمل على تجهيزها لتقديم تجربة مميزة، قريباً ستكون جاهزة للاستخدام",
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                myServices.sharedPreferences.clear();
                Get.offAllNamed("/");
              },
              child: Text(
                "تسجيل خروج",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: MyFontWeight.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
