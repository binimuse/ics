// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';
import 'package:ics/app/modules/renew_passport/data/model/base_model_renew_passport.dart';
import 'package:ics/app/modules/renew_passport/data/model/citizens_model_renew_passport.dart';

import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step5RenewPassport extends StatefulWidget {
  final IcsApplicationModelReNewPassport? citizenModel;
  final RenewPassportController controller;

  const Step5RenewPassport({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step5RenewPassport> createState() => _Step4State();
}

class _Step4State extends State<Step5RenewPassport> {
  final RenewPassportController controller =
      Get.find<RenewPassportController>();

  // other properties go here
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 5',
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
            'Old Passport Details:',
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
          isMandatory: true,
          controller: controller.passportNumberContoller,
          hint: 'Old Passport number',
          labelText: 'Old Passport number',
          validator: ValidationBuilder()
              .required('Passport number is required')
              .build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r"\s")),
          ],
          autoFocus: false,
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          height: 2.h,
        ),
        iscorrection(),
        Obx(() =>
            controller.isDataCorrection.value ? correctiontype() : SizedBox()),
      ],
    );
  }

  iscorrection() {
    return FormBuilderCheckbox(
      initialValue: widget.citizenModel != null
          ? controller.isDataCorrection.value
          : null,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      name: 'Is Data correction',
      title: Text(
        'Is Data correction',
        style: AppTextStyles.captionBold.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_12,
        ),
      ),
      activeColor: AppColors.primary,
      onChanged: (value) {
        print(controller.correctionTypevalue.value);
        controller.correctionTypevalue.value = null;
        controller.isDataCorrection.value = value!;
        _scrollToBottom();
      },
    );
  }

  correctiontype() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Correction type'),
      items: controller.correctiontyoe.map((CommonModel value) {
        return DropdownMenuItem<CommonModel>(
          value: value,
          child: Text(
            value.name,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.correctionTypevalue.value = value;
      },
      name: 'Correction type',
      initialValue: widget.citizenModel != null
          ? controller.correctionTypevalue.value
          : null,
    );
  }

  void _scrollToBottom() {
    print("object");
    controller.scrollController.animateTo(
      controller.scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
