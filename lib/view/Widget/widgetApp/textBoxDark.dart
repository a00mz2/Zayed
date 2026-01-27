// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/functions/validinput.dart';

class TextBoxDark extends StatelessWidget {
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

  final Function()? onTap;

  final Color? backgroundColorl;

  final int? minValue;
  final int? maxValue;
  final bool? readOnly;

  const TextBoxDark({
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
    this.onTap,
    this.backgroundColorl = const Color(0xffF4F4F5),
    this.minValue,
    this.maxValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,

      onTap: onTap,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: type ?? TextInputType.text,
      inputFormatters: [
        type != null
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
        if (type == TextInputType.number &&
            (minValue != null || maxValue != null))
          MinMaxInputFormatter(min: minValue, max: maxValue),
      ],
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        // الخلفية بيضاء
        filled: true,
        fillColor: Color(0xffF4F4F5),
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
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: prefixIcon,
        ),

        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 10),

        // أيقونة عرض/إخفاء كلمة السر إذا موجودة
        suffixIcon: suffixIcon == null && showPassword == null
            ? null
            : SizedBox(
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
          borderSide: BorderSide(color: Colors.transparent, width: 0),
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
          borderSide: BorderSide(color: Colors.transparent, width: 0),
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

class MinMaxInputFormatter extends TextInputFormatter {
  final int? min;
  final int? max;

  MinMaxInputFormatter({this.min, this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // السماح بالحقل الفارغ أثناء الكتابة
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    if (min != null && value < min!) {
      return oldValue;
    }

    if (max != null && value > max!) {
      return oldValue;
    }

    return newValue;
  }
}
