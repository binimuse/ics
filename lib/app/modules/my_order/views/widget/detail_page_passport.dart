// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/data/model/order_model.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:sizer/sizer.dart';

class DetailWidgetPassport extends StatelessWidget {
  final IcsAllPassportIdApplication passportIdApplication;

  DetailWidgetPassport({
    required this.passportIdApplication,
  });
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
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Orders',
          title2: 'Status',
          showActions: false,
          showLeading: true,
        ),
        backgroundColor: AppColors.whiteOff,
        body: Column(
          children: [
            _buildHeader(),
            Divider(
              color: AppColors.grayLighter,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: OrderTracker(

                status: Status.order,
                
                headingDateTextStyle: AppTextStyles.bodySmallRegular.copyWith(
                    fontSize: AppSizes.font_10, color: AppColors.grayDark),
                headingTitleStyle: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.primary),
                subTitleTextStyle: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_12, color: AppColors.black),
                subDateTextStyle: AppTextStyles.bodySmallRegular.copyWith(
                    fontSize: AppSizes.font_10, color: AppColors.grayDark),
                activeColor: AppColors.primary,
                inActiveColor: Colors.grey[300],
                
                orderTitleAndDateList: orderList,
                shippedTitleAndDateList: shippedList,
                outOfDeliveryTitleAndDateList: outOfDeliveryList,
                deliveredTitleAndDateList: deliveredList,

              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20.0),
          SizedBox(
              width: 80.0,
              height: 80.0,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 35.0,
                  ))),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getName(passportIdApplication),
                style: AppTextStyles.bodyLargeBold
                    .copyWith(color: AppColors.primary),
              ),
              SizedBox(height: 1.h),
              Text(
                getNameAm(passportIdApplication),
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_14,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.map,
                    size: 12.0,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    getNameCountry(passportIdApplication),
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: AppColors.black,
                      fontSize: AppSizes.font_10,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String getNameAm(IcsAllPassportIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.citizen.firstNameJson.am
              .toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherNameJson.am
              .toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.newApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.newApplication!.citizen.grandFatherNameJson.am
              .toString();
    } else {
      return "";
    }
  }

  String getName(IcsAllPassportIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherName.toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.newApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.newApplication!.citizen.grandFatherName.toString();
    } else {
      return "";
    }
  }

  String getNameCountry(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
  }
}
