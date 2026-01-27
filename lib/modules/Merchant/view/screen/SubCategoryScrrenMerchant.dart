// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/SubCategoryControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/SubCategoryWidget/CardSubCategoryMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class SubCategoryScrrenMerchant extends StatelessWidget {
  SubCategoryScrrenMerchant({super.key});

  final controller = Get.find<SubCategoryControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      // lodingWidget: Expanded(
      //   child: Lottie.asset(AppLottie.lodingelements, width: double.infinity),
      // ),
      onRefresh: () => controller.getSubCategories(),
      namePage: controller.categoryName.toString(),
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      appBar: true,

      bottomNavigationBar: Obx(
        () => controller.listSubCategories.isEmpty
            ? SizedBox()
            : Container(
                height: 72,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ButtonAppWidget(
                  statusRequest: controller.statusRequestButton.value,
                  lable: controller.orderMode.value
                      ? "حضظ التغييرات"
                      : "انشاء قسم جديد",
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: controller.orderMode.value
                      ? controller.reorderPayload.isEmpty
                            ? null
                            : () => controller.reorder()
                      : () => Get.toNamed("/merchant/addSubCategory"),
                ),
              ),
      ),
      child: Obx(
        () => controller.listSubCategories.isEmpty
            ? NoDataAvailableWidget(
                assets: Lottie.asset(
                  AppLottie.emptyBox,
                  width: 150,
                  height: 150,
                ),
                title: 'لا توجد أقسام فرعية في ${controller.categoryName}',
                bodyText: 'ابدأ بإنشاء قسم فرعي جديد',
                onPressed: () => Get.toNamed("/merchant/addSubCategory"),
                buttonLable: "انشاء قسم جديد",
              )
            : ReorderableListView.builder(
                buildDefaultDragHandles: controller.orderMode.value,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = controller.listSubCategories.removeAt(oldIndex);
                  controller.listSubCategories.insert(newIndex, item);
                  final String id = item['_id'];
                  final int sortOrder = newIndex + 1;
                  controller.addOrUpdateReorderItem(id, sortOrder);
                },
                itemCount: controller.listSubCategories.length,
                itemBuilder: (context, index) => CardSubCategoryMerchant(
                  index: index,
                  key: ValueKey(controller.listSubCategories[index]['_id']),
                ),
              ),
      ),
    );
  }
}
