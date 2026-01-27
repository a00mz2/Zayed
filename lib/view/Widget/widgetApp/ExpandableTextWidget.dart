import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  final int trimLines;

  ExpandableTextWidget({
    super.key,
    required this.text,
    this.trimLines = 3,
  });

  final RxBool isExpanded = false.obs;

  void toggle() => isExpanded.value = !isExpanded.value;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 14,
      color: const Color(0xff6E615E),
      fontWeight: MyFontWeight.light,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // ✅ حساب overflow خارج Obx (يعتمد على constraints)
        final span = TextSpan(text: text, style: textStyle);
        final tp = TextPainter(
          text: span,
          maxLines: trimLines,
          textDirection: TextDirection.rtl,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflow = tp.didExceedMaxLines;

        // ✅ Obx هنا حتى يقرأ isExpanded.value داخل نطاقه المباشر
        return Obx(() {
          final expanded = isExpanded.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: textStyle,
                maxLines: expanded ? null : trimLines,
                overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
              ),
              if (isOverflow)
                GestureDetector(
                  onTap: toggle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      expanded ? "عرض أقل" : "عرض المزيد",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xFF231F1E),
                        fontWeight: MyFontWeight.medium,
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
