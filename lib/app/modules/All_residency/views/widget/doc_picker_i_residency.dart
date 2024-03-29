import 'dart:io';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/common/fileupload/pdfpicker.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';

import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class BuildDoc_Residency extends StatefulWidget {
  final CommonModel documentType;
  final AllResidencyController controller;

  const BuildDoc_Residency(
      {required this.documentType, required this.controller});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDoc_Residency> {
  bool isUploading = false;
  double uploadProgress = 0.0;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    // Add a flag to track loading state

    return InkWell(
      onTap: () {
        _showBottomNavigationSheet();
        // ();
      },
      child: hasError
          ? Container() // Return an empty Container when there's an error
          : Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLighter.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_copy,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Upload ${widget.documentType.name}',
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.controller.documents
                            .firstWhere((element) =>
                                element.documentTypeId ==
                                widget.documentType.id)
                            .files
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          final file = widget.controller.documents
                              .firstWhere((element) =>
                                  element.documentTypeId ==
                                  widget.documentType.id)
                              .files[index];
                          return Stack(
                            children: [
                              Container(
                                height: 18.h,
                                child: isPDFFile(file)
                                    ? PDFView(
                                        filePath: file.path!,
                                      )
                                    : Image.file(
                                        fit: BoxFit.fitWidth,
                                        File(file.path!),
                                      ),
                              ),
                              Positioned(
                                top: 8.0,
                                right: 8.0,
                                child: GestureDetector(
                                  onTap: () => deleteFile(index),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ))
                ],
              ),
            ),
    );
  }

  bool isPDFFile(PlatformFile file) {
    final extension = file.path!.split('.').last.toLowerCase();
    return extension == 'pdf';
  }

  void deleteFile(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Delete".tr,
            style: AppTextStyles.bodyLargeBold,
          ),
          content: Text(
            "Are you sure you want to delete the file?".tr,
            textAlign: TextAlign.start,
            style: AppTextStyles.captionRegular,
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Cancel".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(true); // Return true if delete is pressed
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.danger,
                      AppColors.danger,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Delete".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      widget.controller.deleteDoc(widget.documentType.id);

      setState(() {
        widget.controller.documents
            .where(
                (element) => element.documentTypeId == widget.documentType.id)
            .forEach((element) {
          element.files.removeAt(index);
        });
      });
    }
  }

  Future<void> _handleFilePickedSuccess(PlatformFile pickedFile) async {
    // Perform the async operations
    widget.controller.documents
        .firstWhere(
            (element) => element.documentTypeId == widget.documentType.id)
        .files
        .clear(); // Clear the existing files

    widget.controller.documents
        .firstWhere(
            (element) => element.documentTypeId == widget.documentType.id)
        .files
        .add(pickedFile);
    MinioUploader uploader = MinioUploader();
    String responseUrl =
        await uploader.uploadFileToMinio(pickedFile, widget.documentType.id!);

    if (responseUrl.isNotEmpty) {
      // Response is successful

      widget.controller.docList.add(
          DocPathModel(path: responseUrl, docTypeId: widget.documentType.id));
      widget.controller.networkStatus.value = NetworkStatus.SUCCESS;
      setState(() {});
    } else {
      widget.controller.networkStatus.value = NetworkStatus.ERROR;
      // Response is not successful
      print('Response is false');
    }

    // Call setState to update the state
    // setState(() {
    //   widget.controller.isSendStared.value = false;
    // });
  }

  void _showBottomNavigationSheet() {
    Get.bottomSheet(
      backgroundColor: AppColors.whiteOff,
      Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(
                Icons.file_copy,
                color: AppColors.primary,
              ),
              title: Text(
                'Pick from File',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              onTap: () {
                Get.back();
                openPdfPicker();
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

  void _pickFromGallery() async {
    widget.controller.networkStatus.value = NetworkStatus.LOADING;

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
          _handleFilePickedSuccess(pickedFile);
          widget.controller.networkStatus.value = NetworkStatus.ERROR;
        } else {
          widget.controller.networkStatus.value = NetworkStatus.ERROR;
          AppToasts.showError("Invalid File, Please select an Image.");
        }
      } catch (e) {
        widget.controller.networkStatus.value = NetworkStatus.ERROR;

        print("Error: $e");
      }
    }
  }

  Future<void> openPdfPicker() async {
    widget.controller.networkStatus.value = NetworkStatus.LOADING;

    try {
      PlatformFile? pickedFile = await PdfPicker.pickPdfFile();
      if (pickedFile != null) {
        try {
          _handleFilePickedSuccess(pickedFile);
        } catch (e, s) {
          widget.controller.networkStatus.value = NetworkStatus.ERROR;

          AppToasts.showError("error  while getting the URL.");

          print("Error in geturl: $s");
        }
      }
    } catch (e) {
      widget.controller.networkStatus.value = NetworkStatus.ERROR;

      // Handle the error
      print("Error: $e");
    }
  }
}
