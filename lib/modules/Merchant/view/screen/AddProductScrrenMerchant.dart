// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/core/constant/enum.dart';
import 'package:zayed/modules/Merchant/controller/ProductControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/MultiImageInputWEB.dart';
import 'package:zayed/view/Widget/widgetApp/textBoxDark.dart';

class AddProductScrrenMerchant extends StatelessWidget {
  AddProductScrrenMerchant({super.key});

  final controller = Get.find<ProductControllerMerchant>();

  final int? index = Get.arguments != null
      ? Get.arguments['index'] as int
      : null;

  @override
  Widget build(BuildContext context) {
    controller.images.clear();
    controller.deletedImages.clear();

    if (index != null) {
      for (var img in controller.listProduct[index!]['images']) {
        controller.images.add(img);
      }
      controller.nameController.text = controller.listProduct[index!]['name'];
      controller.priceController.text = controller.listProduct[index!]['price']
          .toString();
      controller.descriptionController.text =
          controller.listProduct[index!]['description'];
      controller.sortOrderController.text = controller
          .listProduct[index!]['sortOrder']
          .toString();
      controller.isActiveAdd.value = controller.listProduct[index!]['isActive'];
      controller.isNewArrival.value =
          controller.listProduct[index!]['isNewArrival'];
      controller.isBestSeller.value =
          controller.listProduct[index!]['isBestSeller'];
    } else {
      controller.images.clear();
      controller.deletedImages.clear();
      controller.nameController.text = "";
      controller.priceController.text = "";
      controller.descriptionController.text = "";
      controller.sortOrderController.text = "";
      controller.isActiveAdd.value = true;
      controller.isNewArrival.value = false;
      controller.isBestSeller.value = false;
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

        actions: [
          index != null
              ? controller.statusRequestdeleteProduct.value ==
                        StatusRequest.loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: Lottie.asset(AppLottie.deleteLoding),
                      )
                    : InkWell(
                        onTap: () => controller.deleteProduct(
                          controller.listProduct[index!]['_id'],
                        ),
                        child: Icon(Icons.delete, color: Colors.red, size: 28),
                      )
              : SizedBox.shrink(),

          SizedBox(width: 10),
        ],
      ),

      body: Form(
        key: controller.formstate.value,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            title("صور المنتج", height: 25),
            Obx(
              () => MultiImageInputMobile(
                images: controller.images.value,
                pathImage: "",
                onImagesChanged: (updatedList) {
                  controller.images.value = List.from(updatedList);
                },
                onImageDeleted: (deletedName, deletedId) {
                  if (deletedId != null && deletedId.isNotEmpty) {
                    controller.deletedImages.add(deletedId.toString());
                  }
                },
              ),
            ),

            title("اسم المنتج"),
            TextBoxDark(
              prefixIcon: Image.asset(
                AppIcons.packaging,
                width: 24,
                height: 24,
              ),
              controller: controller.nameController,
              hintText: "ادخل اسم المنتج",
            ),
            title("السعر"),
            TextBoxDark(
              prefixIcon: Image.asset(AppIcons.price, width: 24, height: 24),
              controller: controller.priceController,
              type: TextInputType.number,
              hintText: "ادخل السعر",
            ),
            title("التسلسل"),
            TextBoxDark(
              isrequired: false,
              controller: controller.sortOrderController,
              type: TextInputType.number,
              hintText: "تسلسل العرض",
            ),
            title("الوصف"),
            SizedBox(height: 5),
            TextBoxDark(
              controller: controller.descriptionController,
              hintText: "ادخل وصف تفصيلي للمنتج",
              maxLines: 4,
              minLines: 4,
            ),
            SizedBox(height: 15),
            widgetToggleAdd(
              title: "وصل حديثا",
              type: AddToggleType.isNewArrival,
              value: controller.isNewArrival,
              context: context,
            ),
            SizedBox(height: 15),
            widgetToggleAdd(
              title: "الاكثر مبيعا",
              type: AddToggleType.isBestSeller,
              value: controller.isBestSeller,
              context: context,
            ),
            SizedBox(height: 15),
            widgetToggleAdd(
              height: 68,
              title: "اضهار المنتج في المتجر",
              subtitle: "سيظهر المنتج للعملاء في المتجر",
              type: AddToggleType.isActive,
              value: controller.isActiveAdd,
              context: context,
            ),

            SizedBox(height: 15),
            Obx(
              () => ButtonAppWidget(
                onPressed: () => index != null
                    ? controller.updateProduct(index!)
                    : controller.createProduct(),
                statusRequest: controller.statusRequestButtonAdd.value,
                lable: index != null ? "تعديل" : "حفظ",
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  widgetToggleAdd({
    required String title,
    String? subtitle,
    required AddToggleType type,
    required RxBool value,
    required BuildContext context,
    double? height = 48,
  }) {
    return Container(
      height: height,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffF3F3F5),
      ),
      child: Row(
        children: [
          Expanded(
            child: type == AddToggleType.isActive
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff231F1E),
                          fontSize: 14,
                          fontWeight: MyFontWeight.medium,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitle ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Color(0xff6E615E),
                          fontSize: 12,
                          fontWeight: MyFontWeight.light,
                        ),
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff231F1E),
                      fontSize: 14,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
          ),
          Transform.scale(
            scale: 0.89,
            child: Obx(
              () => Switch(
                activeTrackColor: Color(0xffCE0070),
                value: value.value,
                onChanged: (value) => controller.changedActiveAdd(type),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title(String text, {double height = 15}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height),
        Text(
          text,
          style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            color: Color(0xff51515A),
            fontSize: 13,
            fontWeight: MyFontWeight.semiBold,
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
