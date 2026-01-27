// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/CategoryControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/CategoryWidget/CardCategoryMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchFilterOrderWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchNoDataAvailableWidget.dart';

class CategoryScrrenMerchant extends StatelessWidget {
  CategoryScrrenMerchant({super.key});

  final controller = Get.find<CategoryControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      onRefresh: () => controller.getCategories(),
      namePage: "الاقسام",
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      appBar: true,

      heder: Obx(
        () =>
            controller.searchController.text.toString().isEmpty &&
                controller.listCategories.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: SearchFilterOrderWidget(
                  showFilter: false.obs,
                  lable: "البحث في الاقسام",
                  orderMode: controller.orderMode,
                  controllerTextBox: controller.searchController,
                  orderFunction: () => controller.activateCancelOrderMode(),
                  onSearch: (p0) => controller.search(),
                ),
              ),
      ),

      bottomNavigationBar: Obx(
        () => controller.listCategories.isEmpty
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
                      : () => Get.toNamed("/merchant/addCategory"),
                ),
              ),
      ),
      child: Obx(
        () => controller.listCategories.isEmpty
            ? controller.searchController.text.toString().isNotEmpty
                  ? SearchNoDataAvailableWidget(
                      onPressed: () {
                        controller.searchController.text = "";
                        controller.getCategories();
                      },
                    )
                  : NoDataAvailableWidget(
                      assets: Lottie.asset(
                        AppLottie.emptyBox,
                        width: 150,
                        height: 150,
                      ),
                      title: 'لا توجد أقسام بعد',
                      bodyText: 'ابدأ بإنشاء قسم جديد لتنظيم منتجاتك بشكل أفضل',
                      onPressed: () => Get.toNamed("/merchant/addCategory"),
                      buttonLable: "انشاء قسم جديد",
                    )
            : ReorderableListView.builder(
                buildDefaultDragHandles: controller.orderMode.value,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }

                  final item = controller.listCategories.removeAt(oldIndex);
                  controller.listCategories.insert(newIndex, item);

                  // 🔥 بعد أي تحريك: حدّث كل العناصر المتأثرة
                  controller.updateReorderPayload(
                    start: oldIndex < newIndex ? oldIndex : newIndex,
                    end: oldIndex < newIndex ? newIndex : oldIndex,
                  );

                  print(controller.reorderPayload);
                },
                itemCount: controller.listCategories.length,
                itemBuilder: (context, index) => CardCategoryMerchant(
                  index: index,
                  key: ValueKey(controller.listCategories[index]['_id']),
                ),
              ),
      ),
    );
  }
}
