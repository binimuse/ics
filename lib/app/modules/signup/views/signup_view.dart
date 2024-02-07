import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/customappbar.dart';

import 'package:ics/app/common/forms/phone_number_input.dart';
import 'package:ics/app/common/forms/text_input.dart';
import 'package:ics/app/common/forms/text_input_signup.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/data/enums.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:sizer/sizer.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ICS',
        title2: "Sign Up",
        showLeading: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///APP BAR
                Align(
                  alignment: Alignment
                      .center, // Align the image to the center of the expanded space
                  child: Image.asset(
                    AppAssets.splasehimage2,
                    height: 13.h,
                    width: 80.w,
                    fit: BoxFit.contain,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: AppSizes.mp_v_1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: controller.regFormKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.mp_w_4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: AppSizes.mp_v_1,
                                    ),
                                    buildFirstName(),
                                    SizedBox(
                                      height: AppSizes.mp_v_1,
                                    ),
                                    buildLastName(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    buildPhoneinput(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    buildpininput(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: controller.isNextPressed.value ||
                                controller.passwordController.text.isNotEmpty
                            ? 0.0
                            : 5.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_4,
                        vertical: AppSizes.mp_w_2,
                      ),
                      child: Column(
                        children: [
                          // SizedBox(height: 1.h),

                          buildButton(),

                          buildSignupButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () => controller.networkStatus.value == NetworkStatus.LOADING
                ? CustomLoadingWidget()
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  buildpininput() {
    return TextInputSignup(
      hint: 'Pin',
      maxLength: 6,
      moreInstructions: const [
        "Maximum  6 digits",
        "Only Numbers",
      ],
      keyboardType: TextInputType.number,
      isPassword: true,
      onChanged: (value) {
        // Validate password on type

        bool isValid = controller.validatePassword();

        controller.isPasswordValid.value = isValid;

        // Check if the password is valid and display the appropriate text
      },

      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your pin';
        }

        if (!controller.isPasswordValid.value) {
          return 'Pin must be 6';
        }

        return null;
      },

      controller: controller.passwordController,

      autofocus: controller
          .isNextPressed.value, // Set autofocus to true when Next is pressed

      focusNode: controller.passwordFocusNode, // Pass the password focus node
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
      initialSelection: 'et',
      textOverflow: TextOverflow.fade,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')

      // optional. Shows only country name and flag
      showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      alignLeft: false,
    );
  }

  buildPhonenumber() {
    return Expanded(
        child: PhoneNumberInput(
      isMandatory: false,
      hint: 'Phone number',
      labelText: "Phone number",
      focusNode: controller.phoneFocusNode,
      autofocus: true,
      controller: controller.phoneController,
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

  buildButton() {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_8),
            child: ButtonPrimaryFill(
              isterms: false,
              buttonSizeType: ButtonSizeType.LARGE,
              isDisabled: !controller.isPasswordValid.value ||
                  !controller.isPhoneValid.value,
              text: "Next",
              onTap: () async {
                if (await controller.regFormKey.currentState!.validate()) {
                  if (!controller.isPasswordValid.value ||
                      !controller.isPhoneValid.value) {
                    // Show an error message or perform some action
                  } else {
                    controller.signUp();
                  }
                }
              },
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildPhoneinput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCountryCode(),
        SizedBox(
          width: AppSizes.mp_w_4,
        ),
        buildPhonenumber(),
      ],
    );
  }

  buildLastName() {
    return TextInputAll(
      textInputAction: TextInputAction.next,
      controller: controller.lNameController,
      hint: 'Last name',
      showClearButton: false,
      onChanged: (value) {
        bool isValid = controller.validateusername();
        controller.isUsernameCorrect.value = isValid;

        // Validate password on type

        // Check if the password is valid and display the appropriate text
      },
    );
  }

  buildFirstName() {
    return TextInputAll(
      controller: controller.fNameController,
      hint: 'First name',
      textInputAction: TextInputAction.next,
      showClearButton: false,
      autoFocus: true,
      onChanged: (value) {
        bool isValid = controller.validateusername();

        controller.isUsernameCorrect.value = isValid;

        // Validate password on type

        // Check if the password is valid and display the appropriate text
      },
    );
  }

  buildSignupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed(Routes.LOGIN);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "do you have an account ? Login",
            style: AppTextStyles.bodySmallUnderlineRegular
                .copyWith(color: AppColors.grayLight),
          ),
        ),
      ),
    );
  }
}
