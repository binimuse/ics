// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';
import 'package:ics/app/modules/all_visa/views/widget/all_visa_terms.dart';

import 'package:sizer/sizer.dart';

import 'package:ics/app/common/app_icon_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/gen/assets.gen.dart';

class AllVisaView extends GetView<ALLVisaController> {
  const AllVisaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.baseVisaTypeModel.name.toString(),
        showLeading: true,
        title2: '',
      ),
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),

            buildAdditionalCard(),

            // Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildAdditionalCard() {
    return GestureDetector(
      onTap: () {
        // controller.toggleTerm(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VISA Selection',
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.grayDark,
                )),
            SizedBox(height: 2.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller
                  .baseVisaTypeModel.visaCategoryValidityTypes!.length,
              itemBuilder: (context, index) {
                final confirmation = controller
                    .baseVisaTypeModel.visaCategoryValidityTypes![index];

                return GestureDetector(
                  onTap: () {
                    final doccode =
                        controller.baseVisaTypeModel.documentCategory!.code;
                    controller.getDoctype(doccode);
                    controller.visa_category_validity_type_id = confirmation.id;
                    Get.to(AllVisaTerms());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: AppColors.grayLight.withOpacity(0.9),
                          width: 1.0,
                        ),
                        color: Colors.transparent),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.icons.paper,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    confirmation.visaValidityType.name
                                        .toString(),
                                    style: AppTextStyles.bodySmallBold.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: AppColors
                                  .primary, // Specify the color of the background

                              borderRadius: BorderRadius.circular(
                                  40), // Make the container circular
                            ),
                            child: ClipOval(
                              child: AppSvgButton(
                                iconColor: AppColors.whiteOff,
                                imagePath: Assets.icons.arrowright,
                                onPressed: () {},
                                size: AppSizes.icon_size_8 * 0.7,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
