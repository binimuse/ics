import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:sizer/sizer.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../../config/theme/app_sizes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Step1 extends StatefulWidget {
  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final NewPassportController controller = Get.find<NewPassportController>();

  // other properties go here
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isfeched.value
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80.w,
                child: Text(
                  'Step 1',
                  style: AppTextStyles.bodyLargeBold.copyWith(
                      fontSize: AppSizes.font_14, color: AppColors.primary),
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
                // validator:
                //     ValidationBuilder().required('Father Name is required').build(),
                labelText: "First name",
                controller: controller.firstNameController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
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
                // validator:
                //     ValidationBuilder().required('Father Name is required').build(),
                hint: 'Father Name',
                labelText: 'Father Name',
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                showClearButton: false,
                autoFocus: false,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormBuilder(
                controller: controller.grandFatherNameController,
                // validator:
                //     ValidationBuilder().required('Father Name is required').build(),
                hint: 'Grand Father Name',
                labelText: 'Grand Father Name',
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                ],
                showClearButton: false,
                autoFocus: false,
                onChanged: (value) {},
              ),
              SizedBox(
                height: 2.h,
              ),
              FormBuilderDropdown(
                validator:
                    ValidationBuilder().required('gender is required').build(),
                decoration: ReusableInputDecoration.getDecoration('Gender'),
                items: controller.gender.map((String value) {
                  print(value);
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
                  controller.gendervalue.value = value!;
                },
                name: 'Gender',
              ),
              SizedBox(
                height: 2.h,
              ),
              FormBuilderDropdown(
                validator: ValidationBuilder()
                    .required('birth Country is required')
                    .build(),
                decoration:
                    ReusableInputDecoration.getDecoration('Birth Country'),
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
                name: 'birth',
              ),
              SizedBox(
                height: 2.h,
              ),
              buildDateOfBirth(context),
              SizedBox(
                height: 2.h,
              ),
            ],
          )
        : Center(child: CustomLoadingWidget()));
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
    setState(() {});
  }
}
