import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/phone_number_input.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step3 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
  // other properties go here

  Widget build(BuildContext context) {
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
          height: 4.h,
        ),
        FormBuilderDropdown(
          validator:
              ValidationBuilder().required('Country is required').build(),
          decoration: ReusableInputDecoration.getDecoration('Country'),
          items: controller.countries.map((String value) {
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
            controller.countryvalue.value = value!;
          },
          name: 'Country',
        ),
        SizedBox(
          height: 2.h,
        ),
        TextFormBuilder(
          controller: controller.addressController,
          hint: 'Street details/Address line 1',
          labelText: 'Address',
          validator:
              ValidationBuilder().required('Address is required').build(),
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
        TextFormBuilder(
          controller: controller.phonenumber,
          validator:
              ValidationBuilder().required('Phone number is required').build(),
          hint: 'Phone number',
          labelText: 'Phone number',
          keyboardType: TextInputType.phone,
          inputFormatters: [
            PhoneNumberInputFormatter(maxLength: 16),
          ],
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
