import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/complain_page/views/widget/complain_inquiry_screen.dart';
import 'package:ics/app/modules/home/views/home_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/complain_page_controller.dart';

class ComplainPageView extends GetView<ComplainPageController> {
  const ComplainPageView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Complaint',
        title2: 'Services',
        showActions: false,
        showLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 85.w,
              child: Text(
                'Your feedback is important for our service improvement. Please pick the service you have an issue with.',
                style: AppTextStyles.captionRegular.copyWith(
                    fontSize: AppSizes.font_12, color: AppColors.grayDark),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 40.h,
              width: 95.w,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CardWidget(
                    isOrgin: index == 0 ? false : true,
                    title: controller.labels[index],
                    svgPath: controller.icons[index],
                    iconColor: controller.color[index],
                    onPressed: index == 0
                        ? () {
                            Get.to(ComplainInquiryScreen(
                              complainType: ComplainType.passport,
                            ));
                          }
                        : index == 1
                            ? () {
                                Get.to(ComplainInquiryScreen(
                                  complainType: ComplainType.originId,
                                ));
                              }
                            : index == 2
                                ? () {
                                    Get.to(ComplainInquiryScreen(
                                      complainType: ComplainType.residentPermit,
                                    ));
                                  }
                                : index == 3
                                    ? () {
                                        Get.to(ComplainInquiryScreen(
                                          complainType: ComplainType.visa,
                                        ));
                                      }
                                    : () {
                                        Get.to(ComplainInquiryScreen(
                                            complainType: ComplainType.other));
                                      },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
