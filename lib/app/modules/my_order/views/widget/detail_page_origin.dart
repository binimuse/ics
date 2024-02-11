// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/my_order/data/model/order_model.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_viewer.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class DetailOriginWidget extends StatefulWidget {
  final IcsAllOriginIdApplication icsNewApplicationModel;

  DetailOriginWidget({
    required this.icsNewApplicationModel,
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
                  "Pending",
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
                  text: 'Passort',
                  icon: SvgPicture.asset(
                    Assets.icons.paper,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  )),
              Tab(
                  text: 'Docement',
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
            isPast: false,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Immigration approved",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20.0),
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Image.asset(
                    AppAssets.qr,
                    height: 15.h,
                    width: 55.w,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      getName(widget.icsNewApplicationModel),
                      style: AppTextStyles.bodyLargeBold
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      getNameAm(widget.icsNewApplicationModel),
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
                          getNameCountry(widget.icsNewApplicationModel),
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
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Nationality",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Birth Country",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Birth Place",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Gender",
                position: "Wordpress Developer",
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
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Passport Issue date",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Passport Expiry date",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Visa type",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Visa Number",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Visa Issue date",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Visa Expiry date",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Origin Id number",
                position: "Wordpress Developer",
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
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Hair color",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "eye color",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Skin color",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Marital Status",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Hight",
                position: "Wordpress Developer",
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
            _buildTitle("Address Detail "),
            SizedBox(height: 2.h),
            _buildExperienceRow(
                company: "Current Country",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Address Detail",
                position: "Wordpress Developer",
                duration: ""),
            _buildExperienceRow(
                company: "Phone Number",
                position: "Wordpress Developer",
                duration: ""),
          ],
        ),
      ),
    );
  }

  String getNameAm(IcsAllOriginIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.citizen.firstNameJson.am
              .toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherNameJson.am
              .toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.newApplication!.citizen.fatherNameJson.am
              .toString() +
          " " +
          orginApplication.newApplication!.citizen.grandFatherNameJson.am
              .toString();
    } else {
      return "";
    }
  }

  String getName(IcsAllOriginIdApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherName.toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.newApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.newApplication!.citizen.grandFatherName.toString();
    } else {
      return "";
    }
  }

  String getNameCountry(IcsAllOriginIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
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
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 50.w,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return BuildDocViewer(
                  pdfPath: '',
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 8.0); // Adjust the space between items as needed
              },
            ),
          )),
    );
  }
}
