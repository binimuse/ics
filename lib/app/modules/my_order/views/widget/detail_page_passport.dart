// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';

import 'package:ics/app/modules/my_order/views/widget/doc_causole.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class DetailPassportWidget extends StatefulWidget {
  final IcsApplication icsApplication;

  DetailPassportWidget({
    required this.icsApplication,
  });

  @override
  State<DetailPassportWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<DetailPassportWidget> {
  late MyOrderController controller;
  @override
  void initState() {
    controller = Get.find<MyOrderController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Orders',
          title2: 'Status',
          showActions: true,
          showLeading: true,
          actionIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => controller.isfechedorder.value
                    ? Container(
                        height: 4.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: widget.icsApplication.reviewStatus
                                  .contains("REJECTED")
                              ? AppColors.danger
                              : AppColors.warning,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.icsApplication.reviewStatus,
                              style: AppTextStyles.bodySmallBold.copyWith(
                                color: AppColors.whiteOff,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              )),
        ),
        backgroundColor: AppColors.whiteOff,
        body: Obx(
          () => controller.networkStatus.value == NetworkStatus.LOADING
              ? CustomLoadingWidget()
              : Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    TabBar(
                      controller: controller.tabControllerPassport,
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
                      labelStyle: AppTextStyles.bodyLargeBold.copyWith(
                          fontSize: AppSizes.font_10, color: AppColors.primary),
                      tabs: [
                        Tab(text: 'Status', icon: Icon(Icons.check_circle)),
                        Tab(
                            text: 'Profile',
                            icon: SvgPicture.asset(
                              Assets.icons.profileDefault,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Profile',
                            icon: SvgPicture.asset(
                              Assets.icons.profileDefault,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Address',
                            icon: SvgPicture.asset(
                              Assets.icons.location,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Passport',
                            icon: SvgPicture.asset(
                              Assets.icons.paper,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Document',
                            icon: SvgPicture.asset(
                              Assets.icons.memo,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                      ],
                    ),
                    Expanded(
                      child: EasyRefresh(
                        onRefresh: () async {
                          await controller.getOrginOrder();
                        },
                        header: MaterialHeader(),
                        child: SizedBox(
                          height: 100.h,
                          width: double
                              .infinity, // Set the width to occupy all available space
                          child: TabBarView(
                            controller: controller.tabControllerPassport,
                            children: [
                              buildStatus(),
                              buildProfile(),
                              buildProfile2(),
                              buildAddress(),
                              buildPassportInfo(),
                              buildDocument(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget buildStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildTitle("status"),
          _buildAppointemnt(),
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
                  "Your Passport order is placed",
                  style: AppTextStyles.menuRegular
                      .copyWith(color: AppColors.whiteOff),
                ),
              ],
            ),
          ),
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
                  "You have successfully paid the order payment",
                  style: AppTextStyles.menuRegular
                      .copyWith(color: AppColors.whiteOff),
                ),
              ],
            ),
          ),
          MyTimeLineTiles(
            isFirst: false,
            isLast: false,
            isrejected: widget.icsApplication.reviewStatus.contains("REJECTED")
                ? true
                : false,
            isPast: true,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.icsApplication.reviewStatus,
                  style: AppTextStyles.menuBold
                      .copyWith(color: AppColors.whiteOff),
                ),
                Text(
                  "",
                  style: AppTextStyles.menuRegular
                      .copyWith(color: AppColors.whiteOff),
                ),
              ],
            ),
          ),
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
            ),
          ),
        ],
      ),
    );
  }

  buildProfile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitle("Personal Detail"),
            SizedBox(height: 2.h),
            Container(
                width: 80.0,
                height: 80.0,
                child: QrImageView(
                  data: getQrData(widget.icsApplication),
                  version: QrVersions.auto,
                  size: 200.0,
                )),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20.0),
                Container(
                    width: 80.0,
                    height: 80.0,
                    child: widget.icsApplication.photo != null
                        ? CachedNetworkImage(
                            imageUrl: Constants.fileViewer +
                                widget.icsApplication.photo,
                            fit: BoxFit.contain,
                            height: 28.h,
                            width: double.infinity,
                            placeholder: (context, str) => Container(
                              color: AppColors.whiteOff,
                              height: 28.h,
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.whiteOff,
                              height: 28.h,
                            ),
                          )
                        : Container(
                            color: AppColors.danger,
                            height: 28.h,
                            alignment: Alignment.center,
                            child: Text(
                              'No image found',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.menuBold
                                  .copyWith(color: AppColors.whiteOff),
                            ),
                          )),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.icsApplication.firstName.toString() +
                          "" +
                          widget.icsApplication.fatherName.toString() +
                          widget.icsApplication.grandFatherName.toString() +
                          "",
                      style: AppTextStyles.bodyLargeRegular
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      widget.icsApplication.firstNameJson.am.toString() +
                          "" +
                          widget.icsApplication.fatherNameJson.am.toString() +
                          widget.icsApplication.grandFatherNameJson.am
                              .toString() +
                          "",
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
                          widget.icsApplication.birthCountry.name.toString(),
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
            _buildExperienceRow(
                company: "Date of birth(GC)",
                position: widget.icsApplication.dateOfBirth.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Nationality",
                position: widget.icsApplication.nationality.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Birth Country",
                position: widget.icsApplication.birthCountry.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Birth Place",
                position: widget.icsApplication.birthPlace.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Gender",
                position: widget.icsApplication.gender.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildPassportInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitle("Passport Information"),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Current Passport number",
                position: getnumber(widget.icsApplication),
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
            _buildTitle("More Personal Detail "),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Adoption",
                position: widget.icsApplication.isAdopted.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: widget.icsApplication.occupation.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Hair color",
                position: widget.icsApplication.hairColour.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "eye color",
                position: widget.icsApplication.eyeColour.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Skin color",
                position: widget.icsApplication.skinColour.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Marital Status",
                position: widget.icsApplication.maritalStatus.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "height",
                position: widget.icsApplication.height.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildAddress() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitle("Address Detail"),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Current Country",
                position: widget.icsApplication.currentCountry.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Address Detail",
                position: widget.icsApplication.abroadAddress.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Phone Number",
                position: widget.icsApplication.phoneNumber.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointemnt() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Appointemnt date :- ",
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
            ),
          ),
          Text(
            getAppointmentdate(widget.icsApplication),
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
            ),
          ),
        ],
      ),
    );
  }

  String getAppointmentdate(IcsApplication icsApplication) {
    if (icsApplication.applicationAppointments.isNotEmpty) {
      String formattedDateTime = DateFormat("EEE/d/yyyy")
          .format(icsApplication.applicationAppointments.first.date);
      return formattedDateTime;
    }
    return "";
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_14,
            ),
          ),
          const Divider(
            color: Colors.black54,
          ),
        ],
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
          vertical: 1.0,
          horizontal: 5.0), // Add this line to adjust the vertical padding
      leading: Icon(
        Icons.circle,
        size: 8.0, // Adjust the size of the icon here
        color: Colors.black54,
      ),
      title: Text(
        company,
        style: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_10,
        ),
      ),
      subtitle: Text(
        "$position",
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_10,
        ),
      ),
    );
  }

  buildDocument() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemCount: controller.groupedAppliaction.length,
      itemBuilder: (context, index) {
        return ItemDoc(
          title: controller.groupedAppliaction[index].documentType.name,
          documentType: controller.groupedAppliaction[index].documentType,
          controller: controller,
          listOfDoc: controller.groupedAppliaction[index].document,
          applicationId: widget.icsApplication.id,
        );
      },
    );
  }

  getQrData(IcsApplication icsNewApplicationModel) {
    {
      if (icsNewApplicationModel.renewPassportApplications.isNotEmpty) {
        return icsNewApplicationModel
            .renewPassportApplications.first.applicationNo
            .toString();
      } else if (icsNewApplicationModel.newPassportApplications.isNotEmpty) {
        return icsNewApplicationModel
            .newPassportApplications.first.applicationNo
            .toString();
      } else {
        return "";
      }
    }
  }

  getnumber(IcsApplication icsApplication) {
    if (icsApplication.renewPassportApplications.isNotEmpty) {
      return icsApplication.renewPassportApplications.first.passportNumber
          .toString();
    } else if (icsApplication.newPassportApplications.isNotEmpty) {
      return "";
    } else {
      return "";
    }
  }
}
