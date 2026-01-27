import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:zayed/core/class/BordersDotted.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class MultiImageInputMobile extends StatelessWidget {
  const MultiImageInputMobile({
    super.key,
    required this.images,
    required this.onImagesChanged,
    this.onImageDeleted,
    this.pathImage,
    this.height,
  });

  final List<dynamic> images;
  final Function(List<dynamic>) onImagesChanged;
  final Function(String, String?)? onImageDeleted;
  final String? pathImage;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            try {
              final ImagePicker picker = ImagePicker();
              final List<XFile> pickedFiles = await picker.pickMultiImage();

              if (pickedFiles.isNotEmpty) {
                List<Uint8List> compressedImages = [];

                for (var picked in pickedFiles) {
                  final bytes = await picked.readAsBytes();
                  final compressed = await _compressImageMobile(bytes);

                  if (compressed != null) {
                    compressedImages.add(compressed);
                  }
                }
                onImagesChanged([...images, ...compressedImages]);
              }
            } catch (e) {
              debugPrint("Error picking images: $e");
            }
          },
          child: Container(
            width: double.infinity,
            height: height ?? 129,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ===== dotted border =====
                Positioned.fill(
                  child: CustomPaint(
                    painter: BordersDotted(
                      color: Theme.of(context).primaryColor,
                      radius: 30,
                    ),
                  ),
                ),

                // ===== المحتوى =====
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "اضف صور المنتج",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color(0xff51515A),
                        fontSize: 13,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        if (images.isNotEmpty)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(images.length, (index) {
              final img = images[index];

              String? displayUrl;
              String? imageId;

              // معالجة البيانات إذا كانت Map (قادمة من السيرفر)
              if (img is Map) {
                displayUrl = img['url']?.toString();
                imageId = img['_id']?.toString();
              }

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: img is Uint8List
                            ? MemoryImage(img) // صورة جديدة
                            : NetworkImage(displayUrl ?? "")
                                  as ImageProvider, // صورة من السيرفر
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final updated = [...images]..removeAt(index);
                      onImagesChanged(updated);

                      // استدعاء الحذف للصور التي لها بيانات في السيرفر
                      if (img is Map) {
                        // نرسل الـ url والـ id للكنترولر
                        onImageDeleted?.call(displayUrl ?? "", imageId);
                      }
                    },
                    child: _deleteIcon(),
                  ),
                ],
              );
            }),
          ),
      ],
    );
  }

  Future<Uint8List?> _compressImageMobile(Uint8List list) async {
    try {
      final result = await FlutterImageCompress.compressWithList(
        list,
        minHeight: 800,
        minWidth: 800,
        quality: 80,
      );
      return result;
    } catch (e) {
      debugPrint("Compression error: $e");
      return list;
    }
  }

  Widget _deleteIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      child: const Icon(Icons.close, color: Colors.white, size: 18),
    );
  }
}
