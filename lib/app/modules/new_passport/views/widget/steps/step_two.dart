import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step2 extends StatefulWidget {
  final IcsCitizenModel? citizenModel;

  const Step2({
    this.citizenModel,
  });
  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final NewPassportController controller = Get.find<NewPassportController>();

  void initState() {
    if (widget.citizenModel != null) {
      controller.height.text = widget.citizenModel!.height!.toString();
      controller.maritalstatusvalue.value = controller.martial
          .firstWhere((e) => e.name == widget.citizenModel!.maritalStatus);
    }
    super.initState();
  }

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
        FormBuilderDropdown(
          validator:
              ValidationBuilder().required('Occupation is required').build(),
          decoration: ReusableInputDecoration.getDecoration('Occupation'),
          items: controller.occupations.map((String value) {
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
            controller.occupationvalue.value = value!;
          },
          name: 'Occupation',
          initialValue: widget.citizenModel != null
              ? widget.citizenModel!.occupation!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator:
              ValidationBuilder().required('Hair Color is required').build(),
          decoration: ReusableInputDecoration.getDecoration('Hair Color'),
          items: controller.haircolor.map((String value) {
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
            controller.haircolorvalue.value = value!;
          },
          name: 'Hair',
          initialValue: widget.citizenModel != null
              ? widget.citizenModel!.hairColour!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Eye Color').build(),
          decoration: ReusableInputDecoration.getDecoration('Eye Color'),
          items: controller.eyecolor.map((String value) {
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
            controller.eyecolorvalue.value = value!;
          },
          name: 'Eye',
          initialValue: widget.citizenModel != null
              ? widget.citizenModel!.eyeColour!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          validator: ValidationBuilder().required('Skin Color').build(),
          decoration: ReusableInputDecoration.getDecoration('Skin Color'),
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
          initialValue: widget.citizenModel != null
              ? widget.citizenModel!.skinColour!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Martial status'),
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
          initialValue: widget.citizenModel != null
              ? controller.maritalstatusvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          inputFormatters: [
            HeightInputFormatter(),
          ],
          controller: controller.height,
          hint: 'Height(cm)',
          keyboardType: TextInputType.number,
          labelText: 'Height(cm)',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Height is required';
            }
            if (value.length != 4 || !value.contains('.')) {
              return 'Please enter a height in the format x.xx';
            }
            double? height = double.tryParse(value);
            if (height == null || height < 0.54 || height > 2.51) {
              return 'Please enter a valid height (0.54-2.51 m)';
            }
            return null; // Return null if validation succeeds
          },
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
