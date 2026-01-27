import 'package:flutter/material.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class CategoryActionsMenu extends StatelessWidget {
  const CategoryActionsMenu({super.key, required this.items});

  final List<ActionMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Icon(Icons.more_horiz, color: Colors.black, size: 18),
      itemBuilder: (context) => items
          .map(
            (item) => PopupMenuItem(
              onTap: item.onTap,
              child: Row(
                children: [
                  Image.asset(
                    item.iconPath,
                    width: 20,
                    height: 20,
                    color: item.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                      color: item.color,
                      fontWeight: MyFontWeight.regular,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class ActionMenuItem {
  final String label;
  final String iconPath;
  final Color color;
  final VoidCallback onTap;

  const ActionMenuItem({
    required this.label,
    required this.iconPath,
    required this.onTap,
    this.color = Colors.black,
  });
}
