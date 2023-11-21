import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/button_primary_fill_login.dart';
import 'package:ics/app/common/forms/text_input_login.dart';
import 'package:ics/app/common/navigation/top_nav_back_text.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
                        "Log in",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.displayOneBold,
                      ),
                      SizedBox(height: 1.h),
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
                          : 5.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.mp_w_4,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildFindEmailButton(),
                            SizedBox(
                              height: 2.h,
                              child: VerticalDivider(
                                color: AppColors.secondary,
                                thickness: 2,
                              ),
                            ),
                            buildFindPassswordButton(),
                          ],
                        ),
                        // SizedBox(height: 1.h),
                        Obx(
                          () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildButton(context)),
                        ),
                        SizedBox(height: 1.h),
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
    return TextInputLogin(
      hint: 'Email',
      autofocus: true,
      controller: controller.emailController,
      focusNode: controller.emailFocusNode,
      logincontroller: controller,
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
    return TextInputLogin(
      hint: 'Password',
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

  buildFindEmailButton() {
    return MaterialButton(
      onPressed: () {
        // Get.dialog(
        //   const DialogFindEmail(),
        //   barrierDismissible: true,
        // );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find email",
            style: AppTextStyles.bodySmallUnderlineRegular
                .copyWith(color: AppColors.grayLight),
          ),
        ),
      ),
    );
  }

  buildFindPassswordButton() {
    return MaterialButton(
      onPressed: () {
        // Get.toNamed(Routes.FIND_PASSWORD);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find password",
            style: AppTextStyles.bodySmallUnderlineRegular
                .copyWith(color: AppColors.grayLight),
          ),
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    final isEmailValidated = controller.isEmailValidated.value;
    final isNextPressed = controller.isNextPressed.value;
    final isPasswordValid = controller.isPasswordValid.value;
    late Color buttonColors;

    bool isDisabled = (!isEmailValidated && !isPasswordValid) ||
        (isEmailValidated && !isNextPressed && !isPasswordValid);

    String buttonText;
    if (isEmailValidated) {
      if (isNextPressed) {
        if (isPasswordValid) {
          buttonText = "Log in";
          buttonColors = AppColors.primary;
        } else {
          buttonText = "Enter password";
          buttonColors = AppColors.grayLight;
        }
      } else {
        if (isPasswordValid) {
          buttonText = "Log in";
          buttonColors = AppColors.primary;
        } else {
          buttonText = "Next";
          buttonColors = AppColors.black;
        }
      }
    } else {
      if (isPasswordValid) {
        buttonText = "Log in";
        buttonColors = AppColors.grayLight;
      } else {
        buttonText = "Enter your e-mail address";
        buttonColors = AppColors.grayLight;
      }
    }

    return !controller.signingIn.value
        ? ButtonPrimaryFillLogin(
            buttonSizeType: ButtonSizeTypeLogin.MEDIUM,
            isDisabled: isDisabled,
            buttonColor: buttonColors,
            text: buttonText,
            onTap: () {
              if (isEmailValidated && !isNextPressed) {
                controller.isNextPressed(true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  FocusScope.of(context)
                      .requestFocus(controller.passwordFocusNode);
                });
              } else if (isEmailValidated && isPasswordValid) {
                controller.signIn(context);
                // Handle login logic
              } else {
                print(isEmailValidated);
                print(isNextPressed);
                //  Get.offAllNamed(Routes.MAIN_PAGE);
                // Handle login logic
              }
            },
          )
        : SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
  }
}
