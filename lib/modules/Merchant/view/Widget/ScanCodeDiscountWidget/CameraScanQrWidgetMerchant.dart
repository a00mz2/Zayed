// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zayed/modules/Merchant/controller/ScanCodeDiscountControllerMerchant.dart';

class CameraScanQrWidgetMerchant extends StatelessWidget {
  CameraScanQrWidgetMerchant({super.key, required this.contextMain});

  final controller = Get.find<ScanCodeDiscountControllerMerchant>();

  final BuildContext contextMain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 277,
        height: 277,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(32),
                child: MobileScanner(
                  controller: controller.qrController,
                  fit: BoxFit.cover, // مهم
                  onDetect: (barcode) async {
                    final code = barcode.barcodes.first.rawValue;
                    if (code != null) {
                      await controller.verifyInvoice(
                        code,
                        contextMain,
                        fromQr: true,
                      );
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(32),

                    child: CustomPaint(
                      size: const Size(290, 290),
                      painter: InnerRoundedBorderPainter(
                        holeSize: 190,
                        radius: 32,
                        thickness: 50,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),

                  ScannerCorners(size: 190),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerCorners extends StatelessWidget {
  final double size;

  const ScannerCorners({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ScannerCornerPainter(
        color: const Color(0xFFE60073),
        strokeWidth: 6,
        cornerLength: 15,
        radius: 28,
      ),
    );
  }
}

class ScannerCornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;
  final double radius;

  ScannerCornerPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLength,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap
          .round // ⭐ نهايات ناعمة
      ..strokeJoin = StrokeJoin.round;

    // ┏ Top Left
    canvas.drawArc(
      Rect.fromLTWH(0, 0, radius * 2, radius * 2),
      3.14,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(Offset(radius, 0), Offset(radius + cornerLength, 0), paint);
    canvas.drawLine(Offset(0, radius), Offset(0, radius + cornerLength), paint);

    // ┓ Top Right
    canvas.drawArc(
      Rect.fromLTWH(size.width - radius * 2, 0, radius * 2, radius * 2),
      -1.57,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - radius, 0),
      Offset(size.width - radius - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, radius),
      Offset(size.width, radius + cornerLength),
      paint,
    );

    // ┗ Bottom Left
    canvas.drawArc(
      Rect.fromLTWH(0, size.height - radius * 2, radius * 2, radius * 2),
      1.57,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - radius),
      Offset(0, size.height - radius - cornerLength),
      paint,
    );
    canvas.drawLine(
      Offset(radius, size.height),
      Offset(radius + cornerLength, size.height),
      paint,
    );

    // ┛ Bottom Right
    canvas.drawArc(
      Rect.fromLTWH(
        size.width - radius * 2,
        size.height - radius * 2,
        radius * 2,
        radius * 2,
      ),
      0,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - radius, size.height),
      Offset(size.width - radius - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - radius),
      Offset(size.width, size.height - radius - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class InnerRoundedBorderPainter extends CustomPainter {
  final double holeSize;
  final double radius;
  final double thickness;
  final Color color;

  InnerRoundedBorderPainter({
    required this.holeSize,
    required this.radius,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final outerRect = Rect.fromLTWH(0, 0, size.width, size.height);

    final innerRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: holeSize,
      height: holeSize,
    );

    final outerPath = Path()..addRect(outerRect);

    final innerPath = Path()
      ..addRRect(RRect.fromRectAndRadius(innerRect, Radius.circular(radius)));

    final borderPath = Path.combine(
      PathOperation.difference,
      outerPath,
      innerPath,
    );

    canvas.drawPath(borderPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
