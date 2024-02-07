import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/navigation/top_nav_back_text.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/help/views/widget/tem_faq.dart';
import 'package:sizer/sizer.dart';

import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        title2: 'FAQ',
        showActions: false,
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),

            ///APP BAR

            // SizedBox(height: AppSizes.mp_v_1,),

            Expanded(child: buildFaqList()

                //child: buildEmptyFaq(),
                ),
          ],
        ),
      ),
    );
  }

  ListView buildFaqList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemCount: controller.data.length,
      itemBuilder: (context, index) {
        // Build your list item here using the data from the 'data' list
        return ItemFaq(
          title: controller.data[index]['question'],
          subtitle: controller.data[index]['answer'],
        );
      },
    );
  }

  buildEmptyFaq() {
    return Container(
      color: AppColors.backgroundLight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No registered FAQ yet",
            style: AppTextStyles.titleBold.copyWith(
              color: AppColors.grayDark,
            ),
          ),
          SizedBox(
            height: AppSizes.mp_v_1 / 2,
          ),
          Text(
            "Hold on a minute, please.",
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.grayDefault,
            ),
          ),
        ],
      ),
    );
  }
}
