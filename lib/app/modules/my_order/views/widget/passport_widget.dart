// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/data/model/order_model.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PassportWidget extends StatelessWidget {
  final RxList<IcsNewApplicationModel> icsNewApplicationModel;

  const PassportWidget({
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
                var citizen = icsNewApplicationModel[index];
                return buildCard(citizen);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(IcsNewApplicationModel citizen) {
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(Assets.icons.passport,
                        color: AppColors.success),
                    onPressed: () {
                      // showModal(context);
                    },
                  ),
                  Text("New Passport",
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
                  citizen.applicationNo.toString(),
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
                    convertToTimeAgo(citizen.createdAt.toString()),
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

  String convertToTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return timeago.format(dateTime);
  }
}
