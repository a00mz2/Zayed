// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/NotificationsController.dart';
import 'package:zayed/modules/Agent/View/widget/NotificationsWidget/CardNotificationsWidget.dart';
import 'package:zayed/view/Widget/widgetApp/PaginationIndicator.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final controller = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldWidget(
        namePage: "الإشعارات",
        statusRequest: controller.statusRequest,
        statusCode: controller.statusCode,

        onRefresh: () => controller.getData(),

        child: Obx(
          () => ListView.separated(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemBuilder: (context, index) => Column(
              children: [
                CardNotificationsWidget(
                  index: index,
                  title: controller.notifications[index]['title'],
                  body: controller.notifications[index]['body'],
                  date: controller.notifications[index]['createdAt'],
                  isRead: controller.notifications[index]['isRead'],
                ),

                Obx(
                  () => PaginationIndicator(
                    index: index,
                    listlength: controller.notifications.length,
                    statusRequestPagination:
                        controller.statusRequestPagination.value,
                  ),
                ),
              ],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: controller.notifications.length,
          ),
        ),
      ),
    );
  }
}
