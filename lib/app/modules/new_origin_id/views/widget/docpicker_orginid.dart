import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';

import 'package:sizer/sizer.dart';
import 'dart:io';

import '../../data/model/base_model_orgin.dart';

class BuildDocOrginID extends StatefulWidget {
  final CommonModel documentType;
  final NewOriginIdController controller;

  const BuildDocOrginID({required this.documentType, required this.controller});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDocOrginID> {
  bool isUploading = false;
  double uploadProgress = 0.0;
  bool hasError = false;

  Future<void> openPdfPicker() async {
    widget.controller.isSendStared.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension == 'pdf') {
        File pickedFile = File(file.path!);
        int fileSize = await pickedFile.length();

        if (fileSize <= 10 * 1024 * 1024) {
          // Check if file size is within the limit
          try {
            setState(() {
              widget.controller.documents
                  .firstWhere((element) =>
                      element.documentTypeId == widget.documentType.id)
                  .files
                  .clear(); // Clear the existing files

              widget.controller.documents
                  .firstWhere((element) =>
                      element.documentTypeId == widget.documentType.id)
                  .files
                  .add(file);

              widget.controller.geturl(
                widget.documentType.id,
                widget.controller.documents.first.files.first,
              );
            });
            widget.controller.isSendStared.value = false;
          } catch (e) {
            setState(() {
              hasError = true;
            });
            widget.controller.isSendStared.value = false;
            AppToasts.showError("error  while getting the URL.");

            print("Error in geturl: $e");
          }
        } else {
          widget.controller.isSendStared.value = false;
          AppToasts.showError("File size exceeds the limit of 10MB!");
        }
      } else {
        widget.controller.isSendStared.value = false;
        AppToasts.showError("Invalid File!!");
      }
    } else {
      widget.controller.isSendStared.value = false;
      AppToasts.showError("File Not picked!!");
      // User canceled the file picking
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add a flag to track loading state

    return InkWell(
      onTap: () {
        openPdfPicker();
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
                                height: 20.h,
                                child: PDFView(
                                  filePath: file.path!,
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
}
