// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zayed/Controller/AuthControler.dart';
import 'package:zayed/core/class/BordersDotted.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';
import 'package:zayed/core/functions/snackbar.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';
import 'package:share_plus/share_plus.dart';

class ReferralCodeFormWidget extends StatelessWidget {
  ReferralCodeFormWidget({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Container(
          height: 203,
          decoration: BoxDecoration(
            color: Color(0xff9F15F4),
            gradient: LinearGradient(
              colors: [Color(0xff9F15F4), Color(0xffE56958)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(AppIcons.rightSemicircle, width: 72.55),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(AppIcons.LeftSemicircle, width: 72.55),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppIcons.giftIcon, width: 50, height: 50),
                    SizedBox(height: 20),
                    Text(
                      "هدية خاصة الك!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: MyFontWeight.semiBold,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "لديك الان كود مشاركة خاص بك",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        fontWeight: MyFontWeight.regular,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 15,
                right: 15,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomPaint(
            painter: BordersDotted(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 29),
              height: 148,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffFAF5FF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "كود المشاركة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: MyFontWeight.semiBold,
                      color: Color(0xff4A5565),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "STAR2024",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: MyFontWeight.light,
                          color: Theme.of(context).primaryColor,
                        ),
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
                            radius: 8,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: "4545454"));
                              AppSnackBar.info("تم النسخ الى الحافضة");
                            },
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 16,
                            ),
                            lable: "نسخ",
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ButtonAppWidget(
                            radius: 8,
                            color: Color(0xff3D4DFF),
                            onPressed: () async {
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              await SharePlus.instance.share(
                                ShareParams(
                                  text: message,
                                  subject: "كود دعوة 🎁",
                                  sharePositionOrigin:
                                      box!.localToGlobal(Offset.zero) &
                                      box.size,
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
          ),
        ),

        SizedBox(height: 15),
        Text(
          textAlign: TextAlign.center,
          "كيف تستفيد من الكود؟",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 14,
            fontWeight: MyFontWeight.regular,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        cardWidget(
          context,
          "شارك الكود مع أصدقائك",
          "عندما يسجل صديقك باستخدام كودك، يحصل على خصم خاص",
          AppIcons.peopleIcon,
          Color(0xff2B7FFF),
        ),
        cardWidget(
          context,
          "اكسب مكافآت مالية",
          "احصل على 20% من قيمة اشتراك صديقك كهدية نقدية",
          AppIcons.dollar,
          Color(0xff00C950),
        ),
        cardWidget(
          context,
          "دعوات غير محدودة",
          "لا يوجد حد أقصى! كلما دعوت أكثر، كسبت أكثر",
          AppIcons.gift,
          Color(0xffAD46FF),
        ),
        SizedBox(height: 50),
      ],
    );
  }

  Widget cardWidget(
    BuildContext context,
    title,
    descrption,
    icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withAlpha(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(child: Image.asset(icon, width: 24)),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff262626),
                    fontWeight: MyFontWeight.light,
                    fontSize: 11,
                  ),
                ),
                Text(
                  descrption,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Color(0xff262626),
                    fontWeight: MyFontWeight.light,
                    fontSize: 10,
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

final message = '''
🎁 هدية خاصة لك!
استخدم كود الدعوة الخاص بي:

🔑 dsdsd6565

وسجّل الآن واحصل على خصم 🎉
''';
