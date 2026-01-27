// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/functions/logOut.dart';
import 'package:zayed/modules/Merchant/controller/ProfileControllerMerchant.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

class ProfileScreenInMerchant extends StatelessWidget {
  ProfileScreenInMerchant({super.key});

  final controller = Get.find<ProfileControllerMerchant>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: false,
      onRefresh: () => controller.getDataProfile(),
      statusRequest: controller.statusRequest,
      statusCode: controller.statusCode,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Image.asset(
                AppImage.backgrond3,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  SizedBox(height: 47),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الحساب",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Color(0xff0E0E0E),
                                fontSize: 17,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10000),
                          onTap: () => Get.toNamed("/Notifications"),
                          child: Image.asset(
                            AppIcons.notificationsIcon,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),

                  Container(
                    height: 64,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () =>
                                  Get.toNamed("/merchant/AddDataAccount"),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.profileData['storeName'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Color(0xff0E0E0E),
                                            fontSize: 20,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                    ),
                                  ),
                                  Image.asset(
                                    AppIcons.arrowGo,
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppIcons.starAverage,
                                  width: 16,
                                  height: 16,
                                  color: Color(0xffE8B047),
                                ),
                                SizedBox(width: 4),
                                Obx(
                                  () => Text(
                                    controller.profileData['ratingAverage']
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Color(0xff0E0E0E),
                                          fontSize: 15,
                                          fontWeight: MyFontWeight.semiBold,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Obx(
                                    () => Text(
                                      controller
                                          .profileData['storeTypeId']['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Color(0xffCE0070),
                                            fontSize: 12,
                                            fontWeight: MyFontWeight.regular,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xdd680039), Color(0xddCE0070)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100000),
                            child: Obx(
                              () => Image.network(
                                (controller.profileData['logoUrl'].toString()),
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          listTile(
            context,
            AppIcons.section,
            "الاقسام",
            onPressed: () => Get.toNamed("/merchant/category"),
          ),
          listTile(
            context,
            AppIcons.employees,
            "الموضفين",
            onPressed: () => Get.toNamed("/merchant/Staff"),
          ),
          listTile(context, AppIcons.giftIcon2, "اهداء اشتراك"),
          listTile(context, AppIcons.chatIcon, "التواصل"),
          listTile(context, AppIcons.star, "التقييمات"),
          listTileLogOut(context),
        ],
      ),
    );
  }

  Widget listTile(
    BuildContext context,
    String icon,
    String lable, {
    Function()? onPressed,
  }) {
    return BouncingWidget(
      duration: Duration(milliseconds: 80),
      scaleFactor: 1,
      onPressed: onPressed ?? () {},
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32),
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: 24, height: 24),
            SizedBox(width: 14),
            Text(
              lable,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xff0E0E0E),
                fontSize: 14,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            Expanded(child: SizedBox()),
            Image.asset(AppIcons.arrowGo, width: 16, height: 16),
          ],
        ),
      ),
    );
  }

  Widget listTileLogOut(BuildContext context) {
    return BouncingWidget(
      duration: Duration(milliseconds: 80),
      scaleFactor: 1,
      onPressed: () => logout(),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32),
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppIcons.logout2, width: 24, height: 24),
            SizedBox(width: 14),
            Text(
              "الخروج",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(0xffFF0000),
                fontSize: 14,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            SizedBox(width: 10),
            Obx(
              () => statusRequestLogout.value == StatusRequest.loading
                  ? SpinKitFadingCircle(size: 30, color: Colors.red)
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
