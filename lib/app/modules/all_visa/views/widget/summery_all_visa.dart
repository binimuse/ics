// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';

import 'package:ics/gen/assets.gen.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_svg/svg.dart';

class SummaryAllVisa extends StatelessWidget {
  final BuildContext context;
  final ALLVisaController controller;
  final VoidCallback onTap;

  const SummaryAllVisa(
      {required this.context, required this.onTap, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            "Confirm your input",
            style: AppTextStyles.bodySmallRegular,
          ),
        ],
      ),
      actions: [
        Column(
          children: [
            TabBar(
              controller: controller.tabController,
              physics: NeverScrollableScrollPhysics(),
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              labelStyle: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_10,
                color: AppColors.primary,
              ),
              tabs: [
                Tab(
                  text: 'Personal information',
                  icon: SvgPicture.asset(
                    Assets.icons.profileDefault,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Personal Address information',
                  icon: SvgPicture.asset(
                    Assets.icons.profileDefault,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Arrival information',
                  icon: SvgPicture.asset(
                    Assets.icons.location,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Address in Ethiopia',
                  icon: SvgPicture.asset(
                    Assets.icons.passport,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Passport in Ethiopia',
                  icon: SvgPicture.asset(
                    Assets.icons.passport,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 65.h,
              width: 30.h, // Set the width to occupy all available space
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  buildProfile(),
                  buildAddress(),
                  buildArrival(),
                  buildAddressEthiopia(),
                  buildPassporttype(),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Edit".tr,
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.danger,
                      AppColors.danger,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Confirm".tr,
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildAddressEthiopia() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Accommodation Type",
                position:
                    controller.accommodationtypevalue.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation name",
                position: controller.accommodation_name.text,
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation City",
                position: controller.accommodation_city.text,
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation Street Address",
                position: controller.accommodation_street_address.text,
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation Telephone",
                position: controller.accommodation_Telephone.text,
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildAddress() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Address Country",
                position: controller.adresscountryvalue.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Address Detail",
                position: controller.addresscityController.text,
                duration: ""),
            _buildExperienceRow(
                company: "Street address",
                position: controller.streetaddressController.text,
                duration: ""),
            _buildExperienceRow(
                company: "Phone Number",
                position: controller.phonenumber.text,
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildArrival() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Arrival Date",
                position: controller.arrivaldDateController.text,
                duration: ""),
            _buildExperienceRow(
                company: "Departure  Country",
                position: controller.departurecountry.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Departure  City",
                position: controller.departurecity.text,
                duration: ""),
            _buildExperienceRow(
                company: "Airline",
                position: controller.airline.text,
                duration: ""),
            _buildExperienceRow(
                company: "Flight Number",
                position: controller.flight_Number.text,
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildProfile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          controller.givenNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                        SizedBox(width: 1.h),
                        Text(
                          controller.surNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
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
                          controller.citizenship.value!.name.toString(),
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            _buildExperienceRow(
                company: "Date of birth(GC)",
                position:
                    "${controller.dayController.text}/ ${controller.monthController.text}/${controller.yearController.text}",
                duration: ""),
            _buildExperienceRow(
                company: "Nationality",
                position: controller.citizenship.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Birth Country",
                position: controller.birthCountryvalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Birth Place",
                position: controller.birthplace.text,
                duration: ""),
            _buildExperienceRow(
                company: "Gender",
                position: controller.gendervalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Email",
                position: controller.emailAdress.text,
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: controller.occupationvalue.value!.name.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildPassporttype() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Passport Type",
                position: controller.passporttypevalue.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport  number",
                position: controller.passport_number.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport issue date",
                position: controller.passportIssueDate.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport expiry date",
                position: controller.passportexpiryDate.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issuing Country",
                position:
                    controller.passportIssueCountry.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issuing Authority",
                position: controller.passportIssueAuthority.text.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  ListTile _buildExperienceRow({
    required String company,
    String? position,
    String? duration,
  }) {
    return ListTile(
      visualDensity:
          VisualDensity.compact, // Add this line to reduce the vertical spacing
      contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 0), // Add this line to adjust the vertical padding
      leading: Icon(
        Icons.circle,
        size: 8.0, // Adjust the size of the icon here
        color: Colors.black54,
      ),
      title: Text(
        company,
        style: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        "$position",
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.black,
          fontSize: 12,
        ),
      ),
    );
  }

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }
}
