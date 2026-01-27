import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/modules/Customer/Controller/CategoriesControllerCustomer.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class CategoriesScreenCustomer extends StatelessWidget {
  CategoriesScreenCustomer({super.key});

  final CategoriesControllerCustomer controller = Get.put(
    CategoriesControllerCustomer(),
  );

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      namePage: "فئات المتاجر",
      statusCode: controller.statusCode,
      statusRequest: controller.statusRequest,
      onRefresh: () => controller.getCategories(),

      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),

                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Get.toNamed(
                      "/customer/Stores",
                      arguments: {
                        "namePage": controller.listStoreType[index]['name'],
                        "model": StoresControllerCustomerModel(
                          typePageStores: TypePageStores.byStoreType,
                          storeTypeId: controller.listStoreType[index]['_id'],
                        ),
                      },
                    ),
                    child: Center(
                      child: Container(
                        height: constraints.maxWidth / 1.7,
                        margin: EdgeInsets.only(
                          top: index == 0 ? 20 : 0,
                          bottom: index == controller.listStoreType.length - 1
                              ? 50
                              : 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            ViewerImageWidget(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth / 1.2,
                              url: controller.listStoreType[index]['imageUrl']
                                  .toString(),
                              circular: 16,
                              lodingIcon: SizedBox(),
                            ),
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth / 1.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffDADADA).withAlpha(0),
                                    Colors.black.withAlpha(900),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 12,
                              child: Text(
                                controller.listStoreType[index]['name']
                                    .toString(),
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: MyFontWeight.semiBold,
                                      fontSize: 12,
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                          color: Colors.black26,
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: controller.listStoreType.length,
              ),
            ),
            controller.statusRequestPagination.value == StatusRequest.loading
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
