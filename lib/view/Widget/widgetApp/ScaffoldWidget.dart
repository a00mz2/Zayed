// ignore_for_file: file_names, unrelated_type_equality_checks

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/view/Widget/widgetApp/ListEmtyWidget.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    this.isSub = false,
    this.hideNotifications = false,
    this.onRefresh,
    this.child,
    required this.statusRequest,
    this.heder,
    this.bottomNavigationBar,
    this.footer,
    this.appBar = false,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.isPublicRoutes = false,
    required this.statusCode,
    this.namePage,
    this.iconPage,
    this.backgroundColor,
    this.lodingWidget,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
  });
  final bool? isSub;
  final bool? isPublicRoutes;
  final RxInt statusCode;

  final bool? hideNotifications;
  final Future<void> Function()? onRefresh;
  final Widget? child;
  final Widget? heder;
  final Widget? footer;
  final Rx<StatusRequest> statusRequest;
  final bool appBar;
  final double horizontalPadding;
  final double verticalPadding;
  final String? namePage;
  final Widget? iconPage;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? lodingWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: appBar || namePage != null
          ? AppBar(
              leading: Center(
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                    child: Image.asset(
                      AppIcons.arrowBack,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                namePage ?? "",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Color(0xff0E0E0E),
                  fontSize: 17,
                  fontWeight: MyFontWeight.semiBold,
                ),
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        color: Theme.of(context).primaryColor,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              children: [
                heder ?? SizedBox(),
                Expanded(
                  child: Obx(
                    () =>
                        statusRequest.value != StatusRequest.success &&
                            statusCode.value != 400
                        ? ListEmtyWidget(
                            lodingWidget: lodingWidget,
                            onRefresh: onRefresh,
                            statusRequest: statusRequest,
                            statusCode: statusCode,
                          )
                        : statusCode == 400
                        ? child ?? SizedBox()
                        : child ?? SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: SafeArea(
        top: false, // مهم
        child: Obx(
          () => statusRequest.value != StatusRequest.success
              ? const SizedBox.shrink()
              : bottomNavigationBar ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
