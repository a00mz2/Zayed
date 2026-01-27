// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.hintText = "اختر عنصرًا",
    this.prefixIcon,
    this.validator = true,
  });

  final List<T> items;
  final T? selectedItem;
  final void Function(T value) onChanged;
  final String Function(T item) itemLabelBuilder;
  final String hintText;
  final Widget? prefixIcon;
  final bool? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        isExpanded: true,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 241, 241, 241),
          prefixIcon: prefixIcon != null
              ? SizedBox(width: 24, height: 24, child: prefixIcon)
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),

          // ✅ فقط لإخفاء نص الخطأ (ويبقى الإطار الأحمر يظهر)
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          errorMaxLines: 1,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 1.2),
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

        hint: Text(
          hintText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            color: const Color(0xFF7C7C7C),
            fontWeight: MyFontWeight.light,
            height: 1.0,
          ),
        ),

        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7C7C7C)),

        validator: (value) {
          if (items.isEmpty || (value == null && validator!)) {
            return ""; // ✅ نرجّع نص فارغ حتى يعتبره خطأ ويظهر الإطار الأحمر فقط
          }
          return null;
        },

        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemLabelBuilder(item),

              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: MyFontWeight.light,
              ),
            ),
          );
        }).toList(),

        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}
