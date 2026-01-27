// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/ProfileControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ImageInputCircular.dart';
import 'package:zayed/modules/Merchant/view/Widget/AddDataAccountWidget/LocationPickerField.dart';
import 'package:zayed/view/Widget/widgetApp/MediaInput.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class AddDataAccountScrrenMerchant extends StatelessWidget {
  AddDataAccountScrrenMerchant({super.key});

  final controller = Get.find<ProfileControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    controller.cover.value = null;
    controller.logo.value = null;

    controller.setInitialLocationFromProfile();

    return Scaffold(
      body: Form(
        key: controller.formstate.value,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            SizedBox(
              height: 294,
              child: Stack(
                children: [
                  SizedBox(
                    height: 224,
                    child: Obx(
                      () => MediaInput(
                        urlPath: controller.profileData['coverUrl'],
                        localData: controller.cover.value,
                        type: controller.cover.value != null
                            ? controller.currentType.value
                            : (controller.profileData['coverType'] == "video"
                                  ? MediaType.video
                                  : MediaType.image),

                        onMediaPicked: (Uint8List data, MediaType type) {
                          controller.cover.value = data;
                          controller.currentType.value = type;
                          controller.cover.value = data;
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: (Get.size.width / 2) - 64.5,
                    child: Obx(
                      () => ImageInputCircular(
                        height: 128,
                        pathImage: controller.profileData['logoUrl'],
                        image: controller.logo.value,
                        onImagePicked: (Uint8List newImage) {
                          controller.logo.value = newImage;
                        },
                        buttonAdd: Positioned(
                          bottom: 0,
                          right: 15,
                          child: Image.asset(
                            AppIcons.camera,
                            width: 29,
                            height: 29,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: SafeArea(
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withAlpha(90),
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Image.asset(
                            AppIcons.arrowBack,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title("اسم المتجر"),
                  SizedBox(height: 3),
                  TextBoxDark(
                    hintText: "اسم المتجر",
                    controller: controller.storeNameController,
                  ),
                  SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: title("معلومات التواصل"),
                  ),

                  SizedBox(height: 3),
                  title("رقم الهاتف"),
                  SizedBox(height: 3),
                  TextBoxDark(
                    controller: controller.phoneController,
                    readOnly: true,
                    typeVal: "phone",
                    maxLength: 11,
                    maxLines: 11,
                    minLength: 11,
                    type: TextInputType.number,
                    hintText: "رقم الهاتف",
                    suffixIcon: Text(
                      "العراق (+964)",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        fontWeight: MyFontWeight.regular,
                        color: Color(0xff747474),
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  title("البريد الالكتروني"),
                  SizedBox(height: 3),
                  TextBoxDark(
                    typeVal: "email",
                    isrequired: false,
                    hintText: "البريد الالكتروني",
                    controller: controller.storeEmailController,
                  ),
                  SizedBox(height: 10),

                  title("العنوان"),
                  SizedBox(height: 3),
                  TextBoxDark(
                    hintText: "عنوان المتجر",
                    controller: controller.addressController,
                    maxLines: 4,
                    minLines: 4,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: LocationPickerField(),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: title("نبذة عن المتجر"),
                  ),
                  title("وصف المتجر"),
                  SizedBox(height: 3),
                  TextBoxDark(
                    controller: controller.descriptionController,
                    hintText: "وصف المتجر",
                    maxLines: 4,
                    minLines: 4,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ButtonAppWidget(
                            color: Color(0xffF4F4F5),
                            textColor: Color(0xff71717A),
                            primaryButton: false,
                            onPressed: () => Get.back(),
                            statusRequest:
                                controller.statusRequestButtonadd.value,
                            lable: "الغاء",
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Obx(
                            () => ButtonAppWidget(
                              onPressed: () => controller.updataProfile(),
                              statusRequest:
                                  controller.statusRequestButtonadd.value,
                              lable: "حفض التغييرات",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget title(lable) {
    return Text(
      lable,
      style: TextStyle(
        color: Color(0xff51515A),
        fontSize: 13,
        fontWeight: MyFontWeight.regular,
        fontFamily: "Somar Sans",
      ),
    );
  }
}
