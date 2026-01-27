// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/AllProductControllerMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/AppbarWidgetMerchant.dart';
import 'package:zayed/modules/Merchant/view/Widget/ProductWidgetMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchFilterOrderWidget.dart';
import 'package:zayed/view/Widget/widgetApp/SearchNoDataAvailableWidget.dart';

class AllProductScrrenMerchant extends StatelessWidget {
  AllProductScrrenMerchant({super.key});

  final controller = Get.find<AllProductControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWidget(
        lodingWidget: Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              childAspectRatio: 0.676,
            ),
            itemBuilder: (context, index) => SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 190,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Lottie.asset(
                        AppLottie.lodingcover,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 150,
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Lottie.asset(
                        AppLottie.lodingcover,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 90,
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Lottie.asset(
                        AppLottie.lodingcover,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        onRefresh: () => controller.isFilter.value
            ? controller.getProductFilter(back: false)
            : controller.getProduct(),
        statusCode: controller.statusCode,
        statusRequest: controller.statusRequest,
        appBar: false,
        heder: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppbarWidgetMerchant(),
            ),
            Obx(
              () =>
                  controller.searchController.text.toString().isEmpty &&
                      controller.listProduct.isEmpty &&
                      controller.searchController.text.toString().isNotEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: SearchFilterOrderWidget(
                        filterMode: controller.isFilter,
                        filterFunction: () => controller.openFilter(),
                        orderMode: controller.sortBy.value != null
                            ? true.obs
                            : false.obs,
                        controllerTextBox: controller.searchController,
                        orderFunction: () => controller.openSortBy(),
                        onSearch: (p0) => controller.search(),
                      ),
                    ),
            ),
          ],
        ),
        child: Stack(
          children: [
            Obx(
              () => controller.listProduct.isEmpty
                  ? controller.searchController.text.toString().isNotEmpty ||
                            controller.isFilter.value
                        ? SearchNoDataAvailableWidget(
                            onPressed: () {
                              controller.searchController.text = "";
                              controller.getProduct();
                              controller.resetFilter();
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
                            onPressed: () =>
                                Get.toNamed("/merchant/addProductAll"),
                            buttonLable: "اضافة منتج جديد",
                          )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        controller: controller.scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: controller.listProduct.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.676,
                            ),

                        itemBuilder: (context, index) {
                          return InkWell(
                            key: ValueKey(controller.listProduct[index]['_id']),
                            onTap: () => Get.toNamed(
                              "/merchant/addProductAll",
                              arguments: {'index': index},
                            ),
                            child: Container(
                              width: double.infinity,
                              child: ProductWidgetMerchant(
                                productData: controller.listProduct[index],
                                maxAmount: controller.maxAmount.value,
                                percent: controller.percent.value,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            Positioned(
              bottom: 90,
              left: 16,
              child: InkWell(
                onTap: () => Get.toNamed("/merchant/addProductAll"),
                borderRadius: BorderRadius.circular(10000),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 4),
                        color: Colors.black.withAlpha(15),
                      ),
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 6),
                        color: Colors.black.withAlpha(15),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [Color(0xffCE0070), Color(0xff770053)],
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ],
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
