import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/common/fileupload/pdfpicker.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

import 'package:ics/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class BuildDocViewer extends StatefulWidget {
  final String pdfPath;
  final String reviewStatus;
  final String applicationId;
  final CurrentCountry documentType;
  final MyOrderController controller;

  const BuildDocViewer(
      {required this.pdfPath,
      required this.reviewStatus,
      required this.controller,
      required this.applicationId,
      required this.documentType});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDocViewer> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          //  margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(18))),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.file_present,
                  color: Colors.lightBlue[900],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 4.h,
                      width: 18.w,
                      decoration: BoxDecoration(
                        color:
                            widget.reviewStatus.toString().contains("REJECTED")
                                ? AppColors.danger
                                : AppColors.warning,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.reviewStatus.toString(),
                            style: AppTextStyles.bodySmallBold.copyWith(
                                color: AppColors.whiteOff,
                                fontSize: AppSizes.font_10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.reviewStatus.toString().contains("REJECTED")
                  ? GestureDetector(
                      onTap: () {
                        openPdfPicker();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.upload,
                              color: AppColors.primary,
                            ),
                            Text("Re-Upload",
                                style: AppTextStyles.menuRegular.copyWith(
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: () {
                  _showAreYouSureDialog(context, widget.pdfPath);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.remove_red_eye,
                        color: AppColors.primary,
                      ),
                      Text("View",
                          style: AppTextStyles.menuRegular.copyWith(
                            color: AppColors.primary,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      shrinkWrap: true,
      itemCount: 1,
      padding: const EdgeInsets.all(0),
      controller: ScrollController(keepScrollOffset: false),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 2.h,
        );
      },
    );
  }

  void _showAreYouSureDialog(
    BuildContext context,
    String pdfPath,
  ) {
    print(Constants.fileViewer + pdfPath);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 50.h,
              child:
                  PDF(swipeHorizontal: true, enableSwipe: true).cachedFromUrl(
                Constants.fileViewer + pdfPath,
                placeholder: (progress) => Center(child: Text('$progress %')),
                errorWidget: (error) => Center(child: Text('PDF Not Found')),
              ),
            )
          ],
        );
      },
    );
  }

  openPdfPicker() async {
    widget.controller.isSendStared.value = true;
    try {
      PlatformFile? pickedFile = await PdfPicker.pickPdfFile();
      if (pickedFile != null) {
        try {
          handleFilePickedSuccess(pickedFile);
        } catch (e, s) {
          widget.controller.isSendStared.value = false;
          AppToasts.showError("error  while getting the URL.");

          print("Error in geturl: $s");
        }
      }
    } catch (e) {
      widget.controller.isSendStared.value = false;
      // Handle the error
      print("Error: $e");
    }
  }

  void handleFilePickedSuccess(PlatformFile pickedFile) {
    // Move the async code outside of setState
    _handleFilePickedSuccess(pickedFile);
  }

  Future<void> _handleFilePickedSuccess(PlatformFile pickedFile) async {
    MinioUploader uploader = MinioUploader();
    String responseUrl =
        await uploader.uploadFileToMinio(pickedFile, widget.documentType.id);

    if (responseUrl.isNotEmpty) {
      // Response is successful
      print(responseUrl);
      widget.controller.sendDoc(
        widget.documentType.id,
        responseUrl,
        widget.applicationId,
      );
    } else {
      // Response is not successful
      print('Response is false');
    }

    // Update the state
    widget.controller.isSendStared.value = false;
  }
}
