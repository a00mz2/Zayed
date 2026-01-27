// ignore_for_file: deprecated_member_use, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zayed/core/constant/assets/lottie.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.lable,
    this.value,
    required this.icon,
    this.fontSizeValue = 14,
    this.fontSizeLable = 13,
    this.horizontaPadding = 10,
    this.verticalPadding = 10,
    this.fontWeightLable = FontWeight.w300,
    this.fontWeightValue = FontWeight.w600,
    this.valueColor = const Color(0xff231F1E),
  });

  final String lable, icon;
  final value;
  final Color? valueColor;
  final double? fontSizeValue, fontSizeLable;
  final double? horizontaPadding, verticalPadding;

  final FontWeight? fontWeightLable, fontWeightValue;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Lottie.asset(
              AppLottie.lodingcover,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 90,
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontaPadding!,
              vertical: verticalPadding!,
            ),
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(color: Color(0xffE7E4E4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        value.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: valueColor!,
                          fontSize: fontSizeValue,
                          fontWeight: fontWeightValue,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset(
                          color: Colors.white,
                          icon,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  lable,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: fontSizeLable,
                    fontWeight: fontWeightLable,
                  ),
                ),
              ],
            ),
          );
  }
}

class ListStatusCard extends StatelessWidget {
  const ListStatusCard({
    super.key,
    required this.data,
    this.marginhorizontal = 16,
  });
  final List data;
  final double? marginhorizontal;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: false,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            right: index == 0 ? marginhorizontal! : 0,
            left: index == data.length - 1 ? marginhorizontal! : 0,
          ),
          child: StatusCard(
            lable: data[index]["lable"],
            value: data[index]["value"].toString(),
            icon: data[index]["icon"],
          ),
        ),

        separatorBuilder: (context, index) => SizedBox(width: 8),
      ),
    );
  }
}
