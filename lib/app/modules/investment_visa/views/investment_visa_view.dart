import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/investment_visa/views/widget/investment_visa_terms.dart';
import 'package:ics/app/modules/investment_visa/views/widget/profile_view_i_visa.dart';
import 'package:sizer/sizer.dart';

import '../controllers/investment_visa_controller.dart';

import 'package:ics/app/common/app_icon_button.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/gen/assets.gen.dart';

class InvestmentVisaView extends GetView<InvestmentVisaController> {
  const InvestmentVisaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Investment',
        title2: "Visa",
        showLeading: true,
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
              itemCount: controller.investmentType.length,
              itemBuilder: (context, index) {
                final confirmation = controller.investmentType[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(InvestmentVisaTerms());
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
                                    confirmation,
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
