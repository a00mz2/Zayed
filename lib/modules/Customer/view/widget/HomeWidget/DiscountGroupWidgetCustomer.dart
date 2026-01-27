import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class DiscountGroupWidgetCustomer extends StatelessWidget {
  DiscountGroupWidgetCustomer({
    super.key,
    Rx<StatusRequest>? statusRequest,
    required this.listDiscountGroup,
  }) : statusRequest = statusRequest ?? StatusRequest.success.obs;

  final Rx<StatusRequest> statusRequest;

  final RxList listDiscountGroup;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => statusRequest.value == StatusRequest.loading
          ? SizedBox()
          : listDiscountGroup.isEmpty
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
                        "العروض",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff0E0E0E),
                          fontWeight: MyFontWeight.semiBold,
                          fontSize: 17,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
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
                SizedBox(
                  height: 274,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),

                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: listDiscountGroup.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.toNamed(
                        "/customer/Stores",
                        arguments: {
                          "namePage": listDiscountGroup[index]['name'],
                          "model": StoresControllerCustomerModel(
                            typePageStores: TypePageStores.discountGroup,
                            discountGroupId: listDiscountGroup[index]['_id'],
                          ),
                        },
                      ),
                      child: Container(
                        height: 227,
                        width: 253,
                        margin: EdgeInsets.only(
                          right: index == 0 ? 8 : 0,
                          left: index == 10 - 1 ? 16 : 0,
                          top: 14.5,
                          bottom: 32,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 16,

                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: ViewerImageWidget(
                                width: 253,
                                height: 136,
                                circular: 0,
                                url: listDiscountGroup[index]['imageUrl'],
                              ),
                            ),
                            SizedBox(height: 12),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  listDiscountGroup[index]['name'],
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        color: Color(0xff0E0E0E),
                                        fontWeight: MyFontWeight.semiBold,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  listDiscountGroup[index]['description'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        color: Color(0xff5A5A5A),
                                        fontWeight: MyFontWeight.semiBold,
                                        fontSize: 12,
                                      ),
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
