import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zayed/core/class/CouponClipper.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class HeaderHomeWidgetInfluencer extends StatelessWidget {
  HeaderHomeWidgetInfluencer({super.key});

  final controler = Get.find<HomeControllerInfluencer>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 287,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff770053),
                  Color(0xffB9006D),
                  Color(0xffCE0070),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.mdi_discountoutline,
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "تحصل على ${controler.profileData['referralCommissionPercent']}% عمولة من كل اشتراك",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipPath(
                  clipper: CouponClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withAlpha(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controler.profileData['referralCode'],
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: MyFontWeight.medium,
                                color: Colors.white,
                                fontSize: 36,
                                letterSpacing: 2,
                              ),
                        ),
                        Text(
                          "خصم ${controler.profileData['referralDiscountPercent']}% على جميع الباقات",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: MyFontWeight.medium,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonAppWidget(
                          fontSize: 15,
                          fontWeight: MyFontWeight.regular,
                          color: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                          radius: 5,
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: controler.profileData['referralCode']
                                    .toString(),
                              ),
                            );
                            AppSnackBar.info("تم النسخ الى الحافضة");
                          },
                          icon: Icon(
                            Icons.copy,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          ),
                          lable: "نسخ",
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: ButtonAppWidget(
                          elevation: 0,
                          fontSize: 15,
                          fontWeight: MyFontWeight.regular,
                          color: Colors.white.withAlpha(30),
                          textColor: Colors.white,
                          radius: 5,
                          onPressed: () async {
                            final box =
                                context.findRenderObject() as RenderBox?;
                            await SharePlus.instance.share(
                              ShareParams(
                                text: controler.profileData['referralCode']
                                    .toString(),
                                subject: "كود دعوة 🎁",
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 16,
                          ),
                          lable: "مشاركة",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(),
            height: 55,
            decoration: BoxDecoration(
              color: Color(0xffFAF5FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppIcons.truemark, width: 16, height: 16),
                SizedBox(width: 10),
                Text(
                  "تحصل على ${controler.profileData['referralCommissionPercent']}% عمولة من كل اشتراك",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: MyFontWeight.regular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
