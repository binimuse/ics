import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/forms/phone_number_input.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../../../../../config/theme/app_sizes.dart';

class Step3 extends StatefulWidget {
  final IcsApplicationModel? citizenModel;
  final NewPassportController controller;

  const Step3({
    this.citizenModel,
    required this.controller,
  });
  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
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
            'Address and collaction Information',
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
          decoration: ReusableInputDecoration.getDecoration('Current Country',
              isMandatory: true),
          validator: (AllowedContreyModel? value) {
            if (value == null) {
              return 'Please Current Country'; // Return an error message if no value is selected
            }
            return null; // Return null if the value is valid
          },
          items: controller.allwoedCountries.map((AllowedContreyModel value) {
            return DropdownMenuItem<AllowedContreyModel>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold
                    .copyWith(color: AppColors.grayDark),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.currentcountryvalue.value = value!;
          },
          name: 'Current Country',
          initialValue: widget.citizenModel != null
              ? controller.currentcountryvalue.value
              : null,
        ),
        SizedBox(
          height: 2.h,
        ),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration('Collaction place',
              isMandatory: true),
          validator: (AllowedContreyModel? value) {
            if (value == null) {
              return 'Please Collaction place'; // Return an error message if no value is selected
            }
            return null; // Return null if the value is valid
          },
          items: controller.allwoedCountries.map((AllowedContreyModel value) {
            return DropdownMenuItem<AllowedContreyModel>(
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
              controller.getEmbassies(controller.countryvalue.value!.id);
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
                  controller.getBookedDates(value!.id!);
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
        TextFormBuilder(
          isMandatory: true,
          controller: controller.addressController,
          hint: 'Street details/Address line 1',
          labelText: 'Address',
          validator:
              ValidationBuilder().required('Address is required').build(),
          showClearButton: false,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
          ],
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 2.h,
        ),
        buildPhoneinput()
        // buildPhoneinput(),
      ],
    );
  }

  buildPhoneinput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: buildCountryCode(),
        ),
        SizedBox(
          width: AppSizes.mp_w_4,
        ),
        Expanded(
          flex: 10,
          child: buildPhonenumber(),
        )
      ],
    );
  }

  buildCountryCode() {
    return CountryCodePicker(
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
      textStyle: AppTextStyles.captionBold,
      initialSelection: 'et',
      textOverflow: TextOverflow.fade,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  buildPhonenumber() {
    return PhoneNumberInput(
      isMandatory: true,
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
      validator: FormBuilderValidators.required(),
    );
  }
}
