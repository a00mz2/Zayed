import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Customer/Controller/StoresControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class StoreCircleItem extends StatelessWidget {
  const StoreCircleItem({super.key, this.onTap, required this.storeItemMolel});

  final StoreItemMolel storeItemMolel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 12,
                  color: Color(0xff000000).withAlpha(10),
                ),
              ],
            ),
            child: ViewerImageWidget(
              url: storeItemMolel.image,
              lottieLoding: false,
              circular: 10000,
              width: 64,
              height: 64,
            ),
          ),
          SizedBox(height: 4),
          Text(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            storeItemMolel.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color(0xff5A5A5A),
              fontSize: 12,
              fontWeight: MyFontWeight.regular,
            ),
          ),
          SizedBox(height: 4),
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            "${storeItemMolel.discountPercent}%",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color(0xff0E0E0E),
              fontSize: 12,
              fontWeight: MyFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButtonShowAllStore extends StatelessWidget {
  const CircleButtonShowAllStore({super.key});

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: () => Get.toNamed(
        "/customer/Stores",
        arguments: {
          "namePage": "احدث المتاجر",
          "model": StoresControllerCustomerModel(
            typePageStores: TypePageStores.featured,
          ),
        },
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF6F6F6),
            ),
            child: Center(
              child: Image.asset(AppIcons.Iconwrapper, width: 24, height: 24),
            ),
          ),
          SizedBox(height: 4),
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            "المزيد",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Color(0xff0E0E0E),
              fontSize: 12,
              fontWeight: MyFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

class StoreItemMolel {
  final String id;
  final String name;
  final String? image;
  final int discountPercent;

  const StoreItemMolel({
    required this.id,
    required this.name,
    this.image,
    required this.discountPercent,
  });
}
