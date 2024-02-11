import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step2 extends StatelessWidget {
  final IcsCitizenModel? citizenModel;
  final NewPassportController controller;

  const Step2({
    this.citizenModel,
    required this.controller,
  });

  // other properties go here
  @override
  Widget build(BuildContext context) {
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
            'Personal profie',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Occupation',
              isMandatory: true),
          items: controller.occupations.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.occupationvalue.value = value;
          },
          name: 'Occupation',
          initialValue:
              citizenModel != null ? controller.occupationvalue.value! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Hair Color',
              isMandatory: true),
          items: controller.haircolor.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.haircolorvalue.value = value!;
          },
          name: 'Hair Color',
          initialValue:
              citizenModel != null ? controller.haircolorvalue.value! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Eye Color',
              isMandatory: true),
          items: controller.eyecolor.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.eyecolorvalue.value = value!;
          },
          name: 'Eye Color',
          initialValue:
              citizenModel != null ? controller.eyecolorvalue.value! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Skin Color').build(),
          decoration: ReusableInputDecoration.getDecoration('Skin Color',
              isMandatory: true),
          items: controller.SkinColor.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.skincolorvalue.value = value!;
          },
          name: 'Skin',
          initialValue: citizenModel != null ? citizenModel!.skinColour! : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Martial status',
              isMandatory: true),
          items: controller.martial.map((CommonModel value) {
            return DropdownMenuItem<CommonModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.maritalstatusvalue.value = value!;
          },
          name: 'Martial',
          initialValue: citizenModel != null
              ? controller.maritalstatusvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          inputFormatters: [
            HeightInputFormatter(),
          ],
          controller: controller.height,
          hint: 'Height(cm)',
          keyboardType: TextInputType.number,
          labelText: 'Height(cm)',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        getSignuture(),
      ],
    );
  }

  getSignuture() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getImageFromCamera(),
          // Signature(
          //   controller: controller.signatureController,
          //   height: 200,
          //   width: 300,

          //   backgroundColor: AppColors.primaryDark,
          // ),
        ],
      ),
    );
  }

  getImageFromCamera() {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Take Profile photo'.tr,
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
              getImage()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File file = File(image.path);
      final int maxSizeInBytes = 10 * 1024 * 1024; // 10 MB

      try {
        if (await file.exists() && (await file.length()) > maxSizeInBytes) {
          // Compress the image if it exceeds 10MB
          // You can use any image compression library or technique here
        }

        int fileSize = await file.length();
        if (fileSize <= maxSizeInBytes) {
          // Assuming you have a controller to manage selected images
          controller.selectedImages.add(file);
        } else {
          // Show dialog if the file is empty or exceeds 10 MB after compression
          AppToasts.showError("Invalid File, Please select an Image.");
        }
      } catch (e) {
        // Handle any exceptions that occurred during file operations or compression
        print("Error: $e");
      }
    }
  }

  getImage() {
    final imageFile = controller.selectedImages.isNotEmpty
        ? controller.selectedImages.first
        : null;

    if (imageFile != null) {
      if (controller.selectedImages.isNotEmpty) {
        // Dispose the existing Image instance
        final oldImage = controller.selectedImages.first;
        oldImage.deleteSync(); // Delete the old image file if needed
        controller.selectedImages
            .clear(); // Remove the old image file from the list
      }

      // Add the new image file to the list
      controller.selectedImages.add(imageFile);
    }

    final image = controller.selectedImages.isNotEmpty
        ? controller.selectedImages.first
        : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (image != null) {
            //_showImageInPopup(image);
          } else {
            _getFromCamera();
          }
        },
        child: Stack(
          children: [
            if (image != null)
              Container(
                width: 26.w,
                height: 15.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
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
                  Icons.photo_camera,
                  color: Colors.grey,
                ),
              ),
            if (image != null)
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    print(image);
                    if (image != null) {
                      controller.selectedImages.removeAt(0);
                      image.deleteSync(); // Delete the image file
                    } else {
                      AppToasts.showError("No image selected");
                    }
                    // Assuming only one image is displayed
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
}
