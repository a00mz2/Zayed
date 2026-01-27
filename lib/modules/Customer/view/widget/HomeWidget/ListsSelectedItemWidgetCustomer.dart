import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class ListsSelectedItemWidgetCustomer extends StatelessWidget {
  ListsSelectedItemWidgetCustomer({
    super.key,
    required this.listStoresByCatigory,
    Rx<StatusRequest>? statusRequest,
  }) : statusRequest = statusRequest ?? StatusRequest.loading.obs;

  final RxList listStoresByCatigory;
  final Rx<StatusRequest> statusRequest;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => listStoresByCatigory.isEmpty
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "أصناف مختارة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff0E0E0E),
                      fontWeight: MyFontWeight.semiBold,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "استكشف بسرعة أفضل الأصناف والمتاجر المختارة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color(0xff747474),
                      fontWeight: MyFontWeight.regular,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listStoresByCatigory.length,
                  separatorBuilder: (context, index) => SizedBox(height: 0),
                  itemBuilder: (context, index) => item(
                    context,
                    ListSelectedItemCustomerMolel(
                      catigoryId: listStoresByCatigory[index]['CatigoryId'],
                      catigoryName: listStoresByCatigory[index]['CatigoryName'],
                      listStore: listStoresByCatigory[index]['data'],
                    ),
                  ),
                ),

                statusRequest.value == StatusRequest.loading
                    ? SizedBox(
                        height: 190,
                        child: ListView.separated(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(
                              right: index == 0 ? 8 : 0,
                              left: index == 4 - 1 ? 16 : 0,
                              top: 10,
                              bottom: 22,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16,
                                  ),
                                  child: Lottie.asset(
                                    width: 136,
                                    height: 112,
                                    AppLottie.lodingcover,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5),

                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16,
                                  ),
                                  child: Lottie.asset(
                                    width: 90,
                                    height: 6,
                                    AppLottie.lodingcover,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16,
                                  ),
                                  child: Lottie.asset(
                                    width: 50,
                                    height: 6,
                                    AppLottie.lodingcover,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }

  Widget item(BuildContext context, ListSelectedItemCustomerMolel data) {
    return SizedBox(
      height: 224,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.catigoryName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(0xff0E0E0E),
                    fontWeight: MyFontWeight.semiBold,
                    fontSize: 17,
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(
                    "/customer/Stores",
                    arguments: {
                      "namePage": data.catigoryName,
                      "model": StoresControllerCustomerModel(
                        typePageStores: TypePageStores.byStoreType,
                        storeTypeId: data.catigoryId,
                      ),
                    },
                  ),
                  child: Row(
                    children: [
                      Text(
                        "المزيد",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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

          SizedBox(height: 8),
          Expanded(
            child: SizedBox(
              height: 192,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: data.listStore.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(
                    right: index == 0 ? 8 : 0,
                    left: index == data.listStore.length - 1 ? 16 : 0,
                    top: 10,
                    bottom: 22,
                  ),
                  width: 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            ViewerImageWidget(
                              width: 136,
                              height: 112,
                              circular: 16,
                              fit: BoxFit.fill,
                              url: data.listStore[index]['logoUrl'],
                            ),
                            Positioned(
                              bottom: 7,
                              right: 7,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(640),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppIcons.star2,
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      data.listStore[index]['ratingAverage']
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        data.listStore[index]['storeName'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontWeight: MyFontWeight.semiBold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "خصومات حتى",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Color(0xff747474),
                                  fontWeight: MyFontWeight.regular,
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            " %${data.listStore[index]['discountPercent']}",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Color(0xffA5006A),
                                  fontWeight: MyFontWeight.semiBold,
                                  fontSize: 12,
                                ),
                          ),
                        ],
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

class ListSelectedItemCustomerMolel {
  final String catigoryId;
  final String catigoryName;
  final List listStore;

  const ListSelectedItemCustomerMolel({
    required this.catigoryId,
    required this.catigoryName,
    required this.listStore,
  });
}
