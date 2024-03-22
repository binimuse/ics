// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

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
import 'package:ics/app/modules/my_order/data/model/ics_visa_application.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_causolevisa.dart';
import 'package:intl/intl.dart';
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
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getVisaApplication();
            await controller.groupDocumnatsForVisa(widget.icsApplication.id);
          },
          child: Obx(
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
                            fontSize: AppSizes.font_10,
                            color: AppColors.primary),
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
                          controller: controller.tabControllervisa,
                          children: [
                            buildStatus(),
                            buildForm(),
                            buildDocument(),
                          ],
                        ),
                      ),
                    ],
                  ),
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
            Container(
                width: 80.0,
                height: 80.0,
                child: QrImageView(
                  data: widget.icsApplication.id,
                  version: QrVersions.auto,
                  size: 400.0,
                )),
            SizedBox(
              height: 3.h,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                headLines(number: '01', title: 'Personal information'),
                SizedBox(height: 2.h),
                textText(
                    subtitle: 'Given Name',
                    title: '${widget.icsApplication.givenName.toString()}'),
                textText(
                    subtitle: 'Sur Name',
                    title: '${widget.icsApplication.surname.toString()}'),
                textText(
                    subtitle: 'Gender',
                    title: '${widget.icsApplication.gender.toString()}'),
                textText(
                    subtitle: 'Citizens',
                    title: '${widget.icsApplication.nationality.name}'),
                textText(
                    subtitle: "Date of birth(GC)",
                    title: removeHourFromDateTimeString(
                        widget.icsApplication.birthDate.toString())),
                textText(
                    subtitle: "Birth Country",
                    title: '${widget.icsApplication.birthCountry.name}'),
                textText(
                    subtitle: "Birth place",
                    title: '${widget.icsApplication.birthPlace.toString()}'),
                textText(
                    subtitle: "Email",
                    title: '${widget.icsApplication.email.toString()}'),
                textText(
                  subtitle: "Occupation",
                  title: '${widget.icsApplication.occupation.name}',
                ),
                SizedBox(height: 2.h),
                headLines(number: '02', title: 'Address'),
                textText(
                    subtitle: "Address Country",
                    title:
                        '${widget.icsApplication.abroadCountry.name.toString()}'),
                textText(
                    subtitle: "Address city",
                    title: '${widget.icsApplication.city.toString()}'),
                textText(
                    subtitle: "Street address",
                    title: '${widget.icsApplication.streetAddress.toString()}'),
                textText(
                    subtitle: "Phone Number",
                    title: '${widget.icsApplication.phoneNumber.toString()}'),
                SizedBox(height: 2.h),
                headLines(number: '03', title: 'Arrival Information'),
                textText(
                    subtitle: "Arrival Date",
                    title: removeHourFromDateTimeString(
                      widget.icsApplication.arrivalDate.toString(),
                    )),
                textText(
                    subtitle: "Departure  Country",
                    title: '${widget.icsApplication.departureCountry.name}'),
                textText(
                    subtitle: "Departure  City",
                    title: '${widget.icsApplication.departureCity.toString()}'),
                textText(
                    subtitle: "Airline",
                    title: '${widget.icsApplication.airline.toString()}'),
                textText(
                    subtitle: "Flight Number",
                    title: '${widget.icsApplication.flightNumber.toString()}'),
                SizedBox(height: 2.h),
                headLines(number: '04', title: 'Address in Ethiopia'),
                textText(
                    subtitle: "Accommodation Type",
                    title:
                        '${widget.icsApplication.accommodationType.name.toString()}'),
                textText(
                    subtitle: "Accommodation name",
                    title:
                        '${widget.icsApplication.accommodationName.toString()}'),
                textText(
                    subtitle: "Accommodation City",
                    title:
                        '${widget.icsApplication.accommodationCity.toString()}'),
                textText(
                    subtitle: "Accommodation Street Address",
                    title:
                        '${widget.icsApplication.accommodationStreetAddress.toString()}'),
                textText(
                    subtitle: "Accommodation Telephone",
                    title:
                        '${widget.icsApplication.accommodationTelephone.toString()}'),
                SizedBox(height: 2.h),
                headLines(number: '05', title: 'Passport Type'),
                textText(
                    subtitle: "Passport Type",
                    title: '${widget.icsApplication.passportType.name}'),
                textText(
                    subtitle: "Passport  number",
                    title: '${widget.icsApplication.passportNumber}'),
                textText(
                    subtitle: "Passport issue date",
                    title: removeHourFromDateTimeString(
                        widget.icsApplication.passportIssuedDate.toString())),
                textText(
                    subtitle: "Passport expiry date",
                    title: removeHourFromDateTimeString(
                        widget.icsApplication.passportExpiryDate.toString())),
                textText(
                    subtitle: "Passport Issuing Country",
                    title:
                        '${widget.icsApplication.passportIssuingCountry.name}'),
                textText(
                    subtitle: "Passport Issuing Authority",
                    title:
                        '${widget.icsApplication.passportIssuingAuthority.toString()}'),
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
