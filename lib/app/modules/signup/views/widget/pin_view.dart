// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/forms/text_input_signup.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/common/navigation/top_nav_back_text.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/signup/controllers/signup_controller.dart';
import 'package:sizer/sizer.dart';

class SignUppin extends StatefulWidget {
  const SignUppin({Key? key}) : super(key: key);

  @override
  _SignUpUserNameState createState() => _SignUpUserNameState();
}

class _SignUpUserNameState extends State<SignUppin> {
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///APP BAR
                const TopNavBackText(
                  centerTitle: '',
                  rightText: '',
                  useHomeIcon: false,
                ),

                SizedBox(
                  height: AppSizes.mp_v_2,
                ),

                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.splasehimage2,
                            height: 13.h,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Enter Pin Number",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.displayOneBold
                                .copyWith(fontSize: AppSizes.font_14),
                          ),
                          SizedBox(
                            height: AppSizes.mp_v_1,
                          ),
                          Text(
                            "Please Input your Pin Number",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.bodySmallRegular.copyWith(
                                color: AppColors.grayDark,
                                fontSize: AppSizes.font_10),
                          ),
                          SizedBox(
                            height: AppSizes.mp_v_1,
                          ),
                          Form(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.mp_w_4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: AppSizes.mp_v_2,
                                  ),
                                  buildpininput(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Expanded(
                  child: SizedBox(),
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
                    child: Column(
                      children: [
                        ButtonPrimaryFill(
                          buttonSizeType: ButtonSizeType.LARGE,
                          isDisabled: !controller.isPasswordValid.value,
                          isterms: true,
                          text: controller.isPasswordValid.value
                              ? "Finish"
                              : "Enter pin Number",
                          onTap: () {
                            if (controller.isPasswordValid.value) {
                              controller.signUp();
                            } else {
                              AppToasts.showError("Enter your pin nUmber");
                            }
                          },
                        ),
                        SizedBox(
                          height: AppSizes.mp_v_2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => controller.networkStatus.value == NetworkStatus.LOADING
                  ? CustomLoadingWidget()
                  : SizedBox(),
            ),
          ],
        ),
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
}
