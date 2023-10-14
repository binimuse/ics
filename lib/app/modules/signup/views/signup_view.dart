import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/button_primary_fill_signup.dart';
import 'package:ics/app/common/forms/text_input_signup.dart';
import 'package:ics/app/common/navigation/top_nav_back_text.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

import '../controllers/signup_controller.dart';
import 'widget/user_name.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavBackText(
                centerTitle: '',
                rightText: '',
                useHomeIcon: false,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.displayOneBold,
                      ),
                      SizedBox(height: 2.h),
                      Obx(
                        () => Form(
                          child: Column(
                            children: [
                              buildEmailinput(),
                              SizedBox(height: 1.h),

                              // Show Password field only when Next is pressed
                              if (controller.isNextPressed.value ||
                                  controller.passwordController.text.isNotEmpty)
                                buildPasswordinput()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  Obx(
                    () => SizedBox(
                      height: controller.isNextPressed.value ||
                              controller.passwordController.text.isNotEmpty
                          ? 0.0
                          : 90,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                      vertical: AppSizes.mp_v_2,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Obx(
                          () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildButton(context)),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildEmailinput() {
    return TextInputSignup(
      hint: 'Email',
      autofocus: true,
      controller: controller.emailController,
      focusNode: controller.emailFocusNode,
      signupController: controller,
      onChanged: (value) {
        // Validate email on type
        bool isValid = controller.validateEmail();
        controller.isEmailValidated.value = isValid;

        // Check if email is valid and update UI accordingly
        if (isValid) {
          controller.isNextPressed(false); // Reset Next button
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        if (!controller.isEmailValidated.value) {
          return 'Invalid email';
        }
        return null;
      },
    );
  }

  buildPasswordinput() {
    return TextInputSignup(
      hint: 'Password',
      moreInstructions: const [
        "Minimum 8 letters,",
        "English + number + special character",
      ],
      isPassword: true,
      onChanged: (value) {
        // Validate password on type
        bool isValid = controller.validatePassword();
        controller.isPasswordValid.value = isValid;

        // Check if the password is valid and display the appropriate text
        if (isValid) {
          controller
              .isNextPressed(true); // Set to true but don't hide password field
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Password';
        }
        if (!controller.isPasswordValid.value) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      controller: controller.passwordController,
      autofocus: controller
          .isNextPressed.value, // Set autofocus to true when Next is pressed
      focusNode: controller.passwordFocusNode, // Pass the password focus node
    );
  }

  buildButton(BuildContext context) {
    return ButtonPrimaryFillSignup(
      buttonSizeType: ButtonSizeTypeSignup.LARGE,
      isDisabled: !controller.isEmailValidated.value ||
          (controller.isEmailValidated.value &&
              !controller.isNextPressed.value),
      text: controller.isEmailValidated.value
          ? controller.isNextPressed.value
              ? controller.isPasswordValid.value
                  ? "Next"
                  : "Enter password"
              : "Next"
          : 'Enter your e-mail address',
      onTap: () {
        if (controller.isEmailValidated.value &&
            !controller.isNextPressed.value) {
          controller.isNextPressed(true);
          Future.delayed(const Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(controller.passwordFocusNode);
          });
        } else if (!controller.isNextPressed.value) {
          controller.isNextPressed(true);
          // Change the button text to "Enter password"
        } else {
          // Handle final next logic
          Get.to(SignUpUserName());
        }
      },
    );
  }
}
