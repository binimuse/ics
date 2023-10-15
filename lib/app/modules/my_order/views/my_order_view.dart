import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/my_order_controller.dart';

class MyOrderView extends GetView<MyOrderController> {
  const MyOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              buildName(context),
              buildcard(context, "New Passport", "29 Jun 2023 12:00 PM",
                  "Pending", "ID: 123456789"),
              buildcard(context, "Renew Passport", "29 Jun 2023 12:00 PM",
                  "Delivered", "ID: 123456789"),
              buildcard(context, "Renew Passport", "29 Jun 2023 12:00 PM",
                  "Delivered", "ID: 123456789"),
            ],
          ),
        ),
      ),
    );
  }

  buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            'My',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            'Orders',
            style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16, color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }

  buildcard(BuildContext context, String title, String date, String status,
      String id) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 6,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: AppColors.grayLighter, width: 0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.icons.passport,
                      color: status.contains("Pending")
                          ? AppColors.warning
                          : AppColors.success,
                    ),
                    onPressed: () {
                      //showModal(context);
                    },
                  ),
                  Text(title,
                      style: AppTextStyles.bodyLargeBold.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_8 * 0.7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 4.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLighter.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        date,
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: AppColors.primary,
                          fontSize: AppSizes.font_10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_8 * 0.7,
              ),
              child: Text(
                id,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDefault,
                  fontSize: AppSizes.font_10,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_8 * 0.7,
              ),
              child: Container(
                height: 4.h,
                width: 26.w,
                decoration: BoxDecoration(
                  color: status.contains("Pending")
                      ? AppColors.warning
                      : AppColors.success,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.circle,
                        color: AppColors.whiteOff,
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_1 * 0.9,
                      ),
                      child: Text(
                        status,
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: AppColors.whiteOff,
                          fontSize: AppSizes.font_10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
