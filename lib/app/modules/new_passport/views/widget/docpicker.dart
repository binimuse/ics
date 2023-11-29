import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:sizer/sizer.dart';

class BuildDoc extends StatefulWidget {
  final CommonIDModel documentType;
  final NewPassportController controller;

  const BuildDoc({required this.documentType, required this.controller});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDoc> {
  bool isUploading = false;
  double uploadProgress = 0.0;

  Future<void> openPdfPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension == 'pdf') {
        setState(() {
          widget.controller.documents
              .firstWhere(
                  (element) => element.documentTypeId == widget.documentType.id)
              .files
              .clear(); // Clear the existing files

          widget.controller.documents
              .firstWhere(
                  (element) => element.documentTypeId == widget.documentType.id)
              .files
              .add(file);

          widget.controller.geturl(
            widget.controller.documents.first.documentTypeId,
            widget.controller.documents.first.files.first,
          );
        });
      } else {
        AppToasts.showError("Invalid File!!");
      }
    } else {
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
      child: Container(
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
                          element.documentTypeId == widget.documentType.id)
                      .files
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    final file = widget.controller.documents
                        .firstWhere((element) =>
                            element.documentTypeId == widget.documentType.id)
                        .files[index];
                    return Stack(
                      children: [
                        Obx(() => !widget.controller.isSendDocStarted.value
                            ? Container(
                                height: 25.h,
                                child: PDFView(
                                  filePath: file.path!,
                                ),
                              )
                            : Container(
                                height: 25.h,
                                color: Colors.black54,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )),
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

  void deleteFile(int index) {
    setState(() {
      widget.controller.documents
          .firstWhere(
              (element) => element.documentTypeId == widget.documentType.id)
          .files
          .removeAt(index);
    });
  }
}
