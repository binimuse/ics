// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import '../../../data/model/base_model_orgin.dart';
import 'package:intl/intl.dart';

class Step4OrginId extends StatefulWidget {
  final IcsApplicationModelOrginId? citizenModel;
  final NewOriginIdController controller;

  const Step4OrginId({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step4OrginId> createState() => _Step4State();
}

class _Step4State extends State<Step4OrginId> {
  final NewOriginIdController controller = Get.find<NewOriginIdController>();

  // other properties go here
  Widget build(BuildContext context) {
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
            'Current Passport Details and Signature',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        TextFormBuilder(
          isMandatory: true,
          controller: controller.passportNumberContoller,
          hint: 'Passport number',
          labelText: 'Current Passport number',
          validator: ValidationBuilder()
              .required('Passport number is required')
              .build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r"\s")),
          ],
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDateTimePicker(
          name: 'date_established',
          initialValue:
              widget.citizenModel?.newOriginIdApplications.isNotEmpty ?? false
                  ? DateTime.parse(controller.passportIssueDateController.text)
                  : null,
          onChanged: (value) {
            controller.passportIssueDateController.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration(
              'Passport Issue Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDateTimePicker(
          name: 'date_established2',
          initialValue: widget.citizenModel != null &&
                  widget.citizenModel!.newOriginIdApplications.isNotEmpty
              ? DateTime.parse(controller.passportExpiryDateController.text)
              : null,
          onChanged: (value) {
            controller.passportExpiryDateController.value = TextEditingValue(
              text: value.toString(),
            );
          },
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          enabled: true,
          decoration: ReusableInputDecoration.getDecoration(
              'Passport Expiry Date(GC)',
              isMandatory: true),
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(() => Visibility(
              visible: controller.countryvalue.value!.name == 'Ethiopia' ||
                  controller.currentcountryvalue.value!.name == 'Ethiopia',
              child: FormBuilderDropdown(
                decoration: ReusableInputDecoration.getDecoration(
                    'Visa acquiring method',
                    isMandatory: true),
                items: controller.visaType.map((CommonModel value) {
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
                  controller.visatypevalue.value = value;
                },
                name: 'Visa acquiring method',
                initialValue: widget.citizenModel != null
                    ? controller.visatypevalue.value
                    : null,
              ),
            )),
        SizedBox(height: 2.h),
        Obx(() => Visibility(
              visible: controller.countryvalue.value!.name == 'Ethiopia' ||
                  controller.currentcountryvalue.value!.name == 'Ethiopia',
              child: TextFormBuilder(
                isMandatory: true,
                controller: controller.visanumberContoller,
                hint: 'Visa number',
                labelText: 'Visa number',
                validator: ValidationBuilder()
                    .required('Visa number is required')
                    .build(),
                showClearButton: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                autoFocus: false,
                onChanged: (value) {},
              ),
            )),
        SizedBox(
          height: 2.h,
        ),
        getSignuture()
      ],
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
                  controller.signatureController.clear();
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
              controller: controller.signatureController,
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
}
