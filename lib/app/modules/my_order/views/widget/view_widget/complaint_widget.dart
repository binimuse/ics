// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/ics_complaint_model.dart';
import 'package:ics/app/modules/my_order/views/widget/detail_page_complaint.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ComplaintWidget extends StatelessWidget {
  final IcsServiceComplaintModel icsComplain;
  final MyOrderController controller;

  const ComplaintWidget({
    required this.icsComplain,
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
            buildCard(icsComplain, context),
          ],
        ),
      ),
    );
  }

  Widget buildCard(IcsServiceComplaintModel icsComplain, BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedRating.value = icsComplain.rating;

        _showSummeryDiloag(context);
        // Get.to(DetailPassportWidget(
        //   icsComplain: icsComplain,
        // ));
      },
      child: Container(
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
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(Assets.icons.passport,
                          color: icsComplain.complaintType.complaintService.name
                                      .toString() ==
                                  "Passport"
                              ? AppColors.success
                              : AppColors.danger),
                      onPressed: () {
                        // showModal(context);
                      },
                    ),
                    Text(
                      icsComplain.complaintType.name,
                      style: AppTextStyles.titleBold
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(Assets.icons.message,
                          color: AppColors.grayDark),
                      onPressed: () {
                        // showModal(context);
                      },
                    ),
                    Text(
                      icsComplain.message,
                      style: AppTextStyles.titleBold
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
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
                    icsComplain.complaintType.complaintService.name.toString(),
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
                          color: icsComplain.resolved == null
                              ? AppColors.danger
                              : AppColors.warning,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              icsComplain.resolved == null
                                  ? "Not Resolved yet"
                                  : "Resolved",
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
                        convertToTimeAgo(icsComplain.createdAt.toString()),
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

  _showSummeryDiloag(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailComplaintWidget(
          context: context,
          icsComplain: icsComplain,
          onTap: () {
            controller.rateComplaint(
                icsComplain.id, controller.selectedRating.value, context);
          },
          controller: controller,
        );
      },
    );
  }

  String convertToTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return timeago.format(dateTime);
  }
}
