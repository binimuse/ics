// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_causole.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class DetailOriginWidget extends StatefulWidget {
  final IcsApplication icsApplication;

  DetailOriginWidget({
    required this.icsApplication,
  });

  @override
  State<DetailOriginWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<DetailOriginWidget> {
  late MyOrderController controller;
  @override
  void initState() {
    controller = Get.put(MyOrderController());

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
          child: Container(
            height: 4.h,
            width: 20.w,
            decoration: BoxDecoration(
              color: AppColors.warning,
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
                    fontSize: AppSizes.font_10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.whiteOff,
      body: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          TabBar(
            controller: controller.tabController,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelStyle: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_10, color: AppColors.primary),
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
            child: TabBarView(
              controller: controller.tabController,
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
        ],
      ),
    );
  }

  Widget buildStatus() {
    return Container(
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
                  "Origin Id Order Placed",
                  style: AppTextStyles.menuBold
                      .copyWith(color: AppColors.whiteOff),
                ),
                Text(
                  "Your Origin ID order is placed",
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
            _buildAppointemnt(),
            SizedBox(height: 2.h),
            Container(
                width: 80.0,
                height: 80.0,
                child: QrImageView(
                  data: getQrData(widget.icsApplication),
                  version: QrVersions.auto,
                  size: 200.0,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 2.h),
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
                      style: AppTextStyles.bodyLargeBold
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
            "",
            //, getAppointmentdate(widget.icsApplication),
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
            ),
          ),
        ],
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
            _buildExperienceRow(
                company: "Passport Issue date",
                position: getIssuedate(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Passport Expiry date",
                position: getExpirydate(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Visa type",
                position: getVisaType(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Visa Number",
                position: getVisaNumber(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Visa Issue date",
                position: getVisaIssuedDate(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Visa Expiry date",
                position: getVisaExpiryDate(widget.icsApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Origin Id number",
                position: getOriginnumber(widget.icsApplication),
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
                position: widget.icsApplication.occupation.toString(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Expanded(child: buildFaqListForNew())
      ],
    );
  }

  ListView buildFaqListForNew() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemCount: widget.icsApplication.applicationDocuments.length,
      itemBuilder: (context, index) {
        var data = widget.icsApplication.applicationDocuments[index];
        CurrentCountry documentType = data.documentType;
        return ItemDoc(
          title: data.documentType.name,
          documentType: documentType,
          applicationId: widget.icsApplication.id,
          controller: controller,
          listOfDoc: controller.groupedAppliaction[index].document,
        );
      },
    );
  }

  getnumber(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      return icsApplication
          .renewalOriginIdApplications.first.currentPassportNumber
          .toString();
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      return icsApplication.newOriginIdApplications.first.currentPassportNumber
          .toString();
    } else {
      return "";
    }
  }

  getIssuedate(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      DateTime dateOfBirth = icsApplication
          .renewalOriginIdApplications.first.currentPassportIssuedDate;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      DateTime dateOfBirth = icsApplication
          .newOriginIdApplications.first.currentPassportIssuedDate;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else {
      return "";
    }
  }

  getExpirydate(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      DateTime dateOfBirth = icsApplication
          .renewalOriginIdApplications.first.currentPassportExpiryDate;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      DateTime dateOfBirth = icsApplication
          .newOriginIdApplications.first.currentPassportExpiryDate;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else {
      return "";
    }
  }

  getVisaType(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      return icsApplication.renewalOriginIdApplications.first.visaType.name
          .toString();
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      return icsApplication.newOriginIdApplications.first.visaType.name
          .toString();
    } else {
      return "";
    }
  }

  getVisaNumber(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      return icsApplication.renewalOriginIdApplications.first.visaNumber
          .toString();
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      return icsApplication.newOriginIdApplications.first.visaNumber.toString();
    } else {
      return "";
    }
  }

  String getVisaExpiryDate(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      DateTime? visaExpiryDate =
          icsApplication.renewalOriginIdApplications.first.visaExpiryDate;
      String formattedDate = DateFormat.yMd().format(visaExpiryDate);
      return formattedDate;
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      DateTime? visaExpiryDate = null;
      if (visaExpiryDate != null) {
        String formattedDate = DateFormat.yMd().format(visaExpiryDate);
        return formattedDate;
      }
    }

    return "";
  }

  String getVisaIssuedDate(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      DateTime? visaIssuedDate =
          icsApplication.renewalOriginIdApplications.first.visaIssuedDate;
      String formattedDate = DateFormat.yMd().format(visaIssuedDate);
      return formattedDate;
    } else if (icsApplication.newOriginIdApplications.isNotEmpty) {
      DateTime? visaIssuedDate = null;
      if (visaIssuedDate != null) {
        String formattedDate = DateFormat.yMd().format(visaIssuedDate);
        return formattedDate;
      }
    }

    return "";
  }

  getOriginnumber(IcsApplication icsApplication) {
    if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
      return icsApplication.renewalOriginIdApplications.first.originIdNumber
          .toString();
    } else if (icsApplication.newOriginIdApplications != null) {
      return "";
    } else {
      return "";
    }
  }

  getQrData(IcsApplication icsApplication) {
    {
      if (icsApplication.renewalOriginIdApplications.isNotEmpty) {
        return icsApplication.renewalOriginIdApplications.first.applicationNo
            .toString();
      } else if (icsApplication.newOriginIdApplications != null) {
        return icsApplication.newOriginIdApplications.first.applicationNo
            .toString();
      } else {
        return "";
      }
    }
  }

  String getAppointmentdate(IcsApplication icsApplication) {
    String formattedDateTime = DateFormat("EEE/d/yyyy")
        .format(icsApplication.applicationAppointments.first.date);
    return formattedDateTime;
  }
}
