import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/modules/Customer/view/widget/HomeWidget/StoreCircleItemWidget.dart';

class GridFeaturedStoreWidget extends StatelessWidget {
  GridFeaturedStoreWidget({
    super.key,
    required this.listMerchant,
    Rx<StatusRequest>? statusRequest,
    this.circleButtonShowAllStore = false,
    this.controller,
    this.physics = const NeverScrollableScrollPhysics(),
  }) : statusRequest = statusRequest ?? StatusRequest.success.obs;

  final RxList listMerchant;
  final Rx<StatusRequest> statusRequest;
  final bool? circleButtonShowAllStore;
  final ScrollController? controller;

  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = statusRequest.value == StatusRequest.loading;
      final isEmpty = listMerchant.isEmpty;

      final Widget child = (isLoading || isEmpty)
          ? const SizedBox(key: ValueKey('empty'))
          : Padding(
              key: const ValueKey('content'),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "المضاف جديدا",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0xff0E0E0E),
                        fontWeight: MyFontWeight.semiBold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    controller: controller,
                    physics: physics,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: listMerchant.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 23.6,
                          mainAxisSpacing: 16,
                          childAspectRatio: 64 / 108,
                        ),
                    itemBuilder: (context, index) =>
                        index == listMerchant.length
                        ? (circleButtonShowAllStore!
                              ? CircleButtonShowAllStore()
                              : const SizedBox())
                        : StoreCircleItem(
                            onTap: () => Get.toNamed(
                              "/customer/Store",
                              arguments: {"id": listMerchant[index]['id']},
                            ),
                            storeItemMolel: StoreItemMolel(
                              id: listMerchant[index]['id'],
                              name: listMerchant[index]['storeName'],
                              discountPercent:
                                  listMerchant[index]['discountPercent'],
                              image: listMerchant[index]['logoUrl'],
                            ),
                          ),
                  ),
                ],
              ),
            );

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) {
          final fade = FadeTransition(opacity: anim, child: child);
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(anim),
            child: fade,
          );
        },
        child: child,
      );
    });
  }
}
