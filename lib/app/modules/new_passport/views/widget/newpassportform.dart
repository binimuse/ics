// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';

import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:im_stepper/stepper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

class NewPassportForm extends StatefulWidget {
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<NewPassportForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final NewPassportController controller = Get.find<NewPassportController>();

  String? _imagePath;

  XFile? image;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  final picker = ImagePicker();
  final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildName(context),
            buildForm(context),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    AppToasts.showSuccess("Form submitted ,\n check my order page");

    await Future.delayed(const Duration(milliseconds: 400));
    Get.offAndToNamed(Routes.MAIN_PAGE);
    if (_formKey.currentState!.saveAndValidate()) {
      // Get form data
      Map<String, dynamic> formData = _formKey.currentState!.value;
      // Process form data or submit to an API
      print(formData);
    }
  }

  buildForm(BuildContext context) {
    return Container(
      height: 80.h,
      child: Column(
        children: [
          IconStepper(
            activeStep: controller.currentStep,
            lineColor: AppColors.secondary,
            stepColor: AppColors.grayDefault,
            activeStepColor: AppColors.primary,
            icons: [
              Icon(
                Icons.person,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.person,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.location_on,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.contact_phone,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.edit_document,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.edit,
                color: AppColors.whiteOff,
              ),
            ],
            onStepReached: (index) {
              setState(() {
                controller.currentStep = index;
              });
            },
            enableNextPreviousButtons: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (controller.currentStep == 0) buildStep1(context),

                      if (controller.currentStep == 1) buildStep2(context),
                      if (controller.currentStep == 2) buildStep3(),
                      if (controller.currentStep == 3) buildStep4(),
                      if (controller.currentStep == 4) buildStep5(context),
                      if (controller.currentStep == 5) buildStep6(context),
                      // Add this line

                      // Add more form fields as needed for each step
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (controller.currentStep > 0)
                CustomNormalButton(
                  text: 'Back',
                  textStyle: AppTextStyles.bodyLargeBold.copyWith(
                    color: AppColors.whiteOff,
                  ),
                  textcolor: AppColors.whiteOff,
                  buttoncolor: controller.areAllTermsSelected()
                      ? AppColors.primary
                      : AppColors.grayLight,
                  borderRadius: AppSizes.radius_16,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.mp_v_2,
                    horizontal: AppSizes.mp_w_6,
                  ),
                  onPressed: () {
                    if (controller.currentStep > 0) {
                      setState(() {
                        controller.currentStep--;
                      });
                    }
                  },
                ),
              CustomNormalButton(
                text: controller.currentStep == 4 ? 'Submit' : 'Next',
                textStyle: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.whiteOff,
                ),
                textcolor: AppColors.whiteOff,
                buttoncolor: controller.currentStep == 4
                    ? AppColors.primary
                    : AppColors.grayLight,
                borderRadius: AppSizes.radius_16,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2,
                  horizontal: AppSizes.mp_w_6,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (controller.currentStep == 4) {
                      // Handle form submission
                      _submitForm();
                    } else {
                      setState(() {
                        controller.currentStep++;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildName(BuildContext context) {
    return Row(
      children: [
        AppSvgButton(
          imagePath: Assets.icons.arrowleft,
          onPressed: () {
            Get.back();
          },
          size: AppSizes.icon_size_8 * 0.7,
        ),
        Text(
          'New Passport',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Application',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
    );
  }

  buildStep2(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 2',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your passport is an essential document in international travel and for identification purposes. ',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          labelText: 'Occupation',
          items: [
            DropdownMenuItem(
              value: 'Waiter',
              child: Text(
                'Waiter',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Dentist',
              child: Text(
                'Dentist',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Nurse',
              child: Text(
                'Nurse',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Doctor',
              child: Text(
                'Doctor',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Surgeon',
              child: Text(
                'Surgeon',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Postman',
              child: Text(
                'Postman',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
          ],
          onChanged: (value) {
            print(value);
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          labelText: 'Hair Color',
          items: [
            DropdownMenuItem(
              value: 'Black',
              child: Text(
                'Black',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Brown',
              child: Text(
                'Brown',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Blonde ',
              child: Text(
                'Blonde ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Red ',
              child: Text(
                'Red ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Gray and White Hair',
              child: Text(
                'Gray and White Hair',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
          ],
          onChanged: (value) {
            print(value);
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          labelText: 'Martial status',
          items: [
            DropdownMenuItem(
              value: 'Married ',
              child: Text(
                'Married ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Widowed ',
              child: Text(
                'Widowed ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Separated  ',
              child: Text(
                'Separated  ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Divorced  ',
              child: Text(
                'Divorced  ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'Single ',
              child: Text(
                'Single ',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
          ],
          onChanged: (value) {
            print(value);
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        buildDateOfBirth(context),
        SizedBox(
          height: 4.h,
        ),
        ReusableDropdown(
          labelText: 'Select an option',
          items: [
            DropdownMenuItem(
              value: 'male',
              child: Text(
                'Male',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'female',
              child: Text(
                'Female',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
          ],
          onChanged: (value) {
            print(value);
          },
        ),
      ],
    );
  }

  buildStep1(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 1',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your passport is an essential document in international travel and for identification purposes. ',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.firstNameController,
          hint: 'First name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.fatherNameController,
          hint: 'Father Name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.grandFatherNameController,
          hint: 'Grand Father Name',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        buildDateOfBirth(context),
        SizedBox(
          height: 4.h,
        ),
        ReusableDropdown(
          labelText: 'Select an option',
          items: [
            DropdownMenuItem(
              value: 'male',
              child: Text(
                'Male',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
            DropdownMenuItem(
              value: 'female',
              child: Text(
                'Female',
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            ),
          ],
          onChanged: (value) {
            print(value);
          },
        ),
      ],
    );
  }

  buildStep3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 2',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Street details/Address line 1',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.countryController,
          hint: 'Country',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.zipController,
          hint: 'Zip Code',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.cityController,
          hint: 'City',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.stateController,
          hint: 'State/Province',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  buildStep4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 3',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.mobilePhoneController,
          hint: 'Mobile',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.emailController,
          hint: 'Email',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
      ],
    );
  }

  buildStep5(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 4',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.passportnumberController,
          hint: 'Passport number',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.placeOfIssueController,
          hint: 'Place of Issue',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.validtyPerdiodController,
          hint: 'Validitiy Period',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.reasonController,
          hint: 'Reasone for Renewal',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        getImageFromCameraa(),
      ],
    );
  }

  getImageFromCameraa() {
    return InkWell(
      onTap: () {
        openImageScanner();
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLighter.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.document_scanner,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                'Document Scan'.tr,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              _imagePath != null ? getImage() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openImageScanner() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    // Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;

    try {
      //Make sure to await the call to detectEdge.
      success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print("success: $success");
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (success) {
        _imagePath = imagePath;
      }
    });
  }

  buildStep6(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              width: 80.w,
              child: Text(
                'Step 5',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_14, color: AppColors.primary),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
                style: AppTextStyles.bodySmallRegular.copyWith(
                    fontSize: AppSizes.font_12, color: AppColors.grayDark),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            //
          ],
        ),
        GetvideoFromCamera(context),
        SizedBox(
          height: 2.h,
        ),
        getSignuture(),
      ],
    );
  }

  Future<void> _getFromCamera() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      File file = File(video.path);
      final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB

      try {
        if (await file.exists() && (await file.length()) > maxSizeInBytes) {
          //  Compress the video if it exceeds 10MB
          // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          //   file.path,
          //   quality: VideoQuality.LowQuality,
          //   deleteOrigin: true, // Delete the original file after compression
          // );
          // file = mediaInfo!.file!; // Update the file with the compressed video
        }

        int fileSize = await file.length();
        if (fileSize <= maxSizeInBytes) {
          final videoType = await controller.getVideoType(file);
          if (videoType == VideoType.video) {
            setState(() {
              controller.selectedVideos.add(file);
            });
          } else {
            AppToasts.showError("Invalid File, Please select a Video.");
          }
        } else {
          // Show dialog if the file is empty or exceeds 50 MB after compression

          AppToasts.showError("Invalid File, Please select a Video.");
        }
      } catch (e) {
        // Handle any exceptions that occurred during file operations or compression
        print("Error: $e");
      }
    }
  }

  GetvideoFromCamera(BuildContext context) {
    return InkWell(
      onTap: () {
        _getFromCamera();
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLighter.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                'Take Video'.tr,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              controller.selectedVideos.isNotEmpty
                  ? getVideo(context)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  getSignuture() {
    return Container(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: AppColors.primary,
                  ),
                  Text(
                    'Sign here'.tr,
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _controller.clear();
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteOff,
              borderRadius: BorderRadius.all(Radius.circular(90)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(3, 3), // changes the shadow position
                ),
              ],
            ),
            child: Signature(
              controller: _controller,
              height: 200,
              width: 300.w,
              backgroundColor: AppColors.grayLighter,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }

  getVideo(BuildContext context) {
    final videoFile = controller.selectedVideos.isNotEmpty
        ? controller.selectedVideos.first
        : null;

    // Check if a VideoPlayerController instance already exists
    if (videoFile != null && controller.videoController == null) {
      // Create a new VideoPlayerController instance
      final videoPlayerController = VideoPlayerController.file(videoFile);
      controller.videoController = videoPlayerController;
    } else if (videoFile != null &&
        controller.videoController != null &&
        controller.videoController!.dataSource != videoFile.path) {
      // Dispose the existing VideoPlayerController instance
      final oldController = controller.videoController!;
      oldController.dispose();

      // Create a new VideoPlayerController instance with the updated file
      final newController = VideoPlayerController.file(videoFile);
      controller.videoController = newController;
    }

    final videoPlayerController = controller.videoController;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (videoFile != null) {
            _showVideoInPopup(videoFile, context);
          } else {
            _getFromCamera();
          }
        },
        child: Stack(
          children: [
            if (videoPlayerController != null)
              Container(
                width: 26.w,
                height: 15.h,
                child: FutureBuilder(
                  future: videoPlayerController.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: VideoPlayer(videoPlayerController),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            else
              Container(
                // Empty frame
                width: 13.h, // Assuming 13.h represents the width of the frame
                height:
                    15.h, // Assuming 13.h represents the height of the frame
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.photo,
                  color: Colors.grey,
                ),
              ),
            if (videoPlayerController != null)
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    print(videoFile);
                    if (videoFile != null) {
                      setState(() {
                        controller.selectedVideos.removeAt(0);
                        controller.videoController = null;
                      });
                    } else {
                      AppToasts.showError("No video selected");
                    }
                    // Assuming only one video is displayed
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
  }

  void _showVideoInPopup(File videoFile, BuildContext context) {
    final videoController = VideoPlayerController.file(videoFile);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FutureBuilder(
                      future: videoController.initialize(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // Play the video after initialization
                          videoController.play();
                          return AspectRatio(
                            aspectRatio: videoController.value.aspectRatio,
                            child: VideoPlayer(videoController),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    videoController.pause(); // Pause the video
                    videoController
                        .dispose(); // Dispose the controller when the dialog is closed
                  },
                  child: Text('Close'.tr),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getImage() {
    return Visibility(
      visible: _imagePath != null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.file(
          File(_imagePath ?? ''),
        ),
      ),
    );
  }

  buildDateOfBirth(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBirthdateField(context),
      ],
    );
  }

  buildBirthdateField(BuildContext context) {
    return TextFormBuilder(
      controller: controller.dateofbirth,
      hint: 'Birthdate',
      showClearButton: false,
      autoFocus: true,
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
        _selectDate(context);
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  String? formattedDates;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                surface: Colors.pink,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: AppColors.grayLight,
            ),
            child: child!,
          );
        },
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      formattedDates = DateFormat('yyyy-MM-dd').format(selectedDate);
      // controller.realdate.value = DateFormat.yMd().format(selectedDate);
    }
    controller.dateofbirth.text = formattedDates.toString();
    controller.update();
  }
}
