import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/modules/Customer/Controller/StoreControllerCustomer.dart';
import 'package:zayed/view/Widget/widgetApp/ScaffoldWidget.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';
import 'package:zayed/view/Widget/widgetApp/ExpandableTextWidget.dart';

import '../../../../core/functions/GuidanceExternalapp.dart';

class StoreScreenCustomer extends StatelessWidget {
  StoreScreenCustomer({super.key});

  final StoreControllerCustomer controller =
      Get.find<StoreControllerCustomer>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: Color(0xffF6F6F6),
      statusRequest: controller.statusRequest,
      statusCode: controller.statusCode,
      onRefresh: () async => controller.getStoreData(),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                _cover(constraints.maxWidth),
                _storeInfo(constraints.maxWidth, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //==========================================================
  Widget _cover(double width) {
    return Container(
      height: width * 0.597,
      decoration: BoxDecoration(color: Colors.grey),

      child: Obx(
        () => ViewerImageWidget(
          type: controller.storeDetails['coverType'] == "video"
              ? MediaType.video
              : MediaType.image,
          url: controller.storeDetails['coverUrl'],
          width: width,
          height: width * 0.597,
          circular: 0,
        ),
      ),
    );
  }

  Widget _storeInfo(double width, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: EdgeInsets.only(top: (width * 0.597) - 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _name(context),
                    SizedBox(height: 4),
                    _discount(context),
                    SizedBox(height: 16),
                    _rating(context),
                  ],
                ),
              ),
              _logo(),
            ],
          ),
          SizedBox(height: 16),
          _description(),
          SizedBox(height: 16),
          _address(),
          SizedBox(height: 16),
          addressPhoneButton(context),
        ],
      ),
    );
  }

  _logo() {
    return InkWell(
      onTap: () => Get.toNamed(
        "/customer/StoreMainCategories",
        arguments: {"storeId": controller.storeDetails['id']},
      ),

      child: ViewerImageWidget(
        url: controller.storeDetails['logoUrl'] + "",
        width: 80,
        height: 80,
        circular: 10000,
      ),
    );
  }

  Widget _name(context) {
    return Text(
      controller.storeDetails['storeName'],
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Color(0xff0E0E0E),
        fontWeight: MyFontWeight.semiBold,
        fontSize: 20,
      ),
    );
  }

  Widget _discount(context) {
    return Row(
      children: [
        Text(
          "توفير حتى",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Color(0xff747474),
            fontWeight: MyFontWeight.regular,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 5),
        Text(
          "${controller.storeDetails['discountPercent']} %",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Color(0xffA5006A),
            fontWeight: MyFontWeight.semiBold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  _rating(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.star2,
          width: 16,
          height: 16,
          color: Color(0xffE8B047),
        ),
        SizedBox(width: 4),
        Text(
          "${controller.storeDetails['ratingAverage'].toDouble()}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Color(0xff0E0E0E),
            fontWeight: MyFontWeight.semiBold,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 4),
        Text(
          "(${controller.storeDetails['ratingCount']} تقييمات)",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Color(0xff747474),
            fontWeight: MyFontWeight.regular,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 4),
        Image.asset(
          AppIcons.arrowGo,
          width: 20,
          height: 20,
          color: Color(0xff161616),
        ),
      ],
    );
  }

  Widget _description() {
    return Align(
      alignment: Alignment.centerRight,
      child: ExpandableTextWidget(
        text: controller.storeDetails['description'] ?? "",
        trimLines: 2,
      ),
    );
  }

  Widget _address() {
    return Align(
      alignment: Alignment.centerRight,
      child: ExpandableTextWidget(
        text: controller.storeDetails['address'] ?? "",
        trimLines: 2,
      ),
    );
  }

  Widget addressPhoneButton(context) {
    return Row(
      children: [
        Expanded(
          child: BouncingWidget(
            onPressed: () => openWhatsAppToPhone(phone:controller.storeDetails['phone']),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                "${controller.storeDetails['phone']} (964+)",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff0E0E0E),
                  fontWeight: MyFontWeight.regular,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: BouncingWidget(
            onPressed: () => openInMapsFromData({
              "lat": controller.storeDetails['location']['lat'],
              "lng": controller.storeDetails['location']['lng'],
            }),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                "${controller.storeDetails['address']}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff0E0E0E),
                  decoration: TextDecoration.underline,
                  fontWeight: MyFontWeight.regular,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
