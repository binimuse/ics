import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/button/custom_normal_button.dart';

import 'package:ics/app/common/customappbar.dart';

import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/utils/constants.dart';
import 'package:ics/utils/lang_util.dart';

import 'package:sizer/sizer.dart';

import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // routeName: Routes.NOTIFICATION,

        title: 'Language'.tr,

        title2: '',
      ),
      body: Container(
        width: 95.w,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_1,
          horizontal: AppSizes.mp_w_2 / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSizes.radius_4,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizes.mp_v_1,
            ),

            ///HEADER TEXTS

            buildDialogHeader(context),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),

            const DottedLine(
              dashColor: Colors.grey,
            ),

            SizedBox(
              height: AppSizes.mp_v_6,
            ),

            ///BUILD LANGUAGE LIST

            buildLanguageList(context),

            SizedBox(
              height: AppSizes.mp_v_6,
            ),

            ///ADD BUTTON

            buildAddButton(context),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),
          ],
        ),
      ),
    );
  }

  buildDialogHeader(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.mp_w_4,
        right: AppSizes.mp_w_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Languages".tr,
                style: AppTextStyles.bodyLargeBold,
              ),
              IconButton(
                onPressed: () {
                  ///CLOSE DIALOG

                  Navigator.pop(context); // Close the dialog
                },
                icon: Icon(
                  Icons.language,
                  size: AppSizes.icon_size_6,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              right: AppSizes.mp_w_4,
            ),
            child: Text(
              "Select your preferred language".tr,
              style: AppTextStyles.bodySmallRegular,
            ),
          ),
        ],
      ),
    );
  }

  buildAddButton(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_4,
      ),
      child: Align(
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: CustomNormalButton(
            text: 'Set Language'.tr,
            onPressed: () {
              ///CLOSE DIALOG

              Get.back();
            },
            padding: const EdgeInsets.all(8.0),
            buttoncolor: AppColors.primary,
            textcolor: AppColors.whiteOff,
          ),
        ),
      ),
    );
  }

  Widget buildLanguageList(BuildContext context) {
    String selectedLanguage = LanUtil.getSelecctedLanguage();

    List<String> languages = [
      Constants.lanEn,
      Constants.lanAm,
      Constants.lanor,
      Constants.lanti,
      Constants.lanso,
    ];

    List<bool> isSelectedFlags =
        languages.map((lang) => lang == selectedLanguage).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.mp_w_8),
        child: Column(
          children: [
            // First row

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LanguageButton(
                  languageName: 'English',
                  isSelected: isSelectedFlags[0],
                  onPressed: () {
                    isSelectedFlags = List.filled(languages.length, false);

                    isSelectedFlags[0] = true;

                    LanUtil.saveLanguage(Constants.lanEn);

                    controller.changeLang(Constants.lanEn);
                  },
                ),
                LanguageButton(
                  languageName: 'አማርኛ',
                  isSelected: isSelectedFlags[1],
                  onPressed: () {
                    isSelectedFlags = List.filled(languages.length, false);

                    isSelectedFlags[1] = true;

                    LanUtil.saveLanguage(Constants.lanAm);

                    controller.changeLang(Constants.lanAm);
                  },
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LanguageButton(
                  languageName: 'Affan Oromoo',
                  isSelected: isSelectedFlags[2],
                  onPressed: () {
                    // isSelectedFlags = List.filled(languages.length, false);
                    // isSelectedFlags[2] = true;
                    // LanUtil.saveLanguage(Constants.lanor);
                    // languagehController.changeLang(Constants.lanor);
                  },
                ),
                LanguageButton(
                  languageName: 'ትግርኛ',
                  isSelected: isSelectedFlags[3],
                  onPressed: () {
                    // isSelectedFlags = List.filled(languages.length, false);
                    // isSelectedFlags[3] = true;
                    // LanUtil.saveLanguage(Constants.lanti);
                    // languagehController.changeLang(Constants.lanti);
                  },
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LanguageButton(
                    languageName: 'Soomaali',
                    isSelected: isSelectedFlags[4],
                    onPressed: () {
                      // setState(() {
                      //   isSelectedFlags = List.filled(languages.length, false);
                      //   isSelectedFlags[4] = true;
                      //   LanUtil.saveLanguage(Constants.lanso);
                      //   languagehController.changeLang(Constants.lanso);
                      // });
                    },
                  ),
                ],
              ),
            ),
            // Second row

            SizedBox(height: 2.h),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     LanguageButton(
            //       languageName: 'Affan Oromoo',
            //       isSelected: isSelectedFlags[2],
            //       onPressed: () {
            //         setState(() {
            //           isSelectedFlags = List.filled(languages.length, false);

            //           isSelectedFlags[2] = true;

            //           LanUtil.saveLanguage(Constants.lanor);

            //           controller.changeLang(Constants.lanor);
            //         });
            //       },
            //     ),
            //     LanguageButton(
            //       languageName: 'ትግርኛ',
            //       isSelected: isSelectedFlags[3],
            //       onPressed: () {
            //         setState(() {
            //           isSelectedFlags = List.filled(languages.length, false);

            //           isSelectedFlags[3] = true;

            //           LanUtil.saveLanguage(Constants.lanti);

            //           controller.changeLang(Constants.lanti);
            //         });
            //       },
            //     ),
            //   ],
            // ),

            // Third row

            SizedBox(height: 2.h),

            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       LanguageButton(
            //         languageName: 'Soomaali',
            //         isSelected: isSelectedFlags[4],
            //         onPressed: () {
            //           setState(() {
            //             isSelectedFlags = List.filled(languages.length, false);

            //             isSelectedFlags[4] = true;

            //             LanUtil.saveLanguage(Constants.lanso);

            //             controller.changeLang(Constants.lanso);
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String languageName;

  final bool isSelected;

  final VoidCallback onPressed;

  LanguageButton({
    required this.languageName,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: 35.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isSelected ? AppColors.primary : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius_4),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            languageName,
            style: AppTextStyles.bodySmallRegular.copyWith(
              fontSize: AppSizes.font_10,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
