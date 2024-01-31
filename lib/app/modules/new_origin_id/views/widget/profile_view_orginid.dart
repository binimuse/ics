import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/empty_widget.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/new_orginid_form.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class ProfileViewOrginid extends GetView<NewOriginIdController> {
  const ProfileViewOrginid({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        title2: "Page",
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 1.h,
            ),
            buildDiscription(context),
            buildCard(),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  buildDiscription(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Your Passport  is an essential document while living in Ethiopia for identification purposes.',
            style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_14, color: AppColors.grayDark),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomNormalButton(
              text: 'Add new',
              textStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.whiteOff,
              ),
              leftIcon: Icon(
                Icons.add,
                color: AppColors.whiteOff,
                size: AppSizes.icon_size_8 * 0.8,
              ),
              textcolor: AppColors.whiteOff,
              buttoncolor: AppColors.primary,
              borderRadius: AppSizes.radius_8,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_2,
                horizontal: AppSizes.mp_w_6,
              ),
              onPressed: () {
                clearforstep1();
                clearforstep2();
                clearforstep3();

                Get.to(() => NewOrginIdForm());
              },
            ),
          ),
        ],
      ),
    );
  }

  buildCard() {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => controller.isfechediCitizens.isTrue
                  ? Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: AppSizes.mp_v_2 * 1.5),
                          controller.icsCitizens.isEmpty
                              ? EmpityWidget(title: "No Profile Found")
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.icsCitizens.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: AppSizes.mp_v_2 * 1.5),
                                  itemBuilder: (context, index) {
                                    var citizen = controller.icsCitizens[index];
                                    return buildInfoItem(citizen);
                                  },
                                ),
                        ],
                      ),
                    )
                  : Center(child: CustomLoadingWidget()))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoItem(
    IcsCitizenModelOrginId citizen,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewOrginIdForm(
              citizenModel: citizen,
              
            ));
      },
      child: Container(
        height: 15.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.grayLight,
            width: 1.0,
          ),
          color: AppColors.whiteOff,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: AppColors.grayLighter,
              ),
              height: 5.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  SvgPicture.asset(
                    Assets.icons.profile,
                    color: AppColors.grayDark,
                    width: AppSizes.icon_size_6,
                  ),
                  SizedBox(
                    width: AppSizes.mp_v_1,
                  ),
                  Text(
                    citizen.firstName.toString() +
                        " " +
                        citizen.father_name.toString() +
                        " " +
                        citizen.grand_father_name.toString(),
                    style: AppTextStyles.bodySmallBold.copyWith(
                        color: AppColors.grayDark,
                        fontSize: AppSizes.font_12 * 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSizes.mp_v_4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: AppColors.grayDark,
                        size: AppSizes.icon_size_8 * 0.8,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        citizen.abroadAddress.toString(),
                        style: AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.grayDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: AppColors.grayDark,
                        size: AppSizes.icon_size_8 * 0.8,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        citizen.abroadPhoneNumber.toString(),
                        style: AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.grayDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearforstep1() {
    controller.firstNameController.clear();
    controller.fatherNameController.clear();
    controller.grandFatherNameController.clear();
    controller.AmfirstNameController.clear();
    controller.AmfatherNameController.clear();
    controller.AmgrandFatherNameController.clear();
    controller.dayController.clear();
    controller.monthController.clear();
    controller.yearController.clear();
  }

  void clearforstep2() {
    controller.height.clear();
  }

  void clearforstep3() {
    controller.addressController.clear();
    controller.phonenumber.clear();
  }
}
