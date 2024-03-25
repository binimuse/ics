import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/dialogs/upload_dilaog.dart';
import 'package:ics/app/common/dialogs/upload_dilaog_file.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/complain_page/controllers/complain_page_controller.dart';
import 'package:ics/app/modules/complain_page/data/model/base_complaint_services.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/foundation.dart';

class ComplainInquiryScreen extends StatefulWidget {
  final BaseComplaintService complainType;
  const ComplainInquiryScreen({required this.complainType, super.key});

  @override
  State<ComplainInquiryScreen> createState() => _ComplainInquiryScreenState();
}

class _ComplainInquiryScreenState extends State<ComplainInquiryScreen> {
  final ComplainPageController controller = Get.find<ComplainPageController>();
  List<String> meFile = [];
  bool uploaded = false;
  bool clicked = false;
  List<double> fileSize = [];
  // String? filePath;
  List<String> fileExtension = [];
  List<String> fileName = [];
  String capitalizeFirstLetter(String text, bool isResident) {
    if (text.isEmpty) {
      return text;
    }
    return isResident
        ? "${text[0].toUpperCase()}${text.substring(1, 8)} ${text.substring(8)}"
        : text[0].toUpperCase() + text.substring(1);
  }

  void removeAttachment(int index) {
    meFile.removeAt(index);
    fileName.removeAt(index);
    fileSize.removeAt(index);
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final myRaw = File(result.files.single.path!);
      final size = await myRaw.length() / 1024; // Size in KB

      // Validate file size before adding to the list
      final int maxSizeInBytes = 50000; // 50 MB

      if (size <= maxSizeInBytes) {
        Uint8List myfile = await myRaw.readAsBytes();
        String base64String = base64Encode(myfile);
        getFileType(myRaw);
        final PlatformFile pickedFile = PlatformFile(
          path: result.files.single.path,
          name: result.files.single.name,
          size: size.toInt(),
          bytes: myfile,
        );

        handleFilePickedSuccess(pickedFile);
        meFile.add(base64String);
        fileName.add(result.files.single.name);
        fileSize.add(size);
      } else {
        uploaded = false;
        AppToasts.showError("File Too Large");
      }
    }
  }

  void handleFilePickedSuccess(PlatformFile pickedFile) {
    // Move the async code outside of setState
    _handleFilePickedSuccess(pickedFile);
  }

  Future<void> _handleFilePickedSuccess(PlatformFile pickedFile) async {
    // Perform the async operations
    controller.documents.clear(); // Clear the existing files

    MinioUploader uploader = MinioUploader();
    String responseUrl = await uploader.uploadFileToMinio(pickedFile, '');

    if (responseUrl.isNotEmpty) {
      // Response is successful
      print(responseUrl);
      controller.documents.add(DocPathModel(
        path: responseUrl,
      ));
    } else {
      // Response is not successful
      print('Response is false');
    }

    // Call setState to update the state
  }

  void getFileType(File file) {
    final String fileN = file.path;
    final String fileExt = fileN.split('.').last.toLowerCase();
    setState(() {
      fileExtension.add(fileExt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.complainType.name,
        title2: '',
        showActions: false,
        showLeading: true,
      ),
      body: Obx(() => controller.networkStatus.value == NetworkStatus.LOADING
          ? Center(child: CustomLoadingWidget())
          : FormBuilder(
              key: controller.complainFromKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(7.w, 7.w, 7.w, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            width: 85.w,
                            child: Text(
                              'Your Complain is important for our service improvement. Please pick the service you have an issue with.',
                              style: AppTextStyles.captionRegular.copyWith(
                                  fontSize: AppSizes.font_12,
                                  color: AppColors.grayDark),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          buildDropDown(),
                          SizedBox(
                            height: 1.h,
                          ),
                          buildDropDowncountry(),
                          SizedBox(
                            height: 1.h,
                          ),
                          Obx(() => controller.isfechedEmbassies.value
                              ? FormBuilderDropdown(
                                  decoration:
                                      ReusableInputDecoration.getDecoration(
                                    'Embassies/branch',
                                    isMandatory: true,
                                  ),
                                  items: controller.base_embassies
                                      .map((CommonModel value) {
                                    return DropdownMenuItem<CommonModel>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: AppTextStyles.captionBold
                                            .copyWith(
                                                color: AppColors.grayDark),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.embassiesvalue.value = value;
                                  },
                                  name: 'Embassies/branch',
                                )
                              : SizedBox()),
                          SizedBox(
                            height: 1.h,
                          ),
                          buildTextFieald(),
                          SizedBox(
                            height: 2.h,
                          ),
                          buildFilePicker(),
                          SizedBox(height: 2.h),
                          Visibility(
                            visible: fileName.isNotEmpty,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: fileName.length,
                              itemBuilder: (context, index) =>
                                  _buildListItem(index),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                  buildSubmitButton(),
                ],
              ),
            )),
    );
  }

  Widget _buildListItem(int index) {
    final String leadIcon = _getLeadIcon(fileExtension[index]);

    return ListTile(
      leading: SvgPicture.asset(leadIcon),
      trailing: _buildTrailingIcon(index),
      title: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              _buildFileInfo(fileName[index], fileSize[index]),
              _buildFileSizeWarning(fileSize[index]),
            ],
          ),
        ),
      ),
    );
  }

  String _getLeadIcon(String extension) {
    switch (extension) {
      case 'mp4':
        return Assets.icons.video;
      case 'm4a':
      case 'mp3':
      case 'aac':
        return Assets.icons.voice;
      case 'jpeg':
      case 'jpg':
      case 'png':
        return Assets.icons.image;
      default:
        return Assets.icons.paper;
    }
  }

  Widget _buildTrailingIcon(int index) {
    return GestureDetector(
      onTap: () {
        removeAttachment(index);
        setState(() {});
      },
      child: SvgPicture.asset(
        Assets.icons.cancel,
        colorFilter: ColorFilter.mode(AppColors.danger, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildFileInfo(String fileName, double fileSize) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${fileName.length > 30 ? fileName.substring(0, 10).split(".")[0] : fileName.split(".")[0]}\n${fileSize.toStringAsFixed(1)} KB",
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFileSizeWarning(double fileSize) {
    if (fileSize > 50000) {
      return Padding(
        padding: EdgeInsets.only(right: 39.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(1.w)),
          ),
          child: const Text(
            "Too large",
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  buildDropDowncountry() {
    return FormBuilderDropdown(
      decoration:
          ReusableInputDecoration.getDecoration('Country', isMandatory: true),
      items: controller.baseCountries.map((BaseCountryModel value) {
        return DropdownMenuItem<BaseCountryModel>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.baseCountriesvalue.value = value;
        controller.getEmbassies(controller.baseCountriesvalue.value!.id);
        controller.embassiesvalue.value = null;
      },
      name: 'Country',
    );
  }

  buildDropDown() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Complain Type',
          isMandatory: true),
      items: widget.complainType.complaintTypes.map((ComplaintType value) {
        return DropdownMenuItem<ComplaintType>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.complaintTypevalue.value = value!;
      },
      name: 'Complain',
    );
  }

  buildTextFieald() {
    return TextFormBuilder(
      isMandatory: false,
      maxline: 3,
      maxlength: 100,
      controller: controller.complaint,
      hint: 'State your complaint',
      labelText: 'Complaint',
      validator: ValidationBuilder().required('complaint required').build(),
      showClearButton: false,
      autoFocus: false,
    );
  }

  buildFilePicker() {
    return SizedBox(
      width: 85.w,
      height: 14.h,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            clicked = true;
          });
        },
        onLongPressEnd: (d) {
          setState(() {
            clicked = false;
          });
        },
        onTap: () async {
          if (meFile.length < 5) {
            showUploadDialog(context);
          } else {
            AppToasts.showError("Upload limited to 5 files");
          }
        },
        child: Container(
          color: !clicked ? Colors.white : AppColors.primary,
          child: DottedBorder(
            color: Colors.black38,
            dashPattern: const <double>[8, 5],
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.5.h,
                  ),
                  SvgPicture.asset(
                    Assets.icons.upload,
                    colorFilter:
                        ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                  Text(
                    "Click to Upload",
                    style: AppTextStyles.captionRegular.copyWith(
                        fontSize: AppSizes.font_12, color: AppColors.grayDark),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomNormalButton(
        text: 'Submit',
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor: AppColors.primary,
        borderRadius: AppSizes.radius_8,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_2,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: () {
          if (controller.complaintTypevalue.value != null) {
            controller.check();
          } else {
            AppToasts.showError("please select a complaint type \nand Country");
          }
        },
      ),
    );
  }

  // void showDialogs() async {
  //   await _pickFile();
  // }

  void showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadDialogFile(
          onUpload: () async {
            await _pickFile();
          },
          title: 'Note info:'.tr,
          contentTexts: [
            'You can send videos, images, audio, files, PDFs, and documents.'
                .tr,
            'Each file must not exceed 50 MB'.tr,
            'You can only select up to 5 files.'.tr,
          ],
        );
      },
    );
  }
}
