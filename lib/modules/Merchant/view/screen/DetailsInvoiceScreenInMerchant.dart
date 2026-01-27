import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/formatDate.dart';
import 'package:zayed/core/functions/formatNumber.dart';
import 'package:zayed/view/Widget/widgetApp/viewerImageWidget.dart';

class DetailsInvoiceScreenInMerchant extends StatelessWidget {
  const DetailsInvoiceScreenInMerchant({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffFDF7FA), Color(0xffF6F6F6)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Center(
              child: Image.asset(AppIcons.arrowBack, width: 20, height: 20),
            ),
          ),
          centerTitle: true,
          title: Text(
            "# ${data['invoiceNumber']}",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 17,
              fontWeight: MyFontWeight.semiBold,
              color: Color(0xff0E0E0E),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 16),

            Container(
              height: 80,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(1000),
                      child: Hero(
                        tag: "customerAvatarUrl",
                        child: ViewerImageWidget(
                          width: 48,
                          height: 48,
                          url: data["customerId"]['avatarUrl'],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["customerId"]['name'],
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontSize: 14,
                                fontWeight: MyFontWeight.regular,
                                color: Color(0xff0E0E0E),
                              ),
                        ),
                        Text(
                          formatDateWithDayAndTime(data["createdAt"]),
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontSize: 12,
                                fontWeight: MyFontWeight.regular,
                                color: Color(0xff747474),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            Container(
              height: 164,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffF6F6F6)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "السعر الأصلي",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff747474),
                        ),
                      ),
                      Text(
                        "${formatNumberNum(data['originalAmount'])} د.ع",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff0E0E0E),
                          decoration: TextDecoration.lineThrough, // ✅ تشطيب
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "نسبة الخصم",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff747474),
                        ),
                      ),
                      Text(
                        "%${data['appliedDiscountPercent']}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff0E0E0E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "قيمة الخصم",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff747474),
                        ),
                      ),
                      Text(
                        "${formatNumberNum(data['discountAmount'])} د.ع",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff0E0E0E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(height: 8, color: Color(0xffEAEAEA)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "المبلغ المدفوع",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.regular,
                          color: Color(0xff747474),
                        ),
                      ),
                      Text(
                        "${formatNumberNum(data['finalAmount'])} د.ع",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: MyFontWeight.medium,
                          color: Color(0xffCE0070),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
