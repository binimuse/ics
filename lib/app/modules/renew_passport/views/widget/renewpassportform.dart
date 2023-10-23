// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:im_stepper/stepper.dart';
import 'package:sizer/sizer.dart';
import 'package:signature/signature.dart';

import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

class StepperWithFormExample extends StatefulWidget {
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<StepperWithFormExample> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final RenewPassportController controller =
      Get.find<RenewPassportController>();

  XFile? image;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void deleteVideo(int index) {
    controller.selectedVideos.removeAt(index);
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
            buildForm(),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.saveAndValidate()) {
      // Get form data
      Map<String, dynamic> formData = _formKey.currentState!.value;
      // Process form data or submit to an API
      print(formData);
    }
  }

  buildForm() {
    return Container(
      height: 80.h,
      child: Column(
        children: [
          IconStepper(
            activeStep: controller.currentStep,
            activeStepColor: AppColors.primary,
            icons: [
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
                child: Column(
                  children: [
                    if (controller.currentStep == 0) buildStep1(),

                    if (controller.currentStep == 1) buildStep2(),
                    if (controller.currentStep == 2) buildStep3(),
                    if (controller.currentStep == 3) buildStep4(),
                    if (controller.currentStep == 4) buildStep5(),
                    // Add this line

                    // Add more form fields as needed for each step
                  ],
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
                  borderRadius: AppSizes.radius_8,
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
                borderRadius: AppSizes.radius_8,
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
          'Passport Renewal',
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

  buildStep1() {
    return Column(
      children: [
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
      ],
    );
  }

  buildStep2() {
    return Column(
      children: [
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

  buildStep3() {
    return Column(
      children: [
        TextFormBuilder(
          controller: controller.mobilePhoneController,
          hint: 'Mobile',
          showClearButton: false,
          autoFocus: true,
          onChanged: (value) {},
        ),
        // FormBuilderDropdown(
        //     name: controller.stepFields[controller.currentStep],
        //     decoration: InputDecoration(labelText: 'Select an option'),
        //     // validator: FormBuilderValidators.required(),
        //     items: controller.stepOptions[controller.currentStep]
        //         .map((option) => DropdownMenuItem(
        //               value: option.value,
        //               child: Text(option.value),
        //             ))
        //         .toList())
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

  buildStep4() {
    return Column(
      children: [
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
      ],
    );
  }

  buildStep5() {
    return SingleChildScrollView(
      child: Column(
        children: [
          GetvideoFromCamera(),
          SizedBox(
            height: 2.h,
          ),
          getSignuture(),
        ],
      ),
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

  GetvideoFromCamera() {
    return InkWell(
      onTap: () {
        _getFromCamera();
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
              offset: Offset(0, 3), // changes the position of the shadow
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
                children: [
                  Icon(
                    Icons.videocam,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Take Video'.tr,
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              ),
              getVideo()
            ],
          ),
        ),
      ),
    );
  }

  getSignuture() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
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
          Signature(
            controller: _controller,
            height: 200,
            width: 300,
            backgroundColor: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }

  getVideo() {
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
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () => _showVideoInPopup(videoFile!),
        child: Stack(
          children: [
            if (videoPlayerController != null)
              Container(
                width: 9.h,
                height: 13.h,
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
                    deleteVideo(0); // Assuming only one video is displayed
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

  void _showVideoInPopup(File videoFile) {
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
}
