import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';
import 'package:ics/app/modules/my_order/views/widget/detail_page_passport.dart';
import 'package:ics/gen/assets.gen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PassportWidget extends StatelessWidget {
  final RxList<IcsAllPassportApplication> passportApplication;

  const PassportWidget({
    required this.passportApplication,
  });
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
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: passportApplication.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.mp_v_2 * 1.5),
              itemBuilder: (context, index) {
                var passportApp = passportApplication[index];
                return buildCard(passportApp);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(IcsAllPassportApplication passportApplication) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailPassportWidget(
          icsAllPassportIdApplication: passportApplication,
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
                          color: getColor(passportApplication)),
                      onPressed: () {
                        // showModal(context);
                      },
                    ),
                    Text(getApplicationTypeText(passportApplication),
                        style: AppTextStyles.bodyLargeBold.copyWith(
                          fontWeight: FontWeight.w400,
                        )),
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
                    getApplicationumber(passportApplication),
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
                          color: getStatus(passportApplication)
                                  .contains("REJECTED")
                              ? AppColors.danger
                              : AppColors.warning,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getStatus(passportApplication),
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
                        convertToTimeAgo(
                            passportApplication.createdAt.toString()),
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

  String getApplicationTypeText(
      IcsAllPassportApplication passportIdApplication) {
    if (passportIdApplication.renewApplication != null) {
      if (passportIdApplication.renewApplication!.passportRenewalType != null) {
        return passportIdApplication.renewApplication!.passportRenewalType.name
            .toString();
      }
      return "";
    } else if (passportIdApplication.newApplication != null) {
      return "New Passport Application";
    } else {
      return "Unknown Renewal Application Type";
    }
  }

  String getApplicationumber(IcsAllPassportApplication passportIdApplication) {
    if (passportIdApplication.renewApplication != null) {
      return passportIdApplication.renewApplication!.applicationNo.toString();
    } else if (passportIdApplication.newApplication != null) {
      return passportIdApplication.newApplication!.applicationNo.toString();
    } else {
      return "";
    }
  }

  String convertToTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return timeago.format(dateTime);
  }

  getColor(IcsAllPassportApplication passportIdApplication) {
    if (passportIdApplication.renewApplication != null) {
      if (passportIdApplication.renewApplication!.passportRenewalType != null) {
        if (passportIdApplication.renewApplication!.passportRenewalType.name
            .contains("Lost")) {
          return AppColors.danger;
        } else if (passportIdApplication
            .renewApplication!.passportRenewalType.name
            .contains("Correction")) {
          return AppColors.accent;
        } else if (passportIdApplication
            .renewApplication!.passportRenewalType.name
            .contains("Renew")) {
          return AppColors.warning;
        }
      }
    } else {
      return AppColors.success;
    }
  }

  String getStatus(IcsAllPassportApplication passportApplication) {
    if (passportApplication.renewApplication != null) {
      return "Pending";
    } else if (passportApplication.newApplication != null) {
      return passportApplication.newApplication!.reviewStatus.toString();
    } else {
      return "";
    }
  }
}
