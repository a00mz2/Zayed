import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/StoreCircleItemWidget.dart';
import 'package:zayed/view/Widget/widgetApp/NoDataAvailableWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class StoresScreenCustomer extends StatelessWidget {
  StoresScreenCustomer({super.key, required this.namePage});

  final StoresControllerCustomer controller =
      Get.find<StoresControllerCustomer>();

  final String namePage;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      namePage: namePage,

      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      appBar: false,
      onRefresh: () async => controller.getMerchant(),
      child: Obx(
        () => controller.listMerchant.isEmpty
            ? NoDataAvailableWidget(
                assets: Lottie.asset(
                  AppLottie.emptyBox,
                  width: 100,
                  height: 100,
                ),
              )
            : controller.listMerchant.length >= 14
            ? ListView(
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    height: Get.size.height - 130,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: controller.listMerchant.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 23.6,
                            childAspectRatio: 108 / 64,
                          ),
                      itemBuilder: (context, index) => StoreCircleItem(
                        storeItemMolel: StoreItemMolel(
                          id: controller.listMerchant[index]['id'],
                          name: controller.listMerchant[index]['storeName'],
                          discountPercent:
                              controller.listMerchant[index]['discountPercent'],
                          image: controller.listMerchant[index]['logoUrl'],
                        ),
                      ),
                    ),
                  ),
                  controller.statusRequestPagination.value ==
                          StatusRequest.loading
                      ? Center(
                          child: LinearProgressIndicator(
                            minHeight: 3,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : SizedBox(height: 3),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: controller.listMerchant.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 23.6,
                            mainAxisSpacing: 16,
                            childAspectRatio: 64 / 108,
                          ),
                      itemBuilder: (context, index) => StoreCircleItem(
                        storeItemMolel: StoreItemMolel(
                          id: controller.listMerchant[index]['id'],
                          name: controller.listMerchant[index]['storeName'],
                          discountPercent:
                              controller.listMerchant[index]['discountPercent'],
                          image: controller.listMerchant[index]['logoUrl'],
                        ),
                      ),
                    ),
                  ),
                  controller.statusRequestPagination.value ==
                          StatusRequest.loading
                      ? Center(
                          child: LinearProgressIndicator(
                            minHeight: 3,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : SizedBox(height: 3),
                ],
              ),
      ),
    );
  }
}
