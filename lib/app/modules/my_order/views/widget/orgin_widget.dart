import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

import 'package:ics/app/modules/my_order/views/widget/detail_page_origin.dart';
import 'package:ics/gen/assets.gen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrginIdWidget extends StatelessWidget {
  final RxList<IcsAllOriginIdApplication> icsNewApplicationModel;

  const OrginIdWidget({
    required this.icsNewApplicationModel,
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
              itemCount: icsNewApplicationModel.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppSizes.mp_v_2 * 1.5),
              itemBuilder: (context, index) {
                var orginApplication = icsNewApplicationModel[index];
                return buildCard(orginApplication);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(IcsAllOriginIdApplication orginApplication) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailOriginWidget(
          icsNewApplicationModel: orginApplication,
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
                          color: getColor(orginApplication)),
                      onPressed: () {
                        // showModal(context);
                      },
                    ),
                    Text(getApplicationTypeText(orginApplication),
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
                    getApplicationumber(orginApplication),
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
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Pending",
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
                        convertToTimeAgo(orginApplication.createdAt.toString()),
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

  String getApplicationTypeText(IcsAllOriginIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.originIdRenewalType.name
          .toString();
    } else if (orginApplication.newApplication != null) {
      return "New Orgin ID Application";
    } else {
      return "Unknown Renewal Application Type";
    }
  }

  String getApplicationumber(IcsAllOriginIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.applicationNo.toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.applicationNo.toString();
    } else {
      return "";
    }
  }

  String convertToTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return timeago.format(dateTime);
  }

  getColor(IcsAllOriginIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      if (orginApplication.renewApplication!.originIdRenewalType.name
          .contains("Lost")) {
        return AppColors.danger;
      } else if (orginApplication.renewApplication!.originIdRenewalType.name
          .contains("Correction")) {
        return AppColors.accent;
      } else if (orginApplication.renewApplication!.originIdRenewalType.name
          .contains("Renew")) {
        return AppColors.warning;
      }
    } else {
      return AppColors.success;
    }
  }
}
