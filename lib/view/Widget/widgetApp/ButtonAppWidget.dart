// ignore_for_file: sort_child_properties_last, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:zayed/core/class/statusRequest.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class ButtonAppWidget extends StatelessWidget {
  const ButtonAppWidget({
    super.key,
    this.onPressed,
    this.primaryButton = true,
    this.lable,
    this.statusRequest,
    this.color,
    this.icon,
    this.textColor,
    this.radius = 12,
    this.fontWeight,
    this.fontSize = 14,
    this.elevation,
  });

  final bool? primaryButton;
  final String? lable;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final StatusRequest? statusRequest;

  final double? radius;

  final FontWeight? fontWeight;
  final double? fontSize;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      color: (primaryButton == false
          ? null
          : color ?? Theme.of(context).primaryColor),
      onPressed: statusRequest != StatusRequest.loading ? onPressed : null,
      height: 48,
      minWidth: double.infinity,
      shape: color != null && primaryButton != false
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!))
          : RoundedRectangleBorder(
              side: primaryButton == false
                  ? BorderSide(color: color ?? Theme.of(context).primaryColor)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(radius!),
            ),

      child: statusRequest != StatusRequest.loading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                icon ?? SizedBox(),
                Text(
                  lable.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: fontSize,
                    fontWeight: fontWeight ?? MyFontWeight.semiBold,
                    color: primaryButton == false
                        ? textColor ?? Theme.of(context).primaryColor
                        : textColor ?? Colors.white,
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color:
                    textColor ??
                    (primaryButton!
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
            ),

      disabledColor: primaryButton!
          ? Theme.of(context).primaryColor.withOpacity(0.6)
          : Colors.transparent,
    );
  }
}
