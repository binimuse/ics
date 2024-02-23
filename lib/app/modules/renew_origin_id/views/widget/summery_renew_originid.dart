// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';

import 'package:ics/gen/assets.gen.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_svg/svg.dart';

class SummaryDialogReNewOriginId extends StatelessWidget {
  final BuildContext context;
  final RenewOriginIdController controller;
  final VoidCallback onTap;

  const SummaryDialogReNewOriginId(
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

  buildPassporttype() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Current Passport number",
                position: controller.passportNumberContoller.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport issue date",
                position:
                    controller.passportIssueDateController.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport expiry date",
                position:
                    controller.passportExpiryDateController.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Visa acquiring method",
                position: controller.visatypevalue.value!.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "visa  number",
                position: controller.visanumberContoller.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "visa  issue dat",
                position: controller.visaIssueDateController.text.toString(),
                duration: ""),

            _buildExperienceRow(
                company: "visa  expiry date",
                position: controller.visaExpiryDateController.text.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Origin Id Number",
                position: controller.orginIdnumberContoller.text.toString(),
                duration: ""),
            // Text(
            //   "Signature",
            //   style: AppTextStyles.bodyLargeBold.copyWith(
            //     color: AppColors.black,
            //     fontSize: 12,
            //   ),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // Obx(
            //   () => controller.showImage.value
            //       ? Container(
            //           height: 15.h,
            //           width: 55.w,
            //           child: controller.signatureImage != null
            //               ? Image(
            //                   image: controller.signatureImage!,
            //                   fit: BoxFit.contain,
            //                 )
            //               : Placeholder(), // Placeholder or any other widget to show when image is null
            //         )
            //       : SizedBox(),
            // )
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
