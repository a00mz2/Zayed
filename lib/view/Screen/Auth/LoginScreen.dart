// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Screen/Auth/EnterPhoneScreen.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBox.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Image.asset(
            AppImage.backgrond1,
            width: double.infinity,
            fit: BoxFit.fill,
          ),

          SizedBox(height: 38),

          Center(
            child: Text(
              "تسجيل الدخول",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: MyFontWeight.semiBold,
                color: Color(0xff0E0E0E),
              ),
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Form(
                key: controller.formstateLogin.value,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "رقم الهاتف",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff5A5A5A),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
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

                    TextBoxs(
                      controller: controller.passLoginController,
                      obscureText: controller.obscureTextLogin.value,
                      showPassword: () => controller.showPassword(true),
                      hintText: "كلمة المرور",
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () => Get.toNamed(
                        '/EnterPhone',
                        arguments: {"type": "reset_password"},
                      ),
                      child: Text(
                        "نسيت كلمة المرور؟",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: MyFontWeight.semiBold,
                          color: Color(0xff0E0E0E),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => ButtonAppWidget(
                        statusRequest: controller.statusRequest.value,
                        onPressed: () => controller.login(context),
                        lable: "الدخول",
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
                "ليس لديك حساب؟",
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
                  if (Get.previousRoute == '/EnterPhone') {
                    print(1);
                    Get.to(
                      EnterPhoneScreen(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 400),
                    );
                  } else {
                    print(2);
                    Get.toNamed('/EnterPhone', arguments: {"type": "register"});
                  }
                },
                child: Text(
                  "إنشاء حساب جديد",
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
