// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_passport/controllers/renew_passport_controller.dart';

import 'package:ics/gen/assets.gen.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_svg/svg.dart';

class SummaryDialogReNewPassport extends StatelessWidget {
  final BuildContext context;
  final RenewPassportController controller;
  final VoidCallback onTap;

  const SummaryDialogReNewPassport(
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
                  text: 'Profile',
                  icon: SvgPicture.asset(
                    Assets.icons.profileDefault,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Profile',
                  icon: SvgPicture.asset(
                    Assets.icons.profileDefault,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Address',
                  icon: SvgPicture.asset(
                    Assets.icons.location,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Family Type',
                  icon: SvgPicture.asset(
                    Assets.icons.paper,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  ),
                ),
                Tab(
                  text: 'Passport Detail',
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
                  buildProfile2(),
                  buildAddress(),
                  buildFamilyType(),
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

  buildPassporttype() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Old Passport number",
                position: controller.passportNumberContoller.text.toString(),
                duration: ""),
            controller.correctionTypevalue.value != null
                ? _buildExperienceRow(
                    company: "Correction",
                    position: controller.correctionTypevalue.value!.name,
                    duration: "")
                : SizedBox(),
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
                company: "Current Country",
                position: controller.currentcountryvalue.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Address Detail",
                position: controller.addressController.text,
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

  buildProfile2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Adoption",
                position: controller.isAdoption.value.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: controller.occupationvalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Hair color",
                position: controller.haircolorvalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "eye color",
                position: controller.eyecolorvalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "Skin color",
                position: controller.skincolorvalue.value,
                duration: ""),
            _buildExperienceRow(
                company: "Marital Status",
                position: controller.maritalstatusvalue.value!.name,
                duration: ""),
            _buildExperienceRow(
                company: "height",
                position: controller.height.text,
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildFamilyType() {
    return Column(
      children: controller.familyModelvalue.map((element) {
        final firstName = element.first_name ?? '';
        final fatherName = element.father_name ?? '';
        final type = element.family_type!.name;

        return Column(
          children: [
            _buildExperienceRow(company: "Type", position: type, duration: ""),
            _buildExperienceRow(
                company: "Full Name",
                position: "${firstName}  ${fatherName}",
                duration: ""),
          ],
        );
      }).toList(),
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
                          controller.firstNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                        SizedBox(width: 1.h),
                        Text(
                          controller.firstNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                        SizedBox(width: 1.h),
                        Text(
                          controller.firstNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Text(
                          controller.AmfirstNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                        SizedBox(width: 1.h),
                        Text(
                          controller.AmfatherNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                        SizedBox(width: 1.h),
                        Text(
                          controller.AmgrandFatherNameController.text,
                          style: AppTextStyles.bodySmallRegular
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ],
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
                          controller.currentcountryvalue.value!.name.toString(),
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
                position: controller.natinalityvalue.value!.name,
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
