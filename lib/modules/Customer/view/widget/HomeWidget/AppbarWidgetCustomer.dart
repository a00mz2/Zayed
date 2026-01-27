import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/constant/assets/images.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class AppbarWidgetCustomer extends StatelessWidget {
  AppbarWidgetCustomer({
    super.key,
    Rx<StatusRequest>? statusRequest,
    this.dataAccount,
  }) : statusRequest = statusRequest ?? StatusRequest.success.obs;

  final Rx<StatusRequest> statusRequest;

  final RxMap? dataAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
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
            () => statusRequest.value == StatusRequest.loading
                ? ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(1000),
                    child: Lottie.asset(
                      AppLottie.lodingcover,
                      fit: BoxFit.cover,
                      width: 104,
                      height: 43,
                    ),
                  )
                : dataAccount!.isEmpty
                ? SizedBox()
                : dataAccount!['isSubscribed']
                ? SizedBox(
                    height: 46,
                    child: Stack(
                      children: [
                        Container(
                          height: 43,
                          padding: EdgeInsets.only(
                            top: 4,
                            left: 4,
                            bottom: 4,
                            right: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formatNumber(
                                      dataAccount!['savings']['totalSaved'],
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Color(0xff0E0E0E),
                                          fontSize: 14,
                                          fontWeight: MyFontWeight.semiBold,
                                        ),
                                  ),
                                  Text(
                                    "قيمة التوفير",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Color(0xffCE0070),
                                          fontSize: 8,
                                          fontWeight: MyFontWeight.medium,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8),
                              ViewerImageWidget(
                                errorIcon: Image.asset(AppIcons.avatar),
                                width: 40,
                                height: 32,
                                url: dataAccount!['avatarUrl'],
                                circular: 100000,
                                lodingIcon: Image.asset(AppImage.Textwrapper),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 3,
                          child: Container(
                            height: 12,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Color(0xffE6F9F5),
                            ),
                            child: Center(
                              child: Text(
                                "مشترك",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Color(0xff00896F),
                                      fontSize: 8,
                                      fontWeight: MyFontWeight.medium,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: 50,
                    height: 45,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: 3,
                          top: 0,
                          child: Container(
                            width: 43,
                            height: 43,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ViewerImageWidget(
                              errorIcon: Image.asset(AppIcons.avatar),
                              width: 40,
                              height: 32,
                              url: dataAccount!['avatarUrl'],
                              circular: 100000,
                              lodingIcon: Image.asset(AppImage.Textwrapper),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 12,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: Colors.red[100],
                                ),
                                child: Center(
                                  child: Text(
                                    maxLines: 1,
                                    "غير مشترك",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.red,
                                          fontSize: 8,
                                          fontWeight: MyFontWeight.medium,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
