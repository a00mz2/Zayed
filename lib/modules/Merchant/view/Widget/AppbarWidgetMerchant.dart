import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';

class AppbarWidgetMerchant extends StatelessWidget {
  const AppbarWidgetMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImage.logo,
            color: Theme.of(context).primaryColor,
            width: 28,
            height: 36,
          ),

          Obx(
            () => InkWell(
              borderRadius: BorderRadius.circular(10000),
              onTap: () => Get.toNamed("/Notifications"),
              child: unreadCount.value == 0
                  ? Image.asset(AppIcons.notifications, width: 40, height: 40)
                  : Image.asset(
                      AppIcons.notificationsAc,
                      width: 40,
                      height: 40,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
