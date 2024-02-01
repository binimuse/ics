// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/forms/text_input.dart';
import 'package:ics/app/common/navigation/top_nav_back_text.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/signup/controllers/signup_controller.dart';
import 'package:ics/app/modules/signup/views/widget/phone_varfication.dart';
import 'package:ics/app/modules/signup/views/widget/pin_view.dart';
import 'package:sizer/sizer.dart';

class SignUpUserName extends StatefulWidget {
  const SignUpUserName({Key? key}) : super(key: key);

  @override
  _SignUpUserNameState createState() => _SignUpUserNameState();
}

class _SignUpUserNameState extends State<SignUpUserName> {
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///APP BAR
            const TopNavBackText(
              centerTitle: '',
              rightText: '',
              useHomeIcon: false,
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
                        "Your name",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.displayOneBold
                            .copyWith(fontSize: AppSizes.font_14),
                      ),
                      SizedBox(
                        height: AppSizes.mp_v_1,
                      ),
                      Text(
                        "Please Input your Full name",
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
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppSizes.mp_v_1,
                              ),
                              TextInputAll(
                                controller: controller.fNameController,
                                hint: 'First name',
                                textInputAction: TextInputAction.next,
                                showClearButton: false,
                                autoFocus: true,
                                onChanged: (value) {
                                  bool isValid = controller.validateusername();
                                  setState(() {
                                    controller.isUsernameCorrect.value =
                                        isValid;
                                  });
                                  // Validate password on type

                                  // Check if the password is valid and display the appropriate text
                                },
                              ),
                              SizedBox(
                                height: AppSizes.mp_v_1,
                              ),
                              TextInputAll(
                                textInputAction: TextInputAction.next,
                                controller: controller.lNameController,
                                hint: 'Last name',
                                showClearButton: false,
                                onChanged: (value) {
                                  setState(() {
                                    bool isValid =
                                        controller.validateusername();
                                    controller.isUsernameCorrect.value =
                                        isValid;
                                  });
                                  // Validate password on type

                                  // Check if the password is valid and display the appropriate text
                                },
                              ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
              child: Column(
                children: [
                  ButtonPrimaryFill(
                    buttonSizeType: ButtonSizeType.LARGE,
                    isDisabled: !controller.isUsernameCorrect.value,
                    isterms: true,
                    text: controller.isUsernameCorrect.value
                        ? "Next"
                        : "Enter your name",
                    onTap: () {
                      if (controller.isUsernameCorrect.value) {
                        Get.to(SignUppin());
                      } else {
                        AppToasts.showError("Enter your Full Name");
                      }
                    },
                  ),
                  SizedBox(
                    height: AppSizes.mp_v_2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
