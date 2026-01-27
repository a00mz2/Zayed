import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/SubCategoryControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/CategoryActionsMenu.dart';

class CardSubCategoryMerchant extends StatelessWidget {
  CardSubCategoryMerchant({super.key, required this.index});

  final controller = Get.find<SubCategoryControllerMerchant>();

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 240, 240, 240)),
        ),
        color: controller.listSubCategories[index]['isActive']
            ? Colors.white
            : const Color.fromARGB(255, 255, 237, 236),
      ),
      margin: EdgeInsets.only(top: index == 0 ? 10 : 0, bottom: 0),
      height: 83,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => !controller.orderMode.value
                ? SizedBox.shrink()
                : Image.asset(
                    AppIcons.order,
                    width: 20,
                    height: 20,
                    color: Color(0xffCE0070),
                  ),
          ),
          SizedBox(width: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: categoryImage(
              controller.listSubCategories[index]['imageUrl'],
            ),
          ),

          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        controller.listSubCategories[index]['name'],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Obx(
                      () => controller.indexLoding.value == index
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: Lottie.asset(AppLottie.deleteLoding),
                            )
                          : CategoryActionsMenu(
                              items: [
                                ActionMenuItem(
                                  label: 'المنتجات',
                                  iconPath: AppIcons.eye,
                                  onTap: () {
                                    Get.toNamed(
                                      "/merchant/product",
                                      arguments: {
                                        'categoryId': controller
                                            .listSubCategories[index]['parentCategoryId'],
                                        'subCategoryId': controller
                                            .listSubCategories[index]['_id'],
                                        'subCategoryName': controller
                                            .listSubCategories[index]['name'],
                                      },
                                    );
                                  },
                                ),
                                ActionMenuItem(
                                  label: 'تعديل',
                                  iconPath: AppIcons.edit,
                                  onTap: () {
                                    Get.toNamed(
                                      '/merchant/addSubCategory',
                                      arguments: {'index': index},
                                    );
                                  },
                                ),
                                ActionMenuItem(
                                  label: 'حذف',
                                  iconPath: AppIcons.remove,
                                  color: Colors.red,
                                  onTap: () => controller.removeSubCategories(
                                    controller.listSubCategories[index]['_id'],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5),
                    Text(
                      "${controller.listSubCategories[index]['productCount']} منتج"
                          .toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Color(0xff868E98),
                        fontSize: 12,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryImage(String? url) {
    if (url == null || url.isEmpty) {
      return Container(
        width: 63,
        height: 63,
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
      width: 63,
      height: 63,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // ✅ التحميل اكتمل → اعرض الصورة
          return child;
        }

        // ⏳ ما زال التحميل جاري
        return SizedBox(
          width: 63,
          height: 63,
          child: Stack(
            children: [
              Lottie.asset(AppLottie.lodingImage, fit: BoxFit.cover),
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
          width: 63,
          height: 63,
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
