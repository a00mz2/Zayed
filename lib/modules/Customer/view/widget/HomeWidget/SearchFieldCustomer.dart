import 'package:flutter/material.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/icons.dart';

class SearchFieldCustomer extends StatelessWidget {
  const SearchFieldCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(640),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.research,
            width: 20,
            height: 20,
          ),
          SizedBox(width: 8),
          Text(
            "عن ماذا تبحث؟",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0xff747474),
                  fontWeight: MyFontWeight.semiBold,
                  fontSize: 12,
                ),
          )
        ],
      ),
    );
  }
}
