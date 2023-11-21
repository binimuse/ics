// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/forms/check_box.dart';
import 'package:ics/app/common/navigation/top_nav_back_icon.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/gen/assets.gen.dart';

import '../../../../config/theme/app_text_styles.dart';

class TermsView extends StatefulWidget {
  const TermsView({Key? key}) : super(key: key);

  @override
  _TermsViewState createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  late ValueNotifier<bool> allTermsChecked;
  late List<ValueNotifier<bool>> termCheckboxes;

  @override
  void initState() {
    super.initState();

    // Initialize allTermsChecked and termCheckboxes in the state's initState
    allTermsChecked = ValueNotifier<bool>(false);
    termCheckboxes = [
      ValueNotifier<bool>(false), // Checkbox for "Terms of Use"
      ValueNotifier<bool>(false), // Checkbox for "Privacy Notice"
      // Add more checkboxes if needed
    ];
  }

  void toggleAllTerms() {
    setState(() {
      final bool isChecked = allTermsChecked.value;

      for (final termCheckbox in termCheckboxes) {
        termCheckbox.value = isChecked;
      }
    });
  }

  void toggleTerm(int index) {
    setState(() {
      termCheckboxes[index].value = !termCheckboxes[index].value;

      // Uncheck the "I agree with all terms" checkbox if any term checkbox is unchecked
      if (!termCheckboxes[index].value) {
        allTermsChecked.value = false;
      } else {
        // Check the "I agree with all terms" checkbox if all term checkboxes are checked
        allTermsChecked.value =
            termCheckboxes.every((checkbox) => checkbox.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///APP BAR
            const TopNavBackIcon(
              centerTitle: '',
              useRightIcon: false,
              useHomeIcon: false,
            ),

            SizedBox(
              height: AppSizes.mp_v_4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///PAGE TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
                    child: Text(
                      "Accept Terms & Review\nPrivacy Notice",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.displayOneBold,
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Checkbox for "I agree with all terms"
                              MyCheckBox(
                                isInitSelected: allTermsChecked.value,
                                checkBoxSize: CheckBoxSize.LARGE,
                                onChanged: (isChecked) {
                                  allTermsChecked.value = isChecked;
                                  toggleAllTerms();
                                },
                                text: "I agree with all terms",
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizes.mp_v_1 / 2,
                                horizontal: AppSizes.mp_w_3),
                            child: Divider(
                              color: AppColors.grayLighter,
                              thickness: 1,
                            ),
                          ),
                          // Individual term checkboxes
                          for (int index = 0;
                              index < termCheckboxes.length;
                              index++)
                            Row(
                              children: [
                                MyCheckBox(
                                  isInitSelected: termCheckboxes[index].value,
                                  checkBoxSize: CheckBoxSize.MEDIUM,
                                  onChanged: (isChecked) {
                                    toggleTerm(index);
                                  },
                                  text: index == 0
                                      ? "I agree with the Terms of Use"
                                      : "I agree with the Privacy Policy",
                                ),
                                const Expanded(child: SizedBox()),
                                const Expanded(child: SizedBox()),
                                AppSvgButton(
                                  imagePath: Assets.icons.chevronRight,
                                  iconColor: AppColors.grayDefault,
                                  onPressed: () {},
                                  size: AppSizes.icon_size_6,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: AppSizes.mp_v_4,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_4),
                    child: ButtonPrimaryFill(
                      isterms: true,
                      buttonSizeType: ButtonSizeType.LARGE,
                      isDisabled: !allTermsChecked
                          .value, // Disable the button if not all terms are checked
                      text: "Next",
                      onTap: () {
                        if (allTermsChecked.value) {
                          // Only navigate if all terms are checked
                          Get.toNamed(Routes.SIGNUP);
                        } else {
                          AppToasts.showError("All Terms are not Checked");
                        }
                      },
                    ),
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

  @override
  void dispose() {
    // Dispose of ValueNotifier objects when the widget is disposed
    allTermsChecked.dispose();
    for (final termCheckbox in termCheckboxes) {
      termCheckbox.dispose();
    }
    super.dispose();
  }
}
