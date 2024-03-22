// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_assets.dart';
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
                            text: 'Documents',
                            icon: SvgPicture.asset(
                              Assets.icons.memo,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabControllerPassport,
                        children: [
                          buildStatus(),
                          buildForm(),
                          buildDocument(),
                        ],
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
                _buildAppointemnt(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAppointemnt() {
    return Column(
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

  buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.splasehimage2,
              height: 5.h,
              width: 55.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    child: QrImageView(
                      data: widget.icsApplication.id,
                      version: QrVersions.auto,
                      size: 400.0,
                    )),
                SizedBox(
                  width: 5.w,
                ),
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
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                headLines(number: '01', title: 'Personal information'),
                SizedBox(height: 2.h),
                textText(
                    subtitle: 'First name',
                    title: '${widget.icsApplication.firstName.toString()}'),
                textText(
                    subtitle: 'Father Name',
                    title: '${widget.icsApplication.fatherName.toString()}'),
                textText(
                    subtitle: 'Grand Father Name',
                    title:
                        '${widget.icsApplication.grandFatherName.toString()}'),
                textText(
                    subtitle: 'የመጀመሪያ ስም',
                    title:
                        '${widget.icsApplication.firstNameJson.am.toString()}'),
                textText(
                    subtitle: "የአባት ስም",
                    title:
                        '${widget.icsApplication.fatherNameJson.am.toString()}'),
                textText(
                    subtitle: "የአያት ስም",
                    title: '${widget.icsApplication.grandFatherNameJson.am}'),
                textText(
                  subtitle: "Gender",
                  title: '${widget.icsApplication.gender.toString()}',
                ),
                textText(
                    subtitle: "Birth place",
                    title: '${widget.icsApplication.birthPlace.toString()}'),
                textText(
                    subtitle: "Birth Country",
                    title:
                        '${widget.icsApplication.birthCountry.name.toString()}'),
                textText(
                    subtitle: "Date of birth(GC)",
                    title: removeHourFromDateTimeString(
                        widget.icsApplication.dateOfBirth.toString())),
                textText(
                  subtitle: "Nationality",
                  title: '${widget.icsApplication.nationality.toString()}',
                ),
                textText(
                  subtitle: "Adoption",
                  title: '${widget.icsApplication.isAdopted.toString()}',
                ),
                textText(
                  subtitle: "Occupation",
                  title:
                      '${widget.icsApplication.occupation?.name.toString() ?? ""}',
                ),
                textText(
                  subtitle: "Hair color",
                  title: '${widget.icsApplication.hairColour}',
                ),
                textText(
                  subtitle: "eye color",
                  title: '${widget.icsApplication.eyeColour}',
                ),
                textText(
                  subtitle: "Skin color",
                  title: '${widget.icsApplication.skinColour}',
                ),
                textText(
                  subtitle: "Marital Status",
                  title: '${widget.icsApplication.maritalStatus}',
                ),
                textText(
                  subtitle: "height",
                  title: '${widget.icsApplication.height}',
                ),
                SizedBox(height: 2.h),
                headLines(number: '02', title: 'Address'),
                textText(
                    subtitle: "Current Country",
                    title:
                        '${widget.icsApplication.currentCountry.name.toString()}'),
                textText(
                    subtitle: "Address Detail",
                    title: '${widget.icsApplication.abroadAddress.toString()}'),
                textText(
                    subtitle: "Phone Number",
                    title: '${widget.icsApplication.phoneNumber.toString()}'),
                SizedBox(height: 2.h),
                headLines(number: '03', title: 'Passport Information'),
                textText(
                    subtitle: "Current Passport number",
                    title: getnumber(widget.icsApplication)),
                SizedBox(height: 2.h),
                Container(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
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
                    style: AppTextStyles.bodyLargeBold.copyWith(fontSize: 18),
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

  String removeHourFromDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDateTime;
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
