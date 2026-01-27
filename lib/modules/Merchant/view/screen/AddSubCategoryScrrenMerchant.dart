import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Merchant/controller/SubCategoryControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ImageInput.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class AddSubCategoryScrrenMerchant extends StatelessWidget {
  AddSubCategoryScrrenMerchant({super.key});

  final controller = Get.find<SubCategoryControllerMerchant>();

  final int? index = Get.arguments != null
      ? Get.arguments['index'] as int
      : null;

  @override
  Widget build(BuildContext context) {
    controller.imageCategorie.value = null;
    if (index != null) {
      controller.nameController.text =
          controller.listSubCategories[index!]['name'];
      controller.sortOrderController.text = controller
          .listSubCategories[index!]['sortOrder']
          .toString();
      controller.isActiveAdd.value =
          controller.listSubCategories[index!]['isActive'];
    } else {
      controller.nameController.text = "";
      controller.sortOrderController.text = "";
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
          index != null ? "تعديل القسم" : "اظافة قسم فرعي",
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
              "صورة القسم الفرعي",
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
                    ? controller.listSubCategories[index!]['imageUrl']
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
                  "معلومات القسم الفرعي",
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
              hintText: "عنوان القسم الفرعي",
            ),
            SizedBox(height: 15),
            TextBoxDark(
              isrequired: false,
              type: TextInputType.number,
              controller: controller.sortOrderController,
              hintText: "التسلسل",
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
                    ? controller.createSubCategories()
                    : controller.updateCategories(
                        controller.listSubCategories[index!]["_id"],
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
