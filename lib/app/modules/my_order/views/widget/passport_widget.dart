import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class PassportWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildCard(context, "ReNew Passport", "29 Jun 2023 12:00 PM",
                "Pending", "ID: 123456789"),
            buildCard(context, "New Passport", "29 Jun 2023 12:00 PM",
                "Delivered", "ID: 123456789"),
            buildCard(context, "New Passport", "29 Jun 2023 12:00 PM",
                "Delivered", "ID: 123456789"),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, String date,
      String status, String id) {
    return Container(
      height: 20.h,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.icons.passport,
                      color: status.contains("Pending")
                          ? AppColors.warning
                          : AppColors.success,
                    ),
                    onPressed: () {
                      // showModal(context);
                    },
                  ),
                  Text(title,
                      style: AppTextStyles.bodyLargeBold.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 4.h,
                      width: 22.w,
                      decoration: BoxDecoration(
                        color: status.contains("Pending")
                            ? AppColors.warning
                            : AppColors.success,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            status,
                            style: AppTextStyles.bodySmallBold.copyWith(
                              color: AppColors.whiteOff,
                              fontSize: AppSizes.font_10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLighter.withOpacity(0.2),
                // borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  id,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.primary,
                    fontSize: AppSizes.font_10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    date,
                    style: AppTextStyles.displayOneRegular.copyWith(
                      color: AppColors.grayDark,
                      fontSize: AppSizes.font_10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
