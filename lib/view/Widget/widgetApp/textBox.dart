// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/functions/validinput.dart';

class TextBoxs extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final bool? obscureText;
  final String? typeVal;
  final Widget? prefixIcon;
  final String? hintText;
  final int? maxLength;
  final void Function(String)? onChanged;
  final int? minLines;
  final FocusNode? focusNode;

  final int? minLength;
  final int? maxLines;
  final Function()? showPassword;

  final bool? isrequired;

  final Widget? suffixIcon;

  const TextBoxs({
    super.key,
    this.controller,
    this.obscureText,
    this.showPassword,
    this.type,
    this.typeVal,
    this.maxLength,
    this.hintText,
    this.prefixIcon,
    this.minLength,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.suffixIcon,
    this.isrequired,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: type ?? TextInputType.text,
      inputFormatters: [
        type != null
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
      ],
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        // الخلفية بيضاء
        filled: true,
        fillColor: Colors.white,
        // النص المساعد (hint)
        hintText: hintText ?? "",
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          color: Color(0xFF747474),
          fontFamily: "Somar Sans",
          fontWeight: MyFontWeight.regular,
          height: 1.0,
        ),

        // أيقونة البداية
        prefixIcon: prefixIcon,

        // أيقونة عرض/إخفاء كلمة السر إذا موجودة
        suffixIcon: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              suffixIcon ??
                  (showPassword != null
                      ? InkWell(
                          onTap: showPassword ?? () {},
                          child: obscureText == true
                              ? Icon(
                                  size: 20,
                                  Icons.visibility_off_outlined,
                                  color: Color(0xFF7C7C7C),
                                )
                              : Icon(
                                  size: 20,
                                  Icons.visibility_outlined,
                                  color: Color(0xFF7C7C7C),
                                ),
                        )
                      : const SizedBox()),
              SizedBox(width: 10),
            ],
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),

        // الحدود
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xffD5D5D5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 16,
        color: Colors.black87,
        fontFamily: "Somar Sans",
        fontWeight: MyFontWeight.light,
      ),
      validator: (value) {
        return validInput(
          value!,
          minLength ?? 0,
          maxLength ?? 100,
          typeVal.toString(),
          isrequired: isrequired ?? true,
        );
      },
      onChanged: onChanged,
    );
  }
}
