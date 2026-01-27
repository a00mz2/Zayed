import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class StoresTypeWidgetCustomer extends StatelessWidget {
  StoresTypeWidgetCustomer({
    super.key,
    Rx<StatusRequest>? statusRequest,
    required this.listStoresType,
  }) : statusRequest = statusRequest ?? StatusRequest.success.obs;

  final Rx<StatusRequest> statusRequest;

  final RxList listStoresType;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => statusRequest.value == StatusRequest.loading
          ? Column(
              children: [
                SizedBox(height: 28),
                SizedBox(
                  height: 136,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      height: 136,
                      width: 136,
                      margin: EdgeInsets.only(
                        right: index == 0 ? 8 : 0,
                        left: index == 3 - 1 ? 16 : 0,
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: Lottie.asset(
                          AppLottie.lodingcover,
                          width: 136,
                          height: 136,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : listStoresType.isEmpty
          ? SizedBox()
          : Column(
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الأصناف",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontWeight: MyFontWeight.semiBold,
                          fontSize: 17,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed("/customer/Categories"),
                        child: Row(
                          children: [
                            Text(
                              "المزيد",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: MyFontWeight.semiBold,
                                    fontSize: 12,
                                  ),
                            ),
                            Image.asset(
                              AppIcons.arrowGo,
                              width: 16,
                              height: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 136,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: listStoresType.length,
                    itemBuilder: (context, index) => InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Get.toNamed(
                        "/customer/Stores",
                        arguments: {
                          "namePage": listStoresType[index]['name'],
                          "model": StoresControllerCustomerModel(
                            typePageStores: TypePageStores.byStoreType,
                            storeTypeId: listStoresType[index]['_id'],
                          ),
                        },
                      ),
                      child: Container(
                        height: 136,
                        width: 136,
                        margin: EdgeInsets.only(
                          right: index == 0 ? 8 : 0,
                          left: index == listStoresType.length - 1 ? 16 : 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            ViewerImageWidget(
                              width: 136,
                              height: 136,
                              url: listStoresType[index]['imageUrl'].toString(),
                              circular: 16,
                              lodingIcon: SizedBox(),
                            ),
                            Container(
                              width: 136,
                              height: 136,
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
                                listStoresType[index]['name'].toString(),
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
              ],
            ),
    );
  }
}
