import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/datepicker/date_text_picker_input.dart';
import 'package:ics/app/common/forms/form_lable.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/utils/keyboard.dart';
import 'package:ics/utils/validator_util.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step1 extends StatefulWidget {
  final IcsCitizenModel? citizenModel;

  const Step1({
    this.citizenModel,
  });

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  final NewPassportController controller = Get.find<NewPassportController>();

  @override
  void initState() {
    if (widget.citizenModel != null) {
      controller.firstNameController.text = widget.citizenModel!.firstName!;
      controller.fatherNameController.text = widget.citizenModel!.father_name!;
      controller.grandFatherNameController.text =
          widget.citizenModel!.grandFatherNameJson!.en!;

      //amharic

      controller.AmfirstNameController.text =
          widget.citizenModel!.firstNameJson!.am!;
      controller.AmfatherNameController.text =
          widget.citizenModel!.fatherNameJson!.am!;
      controller.AmgrandFatherNameController.text =
          widget.citizenModel!.grandFatherNameJson!.am!;

      //country
      controller.birthCountryvalue.value = controller.bcountries
          .firstWhere((e) => e.id == widget.citizenModel!.birthCountryId);

      controller.gendervalue.value = controller.gender
          .firstWhere((e) => e.name == widget.citizenModel!.gender);

      // day
      controller.dayController.text =
          widget.citizenModel!.dateOfBirth!.day.toString();
      // month
      controller.monthController.text =
          widget.citizenModel!.dateOfBirth!.month.toString();
      // year
      controller.yearController.text =
          widget.citizenModel!.dateOfBirth!.year.toString();
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
              ValidationBuilder().required('Father Name is required').build(),
          labelText: "First name",
          controller: controller.firstNameController,
          inputFormatters: [
            NoNumberInputFormatter(),
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
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          hint: 'Father Name',
          labelText: 'Father Name',
          inputFormatters: [
            NoNumberInputFormatter(),
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
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          hint: 'Grand Father Name',
          labelText: 'Grand Father Name',
          inputFormatters: [
            NoNumberInputFormatter(),
          ],
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 3.h,
        ),
        FormLabelWidget(
          title: 'Please use Amharic keyboard',
          isRequired: false,
          color: AppColors.primary,
          leftIcon: Icon(
            Icons.keyboard,
            color: AppColors.secondary,
            size: AppSizes.icon_size_6,
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        TextFormBuilder(
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          labelText: "የመጀመሪያ ስም",
          controller: controller.AmfirstNameController,
          inputFormatters: [
            AmharicInputFormatter(),
          ],
          hint: 'የመጀመሪያ ስም',
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.AmfatherNameController,
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          hint: 'የአባት ስም',
          labelText: 'የአባት ስም',
          inputFormatters: [
            AmharicInputFormatter(),
          ],
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.AmgrandFatherNameController,
          validator:
              ValidationBuilder().required('Father Name is required').build(),
          hint: 'የአያት ስም',
          labelText: 'የአያት ስም',
          inputFormatters: [
            AmharicInputFormatter(),
          ],
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          height: 1.h,
        ),
        FormBuilderDropdown(
          decoration:
              ReusableInputDecoration.getDecoration('Gender is required'),
          items: controller.gender.map((CommonModel value) {
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
            controller.gendervalue.value = value!;
          },
          name: 'Gender',
          initialValue: widget.citizenModel != null
              ? controller.gendervalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Birth Country'),
          items: controller.bcountries.map((CommonJsonModel value) {
            return DropdownMenuItem<CommonJsonModel>(
              value: value,
              child: Text(
                value.name_json,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.birthCountryvalue.value = value;
          },
          name: 'birth',
          initialValue: widget.citizenModel != null
              ? controller.birthCountryvalue.value!
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Birth date',
          style: AppTextStyles.captionBold.copyWith(
            color: AppColors.grayLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        DateTextPickerInput(
          yearValidator:
              ValidationBuilder().required(' year is required').build(),
          monthValidator:
              ValidationBuilder().required('monthV is required').build(),
          dateValidator:
              ValidationBuilder().required('date is required').build(),
          controller: controller,
        ),
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
      inputFormatters: [
        DateInputFormatter(),
      ],
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
        // showModal(context);
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  String? formattedDates;
}
