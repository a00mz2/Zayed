// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/assets/images.dart';

class ImageInputCircular extends StatelessWidget {
  ImageInputCircular({
    super.key,
    required this.image,
    required this.onImagePicked,
    this.height = 160,
    this.pathImage,
    this.buttonAdd,
  });
  final Function(Uint8List) onImagePicked;
  Uint8List? image;
  final double? height;
  final String? pathImage;
  final Widget? buttonAdd;

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
      child: Center(
        child: SizedBox(
          width: 135,
          height: height,
          child: Stack(
            children: [
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: image != null
                    ? Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffB5B5B5)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: MemoryImage(image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color(0xffB5B5B5)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50000),
                          child: Image.network(
                            pathImage.toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Image.asset(
                                  AppImage.Placeholder,
                                  width: 128,
                                  height: 128,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),

              buttonAdd ??
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "تحميل صورة",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: MyFontWeight.semiBold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
