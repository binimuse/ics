import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
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
          decoration: ReusableInputDecoration.getDecoration('Country'),
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
            controller.countryvalue.value = value!.name_json;
            controller.CountryvalueId.value = value.id;
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                buildCountryCode(),
                SizedBox(
                  height: AppSizes.mp_v_1,
                ),
                SizedBox(
                  width: 34.w,
                  child: Divider(
                    color: AppColors.grayLighter,
                    thickness: 1,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: AppSizes.mp_w_4,
            ),
            buildPhonenumber(),
          ],
        ),
      ],
    );
  }

  buildCountryCode() {
    return Center(
      child: CountryCodePicker(
        flagDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryDark,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // changes the shadow position
              ),
            ]),
        onChanged: (element) {
          debugPrint(element.dialCode);

          controller.countryCode = element.dialCode.toString();
        },
        initialSelection: 'IT',
        textOverflow: TextOverflow.fade,
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')

        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }

  buildPhonenumber() {
    return Expanded(
        child: PhoneNumberInput(
      hint: 'Phone number',
      labelText: "Phone number",
      focusNode: controller.phoneFocusNode,
      autofocus: false,
      controller: controller.phonenumber,
      onChanged: (value) {
        // Validate password on type
        bool isValid =
            controller.validatPhone(); // Pass the value to validatePassword
        controller.isPhoneValid.value = isValid;

        // Check if the password is valid and display the appropriate text
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Phone Number';
        }
        if (!controller.isPhoneValid.value) {
          return 'Invalid phone number';
        }
        return null;
      },
    ));
  }
}
