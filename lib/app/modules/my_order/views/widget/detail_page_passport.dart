// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/timeline/timeline.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_viewer.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class DetailPassportWidget extends StatefulWidget {
  final IcsAllPassportIdApplication icsAllPassportIdApplication;

  DetailPassportWidget({
    required this.icsAllPassportIdApplication,
  });

  @override
  State<DetailPassportWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<DetailPassportWidget> {
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
                      getName(widget.icsAllPassportIdApplication),
                      style: AppTextStyles.bodyLargeBold
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      getNameAm(widget.icsAllPassportIdApplication),
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
                          getNameCountry(widget.icsAllPassportIdApplication),
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
                position: getDateOfBirth(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Nationality",
                position: getNationality(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Birth Country",
                position: getBirthCountry(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Birth Place",
                position: getBirthPlace(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Gender",
                position: getGender(widget.icsAllPassportIdApplication),
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
                position: getNumber(widget.icsAllPassportIdApplication),
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
                position: getAdoption(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Occupation",
                position: getOccupation(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Hair color",
                position: getHair(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "eye color",
                position: geteyeColor(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Skin color",
                position: getSkinColor(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Marital Status",
                position: getMarital(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "height",
                position: getheight(widget.icsAllPassportIdApplication),
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
                position: getCurrentCountry(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Address Detail",
                position: getAddress(widget.icsAllPassportIdApplication),
                duration: ""),
            _buildExperienceRow(
                company: "Phone Number",
                position: getPhone(widget.icsAllPassportIdApplication),
                duration: ""),
          ],
        ),
      ),
    );
  }

  String getNameAm(IcsAllPassportIdApplication orginApplication) {
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

  String getName(IcsAllPassportIdApplication orginApplication) {
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

  String getNameCountry(IcsAllPassportIdApplication icsNewApplicationModel) {
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
              itemCount: 2,
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

  String getDateOfBirth(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      DateTime dateOfBirth =
          icsNewApplicationModel.renewApplication!.citizen.dateOfBirth;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else if (icsNewApplicationModel.newApplication != null) {
      DateTime dateOfBirth =
          icsNewApplicationModel.newApplication!.citizen.dateOfBirth;
      String formattedDate = DateFormat.yMd().format(dateOfBirth);
      return formattedDate;
    } else {
      return "";
    }
  }

  getNationality(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.nationality.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.nationality.name;
    } else {
      return "";
    }
  }

  getBirthCountry(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
  }

  getBirthPlace(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthPlace
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthPlace
          .toString();
    } else {
      return "";
    }
  }

  getGender(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.gender.toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.gender.toString();
    } else {
      return "";
    }
  }

  getAdoption(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.isAdopted
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.isAdopted
          .toString();
    } else {
      return "";
    }
  }

  getOccupation(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.occupation.name
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.occupation.name
          .toString();
    } else {
      return "";
    }
  }

  getHair(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.hairColour
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.hairColour
          .toString();
    } else {
      return "";
    }
  }

  geteyeColor(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.eyeColour
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.eyeColour
          .toString();
    } else {
      return "";
    }
  }

  getSkinColor(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.skinColour
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.skinColour
          .toString();
    } else {
      return "";
    }
  }

  getMarital(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.maritalStatus
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.maritalStatus
          .toString();
    } else {
      return "";
    }
  }

  getheight(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.height.toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.height.toString();
    } else {
      return "";
    }
  }

  getCurrentCountry(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.currentCountry!.name
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.currentCountry!.name
          .toString();
    } else {
      return "";
    }
  }

  getAddress(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.abroadAddress
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.abroadAddress
          .toString();
    } else {
      return "";
    }
  }

  getPhone(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.phoneNumber
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.phoneNumber
          .toString();
    } else {
      return "";
    }
  }

  String getNumber(IcsAllPassportIdApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null &&
        icsNewApplicationModel.renewApplication!.passport_number != null) {
      return icsNewApplicationModel.renewApplication!.passport_number
          .toString();
    } else if (icsNewApplicationModel.newApplication != null &&
        icsNewApplicationModel.newApplication!.passport_number != null) {
      return icsNewApplicationModel.newApplication!.passport_number.toString();
    } else {
      return "";
    }
  }
}
