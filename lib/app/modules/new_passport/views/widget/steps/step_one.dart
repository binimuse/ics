import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:sizer/sizer.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:intl/intl.dart';

class Step1 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
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
            'Step 1',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 1.h,
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
          height: 1.h,
        ),
        TextFormBuilder(
          validator:
              ValidationBuilder().required('First name is required').build(),
          labelText: "First name",
          controller: controller.firstNameController,
          hint: 'First name',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.fatherNameController,
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          hint: 'Father Name',
          labelText: 'Father Name',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.grandFatherNameController,
          validator: ValidationBuilder()
              .required('Grand Father Name is required')
              .build(),
          hint: 'Grand Father Name',
          labelText: 'Grand Father Name',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        Obx(() => ReusableDropdown(
              initialValue: controller.gendervalue.value.isEmpty
                  ? ""
                  : controller.gendervalue.value,
              validator:
                  ValidationBuilder().required('gender is required').build(),
              labelText: 'Gender',
              items: controller.gender.map((String value) {
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
                print(controller.gendervalue.value);
                controller.gendervalue.value = value!;
              },
            )),
        SizedBox(
          height: 2.h,
        ),
        ReusableDropdown(
          validator:
              ValidationBuilder().required('birth Country is required').build(),
          labelText: controller.birthCountryvalue.value.isEmpty
              ? 'birth Country'
              : controller.birthCountryvalue.value,
          items: controller.bcountries.map((String value) {
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
            controller.birthCountryvalue.value = value!;
          },
        ),
        SizedBox(
          height: 2.h,
        ),
        buildDateOfBirth(context),
        SizedBox(
          height: 2.h,
        ),
      ],
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
      validator: ValidationBuilder().required('Birthdate is required').build(),
      hint: 'Birthdate',
      labelText: 'Birthdate',
      showClearButton: false,
      autoFocus: false,
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
