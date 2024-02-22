// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/dialogs/upload_dilaog.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'dart:io';

class PhotoUpload extends StatelessWidget {
  PhotoUpload({Key? key, required this.selectedImages, required this.photoPath})
      : super(key: key);

  final RxList<File> selectedImages;
  RxList<String> photoPath;

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
                showImage(imageFile)
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
                      selectedImages.removeAt(0);
                      //imageFile.deleteSync();
                      photoPath.removeAt(0);
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
          onUpload: _showBottomNavigationSheet,
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

  void _showBottomNavigationSheet() {
    Get.bottomSheet(
      backgroundColor: AppColors.whiteOff,
      Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(
                Icons.camera,
                color: AppColors.primary,
              ),
              title: Text(
                'Pick from Camera',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              onTap: () {
                Get.back();
                _pickFromCamera();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: Text(
                'Pick from Gallery',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              onTap: () {
                Get.back();
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final PlatformFile pickedFile = PlatformFile(
        path: image.path,
        name: image.name,
        size: 0,
        bytes: null,
      );

      final int maxSizeInBytes = 30 * 1024 * 1024; // 10 MB

      try {
        if (pickedFile.size <= maxSizeInBytes) {
          handleFilePickedSuccess(pickedFile);
        } else {
          AppToasts.showError("Invalid File, Please select an Image.");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void _pickFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final PlatformFile pickedFile = PlatformFile(
        path: image.path,
        name: image.name,
        size: 0,
        bytes: null,
      );

      final int maxSizeInBytes = 30 * 1024 * 1024; // 10 MB

      try {
        if (pickedFile.size <= maxSizeInBytes) {
          handleFilePickedSuccess(pickedFile);
        } else {
          AppToasts.showError("Invalid File, Please select an Image.");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  Widget showImage(dynamic path) {
    Widget imageWidget;

    if (path is File) {
      // Determine if the path is a local file or network URL
      Uri? uri;
      try {
        uri = Uri.parse(path.path);
      } catch (e) {
        uri = null;
      }

      if (uri != null && uri.isAbsolute) {
        // Selected image is from a network URL
        imageWidget = Container(
          width: 26.w,
          height: 15.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: uri.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      } else {
        // Selected image is from a local file
        imageWidget = Container(
          width: 26.w,
          height: 15.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              path,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    } else {
      // Invalid image path or URL
      imageWidget = Container(); // or any other placeholder widget
    }

    return imageWidget;
  }

  handleFilePickedSuccess(PlatformFile pickedFile) async {
    print("bini ${pickedFile}");
    // Perform the async operations

    MinioUploader uploader = MinioUploader();
    String responseUrl = await uploader.uploadFileToMinio(pickedFile, "");

    if (responseUrl.isNotEmpty) {
      selectedImages.add(File(pickedFile.path!));
      photoPath.clear();
      photoPath.add(responseUrl);

      // Response is successful
    } else {
      // Response is not successful
      print('Response is false');
    }
  }
}
