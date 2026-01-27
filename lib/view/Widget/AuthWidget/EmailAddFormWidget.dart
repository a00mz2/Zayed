// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/textBox.dart';

class EmailAddFormWidget extends StatelessWidget {
  EmailAddFormWidget({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.close),
                Text(
                  "تخطي",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff0E0E0E),
                    fontSize: 14,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Image.asset(AppImage.hederAddEmail),
        SizedBox(height: 54),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              "اضف بريدك الإلكتروني وكن أول من يعرف",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff0E0E0E),
                fontSize: 20,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              "مزايا حصرية، عروض خاصة، وتنبيهات فورية — كل هذا يصلك على بريدك",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff5A5A5A),
                fontSize: 14,
                fontWeight: MyFontWeight.regular,
              ),
            ),
          ),
        ),
        SizedBox(height: 32),

        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Form(
                  key: controller.formstateEmail.value,
                  child: TextBoxs(
                    controller: controller.emailController,
                    typeVal: "email",
                    hintText: "البريد الإلكتروني",
                  ),
                ),
                SizedBox(height: 16),
                ButtonAppWidget(
                  statusRequest: controller.statusRequest.value,
                  onPressed: () => controller.addEmail(context),
                  lable: "اضافة",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
