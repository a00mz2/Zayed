// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 16),
            Image.asset(
              AppImage.logo,
              color: Color(0xffCE0070),
              width: 40,
              height: 52,
            ),
            SizedBox(height: 35),
            Image.asset(AppImage.GetStartImage, width: 300.16, height: 250),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "الخصومات",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
                SizedBox(width: 8),
                Image.asset(AppIcons.arrow, width: 40, height: 11),
                SizedBox(width: 8),
                Text(
                  "كاش",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Center(
              child: Text(
                "وفر من المتاجر و حول خصوماتك إلى رصيد زايد بجيبك",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: MyFontWeight.regular,
                  color: Color(0xff0E0E0E),
                ),
              ),
            ),

            SizedBox(height: 35),
            ButtonAppWidget(
              lable: "إنشاء حساب جديد",
              onPressed: () => Get.offNamed("/EnterPhone"),
            ),
            SizedBox(height: 8),
            ButtonAppWidget(
              primaryButton: false,
              color: Color(0xffD5D5D5),
              lable: "تسجيل الدخول",
              onPressed: () => Get.offNamed("/Login"),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
