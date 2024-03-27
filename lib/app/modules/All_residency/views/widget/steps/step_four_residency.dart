// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';
import 'package:ics/app/modules/All_residency/data/model/all_base_residency_model.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';

import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step4_Residency extends StatefulWidget {
  final IcsResidencyApplication? citizenModel;
  final AllResidencyController controller;

  const Step4_Residency({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step4_Residency> createState() => _Step3State();
}

class _Step3State extends State<Step4_Residency> {
  final AllResidencyController controller = Get.find<AllResidencyController>();

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
            'Delivery and Urgency information',
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
          decoration: ReusableInputDecoration.getDecoration('Collaction place',
              isMandatory: true),
          validator: FormBuilderValidators.required(),
          items: controller.bcountries.map((CommonModel value) {
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
            controller.countryvalue.value = value!;
            setState(() {
              controller.getEmbassies(controller.countryvalue.value!.id!);
              controller.embassiesvalue.value = null;
            });
          },
          name: 'Collaction place',
          initialValue: widget.citizenModel != null
              ? controller.countryvalue.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(() => controller.isfechedEmbassies.value
            ? FormBuilderDropdown(
                decoration: ReusableInputDecoration.getDecoration(
                    controller.countryvalue.value!.name == "Ethiopia"
                        ? "Branch"
                        : "Embassies",
                    isMandatory: true),
                items: controller.base_embassies.map((CommonModel value) {
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
                  controller.embassiesvalue.value = value;
                },
                name: controller.countryvalue.value!.name == "Ethiopia"
                    ? "Branch"
                    : 'Embassies',
                validator: FormBuilderValidators.required(),
              )
            : SizedBox()),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Urgency Level',
              isMandatory: true),
          validator: FormBuilderValidators.required(),
          items: controller.urgencyLevel
              .map((BaseResidencyApplicationUrgencyLevel value) {
            return DropdownMenuItem<BaseResidencyApplicationUrgencyLevel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.urgencylevelvalue.value = value;
          },
          name: 'Urgency Level',
          initialValue: widget.citizenModel != null
              ? controller.urgencylevelvalue.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(
          () => Center(
            child: Text(
              "Residency Fee \$${(controller.urgencylevelvalue.value?.price ?? "")}",
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
