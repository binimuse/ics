// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

import 'package:ics/app/modules/my_order/views/widget/detail_page_passport.dart';
import 'package:ics/gen/assets.gen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PassportWidget extends StatelessWidget {
  final IcsApplication icsApplication;
  final MyOrderController controller;

  const PassportWidget({
    required this.icsApplication,
    required this.controller,
  });
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildCard(icsApplication),
          ],
        ),
      ),
    );
  }

  Widget buildCard(IcsApplication icsApplication) {
    return GestureDetector(
      onTap: () {
        controller.groupDocumnats(icsApplication.id);
        Get.to(DetailPassportWidget(
          icsApplication: icsApplication,
        ));
      },
      child: Container(
        height: 21.h,
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(Assets.icons.passport,
                          color: getColor(icsApplication)),
                      onPressed: () {
                        // showModal(context);
                      },
                    ),
                    Text(
                      getApplicationame(icsApplication),
                      style: AppTextStyles.bodyLargeBold.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
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
                    getApplicationumber(icsApplication),
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.primary,
                      fontSize: AppSizes.font_10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 4.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color:
                              icsApplication.reviewStatus.contains("REJECTED")
                                  ? AppColors.danger
                                  : AppColors.warning,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              icsApplication.reviewStatus.toString(),
                              style: AppTextStyles.bodySmallBold.copyWith(
                                color: AppColors.whiteOff,
                                fontSize: AppSizes.font_10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        convertToTimeAgo(icsApplication.createdAt.toString()),
                        style: AppTextStyles.displayOneRegular.copyWith(
                          color: AppColors.grayDark,
                          fontSize: AppSizes.font_10,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getApplicationumber(IcsApplication passportIdApplication) {
    if (passportIdApplication.renewPassportApplications.isNotEmpty) {
      return passportIdApplication.renewPassportApplications.first.applicationNo
          .toString();
    } else if (passportIdApplication.newPassportApplications.isNotEmpty) {
      return passportIdApplication.newPassportApplications.first.applicationNo
          .toString();
    }
    return "";
  }

  String convertToTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return timeago.format(dateTime);
  }

  getColor(IcsApplication passportIdApplication) {
    if (passportIdApplication.renewPassportApplications.isNotEmpty) {
      if (passportIdApplication
          .renewPassportApplications.first.passportRenewalType.name
          .contains("Lost")) {
        return AppColors.danger;
      } else if (passportIdApplication
          .renewPassportApplications.first.passportRenewalType.name
          .contains("Correction")) {
        return AppColors.accent;
      } else if (passportIdApplication
          .renewPassportApplications.first.passportRenewalType.name
          .contains("Renew")) {
        return AppColors.warning;
      }
    } else {
      return AppColors.success;
    }
  }

  String getApplicationame(IcsApplication orginApplication) {
    if (orginApplication.applicationType == "NEW_PASSPORT_APPLICATION") {
      return "New Passport Application";
    } else if (orginApplication.applicationType ==
        "RENEW_PASSPORT_APPLICATION") {
      return "ReNew Passport Application";
    } else {
      return "";
    }
  }
}
