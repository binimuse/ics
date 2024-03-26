import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/app_icon_button.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_sizes.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';

import 'package:ics/app/modules/residency/controllers/residency_controller.dart';

import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/gen/assets.gen.dart';

import 'package:sizer/sizer.dart';

import '../../../common/customappbar.dart';

class ResidencyView extends GetView<ResidencyController> {
  const ResidencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Residency",
        title2: "Type",
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Stack(
        children: [
          Padding(
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
          Obx(
            () => controller.networkStatus.value == NetworkStatus.LOADING
                ? Center(child: CustomLoadingWidget())
                : SizedBox(),
          ),
        ],
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
            Text('Select  Residency type',
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.grayDark,
                )),
            SizedBox(height: 2.h),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.baseResidencyTypeModel.length,
                  itemBuilder: (context, index) {
                    final type = controller.baseResidencyTypeModel[index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ALL_RESIDENCY,
                            arguments: {"ResidencyType": type});

                        AllResidencyController allResidencyController =
                            Get.put(AllResidencyController());
                        final doccode = type.documentCategory!.code;
                        allResidencyController.getDoctype(doccode);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        type.name.toString(),
                                        style: AppTextStyles.bodySmallBold
                                            .copyWith(
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
                                    onPressed: () {
                                      Get.toNamed(Routes.ALL_RESIDENCY,
                                          arguments: {"ResidencyType": type});
                                    },
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
                ))
          ],
        ),
      ),
    );
  }
}
