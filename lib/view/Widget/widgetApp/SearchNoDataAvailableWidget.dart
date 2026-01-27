import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class SearchNoDataAvailableWidget extends StatelessWidget {
  const SearchNoDataAvailableWidget({
    super.key,
    this.bodyText = "لم نتمكن من العثور على نتائج مطابقة للبحث",
    this.buttonLable = "اعادة تعيين",
    this.assets,
    this.onPressed,
  });

  final String? bodyText;
  final String? buttonLable;
  final Widget? assets;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(child: assets ?? Lottie.asset(AppLottie.failsearch)),
          SizedBox(height: 5),
          bodyText == null
              ? SizedBox()
              : Center(
                  child: Text(
                    bodyText.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: MyFontWeight.regular,
                      fontSize: 12,
                    ),
                  ),
                ),
          SizedBox(height: 20),
          onPressed == null
              ? SizedBox()
              : Center(
                  child: SizedBox(
                    width: 160,
                    height: 35,
                    child: ButtonAppWidget(
                      color: Color(0xffE5E5E5),
                      textColor: Color(0xff6A7282),
                      primaryButton: false,
                      onPressed: onPressed,
                      lable: buttonLable,
                    ),
                  ),
                ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
