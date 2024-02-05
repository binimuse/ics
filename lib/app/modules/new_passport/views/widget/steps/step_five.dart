// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:sizer/sizer.dart';
import '../../../../../config/theme/app_sizes.dart';
import '../docpicker.dart';

class Step5 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
  // other properties go here

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 5',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_14, color: AppColors.primary),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'Upload document ...',
            style: AppTextStyles.bodySmallRegular.copyWith(
                fontSize: AppSizes.font_12, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          height: 100.h,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.base_document_types.length,
            itemBuilder: (BuildContext context, int index) {
              CommonModel documentType = controller.base_document_types[index];
              return BuildDoc(
                documentType: documentType,
                controller: controller,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                  height: 8.0); // Adjust the space between items as needed
            },
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
