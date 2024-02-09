// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/data/model/order_model.dart';

import 'package:sizer/sizer.dart';

class DetailWidget extends StatelessWidget {
  final IcsAllOriginIdApplication icsNewApplicationModel;

  DetailWidget({
    required this.icsNewApplicationModel,
  });

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
      body: Column(
        children: [
          _buildHeader(),
          Divider(
            color: AppColors.grayLighter,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SizedBox(),
          ),
        ],
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
                getName(icsNewApplicationModel),
                style: AppTextStyles.bodyLargeBold
                    .copyWith(color: AppColors.primary),
              ),
              SizedBox(height: 1.h),
              Text(
                getNameAm(icsNewApplicationModel),
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
                    getNameCountry(icsNewApplicationModel),
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

  String getNameAm(IcsAllOriginIdApplication orginApplication) {
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

  String getName(IcsAllOriginIdApplication orginApplication) {
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

  String getNameCountry(IcsAllOriginIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
  }
}
