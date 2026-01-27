import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/lottie.dart';
import 'package:zayed/view/Widget/widgetApp/ButtonAppWidget.dart';

class NoDataAvailableWidget extends StatelessWidget {
  const NoDataAvailableWidget({
    super.key,
    this.title = "لا توجد بيانات",
    this.bodyText =
        "لا يوجد بيانات في الوقت الحاضر ستضهر البيانات هنا عند توفرها ",
    this.buttonLable,
    this.assets,
    this.onPressed,
    this.physics,
  });

  final String? title;
  final String? bodyText;
  final String? buttonLable;
  final Widget? assets;
  final ScrollPhysics? physics;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: physics,
        shrinkWrap: true,
        children: [
          assets ?? Lottie.asset(AppLottie.empty, width: 150, height: 150),
          Center(
            child: Text(
              title.toString(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black,
                fontWeight: MyFontWeight.regular,
                fontSize: 14,
              ),
            ),
          ),
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
          buttonLable == null
              ? SizedBox()
              : Center(
                  child: SizedBox(
                    width: 160,
                    height: 35,
                    child: ButtonAppWidget(
                      primaryButton: false,
                      onPressed: onPressed,
                      lable: buttonLable,
                    ),
                  ),
                ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
