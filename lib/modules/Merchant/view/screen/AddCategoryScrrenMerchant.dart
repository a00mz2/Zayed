import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/CategoryControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ImageInput.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class AddCategoryScrrenMerchant extends StatelessWidget {
  AddCategoryScrrenMerchant({super.key});

  final controller = Get.find<CategoryControllerMerchant>();

  final int? index = Get.arguments != null
      ? Get.arguments['index'] as int
      : null;

  @override
  Widget build(BuildContext context) {
    controller.imageCategorie.value = null;
    if (index != null) {
      controller.nameController.text =
          controller.listCategories[index!]['name'];
      controller.descriptionController.text =
          controller.listCategories[index!]['description'];
      controller.isActiveAdd.value =
          controller.listCategories[index!]['isActive'];
    } else {
      controller.nameController.text = "";
      controller.descriptionController.text = "";
      controller.isActiveAdd.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(AppIcons.arrowBack, width: 20, height: 20),
          ),
        ),
        centerTitle: true,
        title: Text(
          index != null ? "تعديل القسم" : "اظافة قسم رئيسي",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Color(0xff0E0E0E),
            fontSize: 17,
            fontWeight: MyFontWeight.semiBold,
          ),
        ),
      ),

      body: Form(
        key: controller.formstate.value,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 25),
            Text(
              "صورة القسم",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff51515A),
                fontSize: 13,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            SizedBox(height: 5),
            Obx(
              () => ImageInput(
                pathImage: index != null
                    ? controller.listCategories[index!]['imageUrl']
                    : null,
                image: controller.imageCategorie.value,
                onImagePicked: (Uint8List newImage) {
                  controller.imageCategorie.value = newImage;
                },
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Image.asset(
                  AppIcons.section,
                  width: 20,
                  height: 20,
                  color: Color(0xffCE0070),
                ),
                SizedBox(width: 5),
                Text(
                  "معلومات القسم",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff51515A),
                    fontSize: 13,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            TextBoxDark(
              controller: controller.nameController,
              hintText: "عنوان القسم",
            ),
            SizedBox(height: 15),

            Text(
              "الوصف",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff51515A),
                fontSize: 13,
                fontWeight: MyFontWeight.semiBold,
              ),
            ),
            SizedBox(height: 5),
            TextBoxDark(
              controller: controller.descriptionController,
              hintText: "ادخل وصف تفصيلي للقسم",
              maxLines: 4,
              minLines: 4,
            ),

            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffF3F3F5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تفعيل القسم",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Color(0xff51515A),
                                fontSize: 14,
                                fontWeight: MyFontWeight.medium,
                              ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "عند تعطيل القسم سيتم الغاء تنشيط جميع المنتجات التابعة له",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Color(0xff6E615E),
                                fontSize: 12,
                                fontWeight: MyFontWeight.light,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Transform.scale(
                    scale: 0.89, // صغّر / كبّر
                    child: Obx(
                      () => Switch(
                        activeTrackColor: Color(0xffCE0070),
                        value: controller.isActiveAdd.value,
                        onChanged: (value) => controller.changedActiveAdd(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Obx(
              () => ButtonAppWidget(
                onPressed: () => index == null
                    ? controller.createCategories()
                    : controller.updateCategories(
                        controller.listCategories[index!]["_id"],
                      ),
                statusRequest: controller.statusRequestButtonAdd.value,
                lable: "حفظ",
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
