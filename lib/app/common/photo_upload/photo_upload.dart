import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/dialogs/upload_dilaog.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'dart:io';

class PhotoUpload extends StatelessWidget {
  const PhotoUpload({Key? key, required this.selectedImages}) : super(key: key);

  final RxList<File> selectedImages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getImageFromGallery(context),
        ],
      ),
    );
  }

  Widget getImageFromGallery(BuildContext context) {
    return InkWell(
      onTap: () {
        showUploadDialog(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Recent Passport Size Photo'.tr,
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
              getImage(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      final int maxSizeInBytes = 10 * 1024 * 1024; // 10 MB

      try {
        int fileSize = await file.length();
        if (fileSize <= maxSizeInBytes) {
          selectedImages.add(file);
        } else {
          AppToasts.showError("Invalid File, Please select an Image.");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  Widget getImage(BuildContext context) {
    return Obx(() {
      final imageFile = selectedImages.isNotEmpty ? selectedImages.first : null;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (imageFile != null) {
              // _showImageInPopup(imageFile);
            } else {
              showUploadDialog(context);
            }
          },
          child: Stack(
            children: [
              if (imageFile != null)
                Container(
                  width: 26.w,
                  height: 15.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: 13.h,
                  height: 15.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey,
                  ),
                ),
              if (imageFile != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      print(imageFile);
                      if (imageFile != null) {
                        selectedImages.removeAt(0);
                        imageFile.deleteSync();
                      } else {
                        AppToasts.showError("No image selected");
                      }
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  void showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadDialog(
          onUpload: _getFromGallery,
          title: 'Note info:'.tr,
          contentTexts: [
            'Photos width should be  355pixel-500pixel and height should be  485 pixel-  500 pixel.'
                .tr,
            'Headphones, wireless hands-free devices or similar items are not acceptable in your photo.'
                .tr,
            'Taken within the last  6 months to reflect your current appearance.'
                .tr,
          ],
          imagePath: AppAssets.passportImage,
        );
      },
    );
  }
}
