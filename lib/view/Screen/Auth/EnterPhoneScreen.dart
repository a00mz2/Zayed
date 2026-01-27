// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBox.dart';

class EnterPhoneScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  EnterPhoneScreen({super.key});

  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String type = args != null ? args['type'] : 'register';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Image.asset(
            AppImage.backgrond1,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 70),
          Center(
            child: Column(
              children: [
                Text(
                  type == 'register'
                      ? "إنشاء حساب جديد"
                      : "استعادة كلمة المرور",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
                SizedBox(height: 10),
                type == 'register'
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          textAlign: TextAlign.center,
                          "ادخل رقم هاتفك المسجل وسنرسل لك رمز التحقق لاستعادة كلمة المرور",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 12,
                                fontWeight: MyFontWeight.regular,
                                color: Color(0xff5A5A5A),
                              ),
                        ),
                      ),
              ],
            ),
          ),

          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Form(
                key: controller.formstate.value,
                child: Column(
                  children: [
                    TextBoxs(
                      controller: controller.phoneController,
                      typeVal: "phone",
                      maxLength: 11,
                      maxLines: 11,
                      minLength: 11,
                      type: TextInputType.number,
                      hintText: "رقم هاتف واتساب",
                      suffixIcon: Text(
                        "العراق (+964)",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff747474),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => ButtonAppWidget(
                        statusRequest: controller.statusRequest.value,
                        onPressed: () => controller.sendOtp(type),
                        lable: "إرسال رمز التحقق",
                        icon: Image.asset(AppIcons.whatsAppIcon, width: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type == 'register' ? "لديك حساب بالفعل؟" : "تذكرت كلمة المرور؟",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: MyFontWeight.regular,
                  color: Color(0xff5A5A5A),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
                  print(Get.previousRoute);
                  if (Get.previousRoute == '/Login') {
                    print(1);
                    Get.back();
                  } else {
                    print(2);
                    Get.toNamed('/Login');
                  }
                },

                child: Text(
                  "تسجيل الدخول",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: MyFontWeight.semiBold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
