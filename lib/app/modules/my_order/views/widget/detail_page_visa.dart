// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

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
import 'package:ics/app/modules/my_order/data/model/ics_visa_application.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_causolevisa.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class DetailVisaWidget extends StatefulWidget {
  final IcsVisaApplication icsApplication;

  DetailVisaWidget({
    required this.icsApplication,
  });

  @override
  State<DetailVisaWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<DetailVisaWidget> {
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
          title: 'Order',
          title2: 'Status',
          showActions: true,
          showLeading: true,
          actionIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 4.h,
              width: 25.w,
              decoration: BoxDecoration(
                color: widget.icsApplication.reviewStatus.contains("REJECTED")
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
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                      controller: controller.tabControllervisa,
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
                            text: 'Address',
                            icon: SvgPicture.asset(
                              Assets.icons.location,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Arrival Info',
                            icon: SvgPicture.asset(
                              Assets.icons.flagrounded,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Address In Ethiopa',
                            icon: SvgPicture.asset(
                              Assets.icons.location,
                              color: AppColors.primary,
                              fit: BoxFit.contain,
                            )),
                        Tab(
                            text: 'Passport Info',
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
                          print("object");
                          await controller.getVisaApplication();
                          await controller
                              .groupDocumnatsForVisa(widget.icsApplication.id);
                        },
                        header: MaterialHeader(),
                        child: SizedBox(
                          height: 100.h,
                          width: double
                              .infinity, // Set the width to occupy all available space
                          child: TabBarView(
                            controller: controller.tabControllervisa,
                            children: [
                              buildStatus(),
                              buildProfile(),
                              buildAddress(),
                              buildArrivalInfo(),
                              buildAddressInEthiopa(),
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
                  "Visa Order Placed",
                  style: AppTextStyles.menuBold
                      .copyWith(color: AppColors.whiteOff),
                ),
                Text(
                  "Your Visa order is placed",
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
            _buildCompanyNumber(),
            SizedBox(height: 2.h),
            Container(
                width: 80.0,
                height: 80.0,
                child: QrImageView(
                  data: widget.icsApplication.applicationNo,
                  version: QrVersions.auto,
                  size: 200.0,
                )),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 2.h),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.icsApplication.givenName.toString() +
                          " " +
                          widget.icsApplication.surname.toString(),
                      style: AppTextStyles.bodyLargeBold
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h),
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
                company: "Gender",
                position: widget.icsApplication.gender.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Citizenship",
                position: widget.icsApplication.nationality.name,
                duration: ""),
            _buildExperienceRow(
                company: "Birth Country",
                position: widget.icsApplication.birthCountry.name,
                duration: ""),
            _buildExperienceRow(
                company: "Birth Place",
                position: widget.icsApplication.birthPlace.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Email",
                position: widget.icsApplication.email.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: widget.icsApplication.occupation.name,
                duration: ""),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Company Reference Number :- ",
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
            ),
          ),
          Text(
            widget.icsApplication.companyReferenceNumber,
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
                company: "Passport Type",
                position: widget.icsApplication.passportType.name,
                duration: ""),
            _buildExperienceRow(
                company: "Passport number",
                position: widget.icsApplication.passportNumber,
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issue date",
                position: widget.icsApplication.passportIssuedDate.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport Expiry date",
                position: widget.icsApplication.passportExpiryDate.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issusing country",
                position: widget.icsApplication.passportIssuingCountry.name,
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issusing authority",
                position:
                    widget.icsApplication.passportIssuingAuthority.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildArrivalInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitle("Arrival information"),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Arrival  Date(GC)",
                position: widget.icsApplication.arrivalDate.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Departure Country",
                position: widget.icsApplication.departureCountry.name,
                duration: ""),
            _buildExperienceRow(
                company: "Departure City",
                position: widget.icsApplication.departureCity.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Airline",
                position: widget.icsApplication.airline.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Flight Number",
                position: widget.icsApplication.flightNumber.toString(),
                duration: ""),
          ],
        ),
      ),
    );
  }

  buildAddressInEthiopa() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTitle("Address in Ethiopia"),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Accommodation Type",
                position:
                    widget.icsApplication.accommodationType.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation name",
                position: widget.icsApplication.accommodationName.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation City",
                position: widget.icsApplication.accommodationCity.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation Street Address",
                position:
                    widget.icsApplication.accommodationStreetAddress.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Accommodation Telephone",
                position:
                    widget.icsApplication.accommodationTelephone.toString(),
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
                company: "Address Country",
                position: widget.icsApplication.abroadCountry.name.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Address city",
                position: widget.icsApplication.city.toString(),
                duration: ""),
            _buildExperienceRow(
                company: "Street Address",
                position: widget.icsApplication.streetAddress.toString(),
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
    return controller.groupedAppliactionvisa.length != 0
        ? ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(
              height: 1.0,
            ),
            itemCount: controller.groupedAppliactionvisa.length,
            itemBuilder: (context, index) {
              return ItemDocVisa(
                title:
                    controller.groupedAppliactionvisa[index].documentType.name,
                documentType:
                    controller.groupedAppliactionvisa[index].documentType,
                controller: controller,
                listOfDoc: controller.groupedAppliactionvisa[index].document,
                applicationId: widget.icsApplication.id,
              );
            },
          )
        : SizedBox();
  }
}
