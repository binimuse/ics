import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/empty_widget.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/all_visa/data/model/ics_companies.dart';
import 'package:ics/app/modules/all_visa/data/model/visa_appliaction_model.dart';
import 'package:ics/app/modules/all_visa/views/widget/all_visa_form.dart';
import 'package:ics/app/modules/all_visa/controllers/all_visa_controller.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class ProfileViewInvestmentvisa extends GetView<ALLVisaController> {
  final List<IcsCompanies>? icsCompanies;

  ProfileViewInvestmentvisa({
    this.icsCompanies,
  });
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Visa',
        title2: "Applications",
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Row(
              children: [
                Icon(
                  Icons.apartment,
                  color: AppColors.primary,
                  size: AppSizes.icon_size_8 * 0.8,
                ),
                SizedBox(
                  width: 2.h,
                ),
                Text(
                  icsCompanies?.first.name ?? "",
                  style: AppTextStyles.captionRegular.copyWith(
                      fontSize: AppSizes.font_18, color: AppColors.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Divider(color: AppColors.primaryDark),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 80.w,
              child: Text(
                'Your Visa  is an essential document for ...',
                style: AppTextStyles.captionRegular.copyWith(
                    fontSize: AppSizes.font_14, color: AppColors.grayDark),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
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

                Get.to(() => AllVisaForm());
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
                          controller.icsVisaApplicationModel.isEmpty
                              ? EmpityWidget(title: "No visa Application Found")
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.icsVisaApplicationModel.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: AppSizes.mp_v_2 * 1.5),
                                  itemBuilder: (context, index) {
                                    var citizen = controller
                                        .icsVisaApplicationModel[index];
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
    IcsVisaApplicationModel citizen,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AllVisaForm(
              visaApplicationModel: citizen,
            ));
      },
      child: Container(
        height: 15.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.primaryDark,
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
                color: AppColors.primaryLighter,
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
                    citizen.givenName.toString() +
                        " " +
                        citizen.surname.toString(),
                    style: AppTextStyles.bodySmallBold.copyWith(
                        color: AppColors.grayDark,
                        fontSize: AppSizes.font_12 * 1.0),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                    ),
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
                        citizen.abroadCountry!.name.toString(),
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
                        citizen.phoneNumber.toString(),
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
    controller.givenNameController.clear();
    controller.surNameController.clear();

    controller.birthplace.clear();
    controller.emailAdress.clear();

    controller.dayController.clear();
    controller.monthController.clear();
    controller.yearController.clear();
  }

  void clearforstep2() {
    controller.streetaddressController.clear();
    controller.addresscityController.clear();
    controller.phonenumber.clear();
  }

  void clearforstep3() {
    controller.arrivaldDateController.clear();
    controller.departurecity.clear();
    controller.airline.clear();
    controller.flight_Number.clear();
  }
}
