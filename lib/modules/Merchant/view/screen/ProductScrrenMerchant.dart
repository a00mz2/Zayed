// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/ProductControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchFilterOrderWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchNoDataAvailableWidget.dart';

class ProductScrrenMerchant extends StatelessWidget {
  ProductScrrenMerchant({super.key});

  final controller = Get.find<ProductControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      onRefresh: () => controller.isFilter.value
          ? controller.getProductFilter(back: false)
          : controller.getProduct(),
      namePage: controller.subCategoryName,
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      appBar: true,

      heder: Obx(
        () =>
            controller.searchController.text.toString().isEmpty &&
                controller.listProduct.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: SearchFilterOrderWidget(
                  filterMode: controller.isFilter,
                  filterFunction: () => controller.openFilter(),
                  orderMode: controller.orderMode,
                  controllerTextBox: controller.searchController,
                  orderFunction: () => controller.activateCancelOrderMode(),
                  onSearch: (p0) => controller.search(),
                ),
              ),
      ),

      bottomNavigationBar: Obx(
        () => controller.listProduct.isEmpty
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
                      : () => Get.toNamed("/merchant/addProduct"),
                ),
              ),
      ),
      child: Obx(
        () => controller.listProduct.isEmpty
            ? controller.searchController.text.toString().isNotEmpty
                  ? SearchNoDataAvailableWidget(
                      onPressed: () {
                        controller.searchController.text = "";
                        controller.getProduct();
                      },
                    )
                  : NoDataAvailableWidget(
                      assets: Lottie.asset(
                        AppLottie.emptyBox,
                        width: 150,
                        height: 150,
                      ),
                      title: 'لا توجد منتجات بعد',
                      bodyText: 'ابدأ بإضافة منتج جديد لعرضه للعملاء',
                      onPressed: () => Get.toNamed("/merchant/addProduct"),
                      buttonLable: "اضافة منتج جديد",
                    )
            : ReorderableGridView.builder(
                dragEnabled: controller.orderMode.value,
                padding: const EdgeInsets.all(12),
                itemCount: controller.listProduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.676,
                ),
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = controller.listProduct.removeAt(oldIndex);
                  controller.listProduct.insert(newIndex, item);
                  controller.updateReorderPayload(
                    start: oldIndex < newIndex ? oldIndex : newIndex,
                    end: oldIndex < newIndex ? newIndex : oldIndex,
                  );

                  print(controller.reorderPayload);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    key: ValueKey(controller.listProduct[index]['_id']),
                    onTap: () => controller.orderMode.value
                        ? null
                        : Get.toNamed(
                            "/merchant/addProduct",
                            arguments: {'index': index},
                          ),
                    child: Container(
                      width: double.infinity,

                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = constraints.maxWidth;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: productImage(
                                      controller.getProductImage(index),
                                      size,
                                      size,
                                    ),
                                  ),
                                  controller.listProduct[index]['isActive']
                                      ? SizedBox()
                                      : Positioned(
                                          left: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              "معطل",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        MyFontWeight.regular,
                                                  ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Flexible(
                                child: SizedBox(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    controller.listProduct[index]['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Color(0xff5A5A5A),
                                          fontSize: 12,
                                          fontWeight: MyFontWeight.regular,
                                        ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFCEEF5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "%${controller.percent.value}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: const Color(0xffA5006A),
                                            fontSize: 12,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      "${controller.calculatePriceAfterDiscount(price: controller.listProduct[index]['price'])} د.ع",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: const Color(0xff0E0E0E),
                                            fontSize: 12,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget productImage(String? url, width, height) {
    if (url == null || url.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey.withAlpha(30),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.broken_image_rounded,
          color: Colors.blueGrey,
          size: 25,
        ),
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Lottie.asset(
                AppLottie.lodingImage,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
              Center(
                child: Icon(
                  Icons.image,
                  color: Colors.blueGrey.withAlpha(20),
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.blueGrey.withAlpha(30),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.broken_image_rounded,
            color: Colors.blueGrey,
            size: 25,
          ),
        );
      },
    );
  }
}
