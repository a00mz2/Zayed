// ignore_for_file: avoid_print, unnecessary_null_comparison, must_be_immutable, file_names, deprecated_member_use

//in controller
// Rxn<File> imageElmint = Rxn<File>();

//in view

// image: controller.imageElmint.value,
// onImagePicked: (File newImage) {
// controller.imageElmint.value = newImage;  // update observable
// },

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zayed/core/class/BordersDotted.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';

class ImageInput extends StatelessWidget {
  ImageInput({
    super.key,
    required this.image,
    required this.onImagePicked,
    this.height,
    this.pathImage,
  });
  final Function(Uint8List) onImagePicked;
  Uint8List? image;
  final double? height;
  final String? pathImage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final XFile? images = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (images != null) {
          image = await images.readAsBytes();
          onImagePicked(image!);
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
            // ===== dashed border =====
            Positioned.fill(
              child: CustomPaint(
                painter: BordersDotted(
                  color: Theme.of(context).primaryColor,
                  radius: 30,
                ),
              ),
            ),

            // ===== المحتوى =====
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(
                  image!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              )
            else if (pathImage != null && pathImage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  pathImage!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder(context);
                  },
                ),
              )
            else
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
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "اضف صورة القسم",
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
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Icon(Icons.broken_image_rounded, color: Colors.grey, size: 30),
    );
  }
}
