import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/modules/Merchant/controller/CategoryControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/CategoryActionsMenu.dart';

class CardCategoryMerchant extends StatelessWidget {
  CardCategoryMerchant({super.key, required this.index});

  final controller = Get.find<CategoryControllerMerchant>();

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromARGB(255, 240, 240, 240)),
        ),
        color: controller.listCategories[index]['isActive']
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
            child: categoryImage(controller.listCategories[index]['imageUrl']),
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
                        controller.listCategories[index]['name'],
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
                                  label: 'الفرعية',
                                  iconPath: AppIcons.eye,
                                  onTap: () => Get.toNamed(
                                    '/merchant/SubCategory',
                                    arguments: {
                                      'categoryId': controller
                                          .listCategories[index]['_id'],
                                      "categoryName": controller
                                          .listCategories[index]['name'],
                                    },
                                  ),
                                ),
                                ActionMenuItem(
                                  label: 'تعديل',
                                  iconPath: AppIcons.edit,
                                  onTap: () {
                                    Get.toNamed(
                                      '/merchant/addCategory',
                                      arguments: {'index': index},
                                    );
                                  },
                                ),
                                ActionMenuItem(
                                  label: 'حذف',
                                  iconPath: AppIcons.remove,
                                  color: Colors.red,
                                  onTap: () => controller.removeCategories(
                                    controller.listCategories[index]['_id'],
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
                    Image.asset(AppIcons.subSection, width: 17, height: 17),
                    SizedBox(width: 5),
                    Text(
                      controller.listCategories[index]['subCategoryCount']
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
