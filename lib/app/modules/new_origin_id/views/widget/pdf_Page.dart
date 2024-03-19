import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';

import 'package:sizer/sizer.dart';

class PdfPageNewOriginId extends StatelessWidget {
  final BuildContext context;
  final NewOriginIdController controller;
  final VoidCallback onTap;

  PdfPageNewOriginId(
      {required this.context, required this.onTap, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 40, right: 40),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.blueGrey.shade100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 15, right: 15),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.blueGrey.shade200,
              ),
            ),
          ),

          //00416A
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(27),
                  topLeft: Radius.circular(27),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded),
                          ),
                          Text(
                            'Confirm Your input',
                            style: AppTextStyles.bodyLargeBold,
                          ),
                          SizedBox(
                            width: 2.h,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            headLines(number: '01', title: 'Profile'),
                            showImage(controller.selectedImages.first),
                            SizedBox(height: 2.h),
                            textText(
                                subtitle: 'First Name',
                                title:
                                    '${controller.firstNameController.text}'),
                            textText(
                                subtitle: 'Father Name',
                                title:
                                    '${controller.fatherNameController.text}'),
                            textText(
                                subtitle: 'Grand Father Name',
                                title:
                                    '${controller.grandFatherNameController.text}'),
                            textText(
                                subtitle: 'የመጀመሪያ ስም',
                                title:
                                    '${controller.AmfirstNameController.text}'),
                            textText(
                                subtitle: 'የአባት ስም',
                                title:
                                    '${controller.AmfatherNameController.text}'),
                            textText(
                                subtitle: 'የአያት ስም',
                                title:
                                    '${controller.AmgrandFatherNameController.text}'),
                            textText(
                                subtitle: "Birth date",
                                title:
                                    '${controller.dayController.text}/ ${controller.monthController.text}/${controller.yearController.text}'),
                            textText(
                                subtitle: "Nationality",
                                title:
                                    '${controller.natinalityvalue.value!.name}'),
                            textText(
                                subtitle: "Birth Country",
                                title:
                                    '${controller.birthCountryvalue.value!.name}'),
                            textText(
                                subtitle: "Birth place",
                                title: '${controller.birthplace.text}'),
                            textText(
                                subtitle: "Gender",
                                title: '${controller.gendervalue.value!.name}'),
                            textText(
                                subtitle: "Adoption ?",
                                title:
                                    '${controller.isAdoption.value == true ? 'yes' : 'no'}'),
                            textText(
                                subtitle: "Occupation",
                                title:
                                    '${controller.occupationvalue.value?.name ?? ""}'),
                            textText(
                                subtitle: "Hair color",
                                title:
                                    '${controller.haircolorvalue.value?.name ?? ""}'),
                            textText(
                                subtitle: "eye color",
                                title: controller.eyecolorvalue.value == null
                                    ? ""
                                    : '${controller.eyecolorvalue.value!.name.toString()}'),
                            textText(
                                subtitle: "Skin color",
                                title: '${controller.skincolorvalue.value}'),
                            textText(
                                subtitle: "Marital Status",
                                title: controller.eyecolorvalue.value == null
                                    ? ""
                                    : '${controller.maritalstatusvalue.value!.name}'),
                            textText(
                                subtitle: "height",
                                title: '${controller.height.text}'),
                            SizedBox(height: 2.h),
                            headLines(number: '02', title: 'Address'),
                            textText(
                                subtitle: "Current Country",
                                title:
                                    '${controller.currentcountryvalue.value!.name.toString()}'),
                            textText(
                                subtitle: "Address Detail",
                                title: '${controller.addressController.text}'),
                            textText(
                                subtitle: "Phone Number",
                                title: '${controller.phonenumber.text}'),
                            SizedBox(height: 2.h),
                            headLines(number: '03', title: 'Passport Detail'),
                            textText(
                                subtitle: "Current Passport number",
                                title: '${controller.phonenumber.text}'),
                            textText(
                                subtitle: "Passport issue date",
                                title: '${controller.phonenumber.text}'),
                            textText(
                                subtitle: "Passport expiry date",
                                title: '${controller.phonenumber.text}'),
                            textText(
                                subtitle: "Visa acquiring method",
                                title: '${controller.phonenumber.text}'),
                            textText(
                                subtitle: "visa  number",
                                title: '${controller.phonenumber.text}'),
                            SizedBox(height: 4.h),
                            headLines(number: '04', title: 'Signature'),
                            SizedBox(height: 4.h),
                            Obx(
                              () => controller.showImage.value
                                  ? Container(
                                      height: 15.h,
                                      width: 55.w,
                                      child: controller.signatureImage != null
                                          ? Image(
                                              image: controller.signatureImage!,
                                              fit: BoxFit.contain,
                                            )
                                          : Placeholder(), // Placeholder or any other widget to show when image is null
                                    )
                                  : SizedBox(),
                            ),
                            SizedBox(height: 2.h),
                            buildButton(),
                            Container(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headLines({required String number, required String title}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              number,
              style: AppTextStyles.titleBold,
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 3,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.titleBold.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget textText({required String subtitle, required String title}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    '$subtitle :  ',
                    style: AppTextStyles.bodyLargeBold,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: AppTextStyles.bodyLargeRegular,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColors.primaryDark),
        ],
      ),
    );
  }

  showImage(dynamic path) {
    Widget imageWidget;

    if (path is File) {
      // Determine if the path is a local file or network URL
      Uri? uri;
      try {
        uri = Uri.parse(path.path);
      } catch (e) {
        uri = null;
      }

      if (uri != null && uri.isAbsolute) {
        // Selected image is from a network URL
        imageWidget = Container(
          width: 26.w,
          height: 15.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: uri.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      } else {
        // Selected image is from a local file
        imageWidget = Container(
          width: 26.w,
          height: 15.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              path,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    } else {
      // Invalid image path or URL
      imageWidget = SizedBox(); // or any other placeholder widget
    }

    return imageWidget;
  }

  buildButton() {
    return Row(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                "Back".tr,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                "Confirm".tr,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.whiteOff,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
