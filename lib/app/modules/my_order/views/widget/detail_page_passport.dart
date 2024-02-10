// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailWidgetPassport extends StatelessWidget {
  final IcsAllPassportIdApplication passportIdApplication;

  DetailWidgetPassport({
    required this.passportIdApplication,
  });

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
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      MyTimeLineTiles(
                          isFirst: true,
                          isLast: false,
                          isPast: true,
                          eventchild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Passport Order Placed",
                                style: AppTextStyles.menuBold
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                              Text(
                                "you passport order is placed",
                                style: AppTextStyles.menuRegular
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                            ],
                          )),

                      //embassy_approved,shipped, immigration_approved, issued
                      MyTimeLineTiles(
                          isFirst: false,
                          isLast: false,
                          isPast: true,
                          eventchild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Paid",
                                style: AppTextStyles.menuBold
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                              Text(
                                "you have successfully paid the order payment",
                                style: AppTextStyles.menuRegular
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                            ],
                          )),
                      MyTimeLineTiles(
                          isFirst: false,
                          isLast: false,
                          isPast: false,
                          eventchild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Immigration approved",
                                style: AppTextStyles.menuBold
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                              Text(
                                "",
                                style: AppTextStyles.menuRegular
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                            ],
                          )),
                      MyTimeLineTiles(
                          isFirst: false,
                          isLast: true,
                          isPast: false,
                          eventchild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Issued",
                                style: AppTextStyles.menuBold
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                              Text(
                                "",
                                style: AppTextStyles.menuRegular
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                            ],
                          )),
                    ],
                  )),
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
            child: Image.asset(
              AppAssets.qr,
              height: 15.h,
              width: 55.w,
              fit: BoxFit.contain,
            ),
          ),
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
      return orginApplication.renewApplication!.citizen.firstName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherName.toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.firstName.toString() +
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
