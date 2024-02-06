// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:order_tracker/order_tracker.dart';

class DetailWidget extends StatelessWidget {
  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders',
        title2: 'Status',
        showActions: false,
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: Status.order,
          headingDateTextStyle: AppTextStyles.bodySmallRegular
              .copyWith(fontSize: AppSizes.font_10, color: AppColors.grayDark),
          headingTitleStyle: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
          subTitleTextStyle: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_12, color: AppColors.black),
          subDateTextStyle: AppTextStyles.bodySmallRegular
              .copyWith(fontSize: AppSizes.font_10, color: AppColors.grayDark),
          activeColor: AppColors.primary,
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderList,
          shippedTitleAndDateList: shippedList,
          outOfDeliveryTitleAndDateList: outOfDeliveryList,
          deliveredTitleAndDateList: deliveredList,
        ),
      ),
    );
  }
}
