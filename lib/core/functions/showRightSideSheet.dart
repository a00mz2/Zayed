// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';

Future<void> showBottomSlideSheet(
  context,
  Widget child, {
  double? height,
  void Function()? onStartup,
  void Function()? onClosing,
  Color? color = Colors.white,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      onStartup?.call();

      return WillPopScope(
        onWillPop: () async {
          onClosing?.call();
          return true;
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  height: height,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (context, animation, secAnimation, child) {
      final slide = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      return SlideTransition(position: slide, child: child);
    },
  );
}
