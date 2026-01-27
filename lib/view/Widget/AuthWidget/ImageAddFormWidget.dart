// ignore_for_file: file_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ImageInputCircular.dart';

class ImageAddFormWidget extends StatelessWidget {
  ImageAddFormWidget({super.key});

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
        SizedBox(height: 42),
        Image.asset(AppImage.hederAddImage),
        SizedBox(height: 54),
        Center(
          child: Text(
            "تميز بين الجميع بصورة تعبر عنك",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color(0xff0E0E0E),
              fontSize: 20,
              fontWeight: MyFontWeight.semiBold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            "ارفع صورتك وابدأ رحلتك معنا بأسلوبك الخاص",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color(0xff5A5A5A),
              fontSize: 14,
              fontWeight: MyFontWeight.regular,
            ),
          ),
        ),
        SizedBox(height: 10),
        Obx(
          () => ImageInputCircular(
            pathImage: null,
            image: controller.imageElmint.value,
            onImagePicked: (Uint8List newImage) {
              controller.imageElmint.value = newImage;
            },
          ),
        ),
        SizedBox(height: 32),
        Obx(
          () => controller.imageElmint.value != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ButtonAppWidget(
                    statusRequest: controller.statusRequest.value,
                    onPressed: () => controller.addImage(context),
                    lable: "حفظ",
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
