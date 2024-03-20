import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/common/fileupload/pdfpicker.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/ics_visa_application.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_viewer.dart';
import 'package:ics/gen/assets.gen.dart';

class ItemDocVisa extends StatefulWidget {
  const ItemDocVisa({
    super.key,
    required this.title,
    required this.listOfDoc,
    required this.documentType,
    required this.applicationId,
    required this.controller,
  });

  final String title;

  final List<VisaApplicationDocument> listOfDoc;

  final MyOrderController controller;
  final String applicationId;
  final CurrentCountry documentType;

  @override
  State<ItemDocVisa> createState() => _ItemFaqState();
}

class _ItemFaqState extends State<ItemDocVisa> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => widget.controller.networkStatus.value != NetworkStatus.LOADING
            ? Column(
                children: [
                  ///BUILD TOP VIEW
                  buildTopView(),

                  Divider(
                    color: AppColors.grayLighter,
                    thickness: 1.0,
                    height: 1.0,
                  ),

                  ///BUILD EXPANDED VIEW
                  buildExpandedView(),
                ],
              )
            : CustomLoadingWidget());
  }

  Padding buildTopView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_6,
        vertical: AppSizes.mp_v_1,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icons.paper,
            color: isExpanded ? AppColors.primary : AppColors.grayDefault,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Text(
              widget.title,
              style: isExpanded
                  ? AppTextStyles.bodyLargeBold.copyWith(
                      color: AppColors.blackLight,
                    )
                  : AppTextStyles.bodyLargeRegular.copyWith(
                      color: AppColors.blackLight,
                    ),
            ),
          ),
          widget.listOfDoc[0].reviewStatus.contains("REJECTED")
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
          IconButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: SvgPicture.asset(
              isExpanded ? Assets.icons.chevronDown : Assets.icons.chevronRight,
              width: AppSizes.icon_size_6,
              color: AppColors.grayDefault,
            ),
          ),
        ],
      ),
    );
  }

  buildExpandedView() {
    return isExpanded
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: AppColors.grayLight,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_6,
                vertical: AppSizes.mp_w_1,
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_1 * 0.7,
                ),
                itemBuilder: (context, index) {
                  return buildPDFViewer(widget.listOfDoc[index]);
                },
                itemCount: widget.listOfDoc.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: AppSizes.mp_v_4 * 0.8,
                  );
                },
              ),
            ),
          )
        : const SizedBox();
  }

  buildPDFViewer(VisaApplicationDocument document) {
    return BuildDocViewer(
      pdfPath: document.files.path,
      reviewStatus: document.reviewStatus,
      documentType: document.documentType,
      controller: widget.controller,
      applicationId: widget.applicationId,
      rejected_reason: document.rejecterNote.toString(),
    );
  }

  openPdfPicker() async {
    widget.controller.isSendStared.value = true;

    widget.controller.networkStatus.value = NetworkStatus.LOADING;
    try {
      PlatformFile? pickedFile = await PdfPicker.pickPdfFile();
      if (pickedFile != null) {
        try {
          handleFilePickedSuccess(pickedFile);
        } catch (e, s) {
          widget.controller.networkStatus.value = NetworkStatus.ERROR;
          widget.controller.isSendStared.value = false;
          AppToasts.showError("error  while getting the URL.");

          print("Error in geturl: $s");
        }
      }
    } catch (e) {
      widget.controller.networkStatus.value = NetworkStatus.ERROR;
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
      widget.controller.sendDoc(
          widget.documentType.id, responseUrl, widget.applicationId, true);
    } else {
      widget.controller.networkStatus.value = NetworkStatus.ERROR;
      // Response is not successful
      print('Response is false');
    }

    // Update the state
  }
}
