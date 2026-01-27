// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBox.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  final args = Get.arguments;

  RegisterScreen({super.key});

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
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      controller.statusRequest.value = StatusRequest.success;
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  type == 'register'
                      ? "الاسم و كلمة المرور"
                      : "تغيير كلمة المرور",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: MyFontWeight.semiBold,
                    color: Color(0xff0E0E0E),
                  ),
                ),
                SizedBox(height: 32),
                Obx(
                  () => Form(
                    key: controller.formstateRegister.value,
                    child: Column(
                      children: [
                        type == 'register'
                            ? TextBoxs(
                                controller: controller.nameController,
                                hintText: "اسم الحساب",
                              )
                            : SizedBox(),
                        SizedBox(height: 16),
                        TextBoxs(
                          controller: controller.passController,
                          obscureText: controller.obscureText1.value,
                          showPassword: () => controller.showPassword(true),
                          hintText: "كلمة المرور",
                        ),
                        SizedBox(height: 16),
                        TextBoxs(
                          obscureText: controller.obscureText2.value,
                          showPassword: () => controller.showPassword(false),
                          controller: controller.rePassController,
                          hintText: "تأكيد كلمة المرور",
                        ),
                        SizedBox(height: 16),
                        ButtonAppWidget(
                          statusRequest: controller.statusRequest.value,
                          onPressed: () async =>
                              controller.register(context, type),
                          lable: type == 'register'
                              ? "إنشاء الحساب"
                              : "تغيير كلمة المرور",
                          icon: Image.asset(AppIcons.checkmark, width: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
