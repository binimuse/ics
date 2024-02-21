// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_causole.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class DetailPassportWidget extends StatefulWidget {
  final IcsAllPassportApplication icsAllPassportIdApplication;

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
            child: Container(
              height: 4.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: getStatus(widget.icsAllPassportIdApplication)
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
                    getStatus(widget.icsAllPassportIdApplication),
                    style: AppTextStyles.bodySmallBold.copyWith(
                      color: AppColors.whiteOff,
                      fontSize: 9,
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
                      controller: controller.tabController,
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
        ));
  }

  Widget buildStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
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
            Container(
                width: 80.0,
                height: 80.0,
                child: QrImageView(
                  data: getQrData(widget.icsAllPassportIdApplication),
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
                    child: getImage(widget.icsAllPassportIdApplication) != null
                        ? CachedNetworkImage(
                            imageUrl: Constants.fileViewer +
                                getImage(widget.icsAllPassportIdApplication)!,
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

  String getNameAm(IcsAllPassportApplication orginApplication) {
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

  String getName(IcsAllPassportApplication orginApplication) {
    if (orginApplication.renewApplication != null) {
      return orginApplication.renewApplication!.citizen.firstName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.renewApplication!.citizen.grandFatherName.toString();
    } else if (orginApplication.newApplication != null) {
      return orginApplication.newApplication!.citizen.firstName.toString() +
          " " +
          orginApplication.newApplication!.citizen.fatherName.toString() +
          " " +
          orginApplication.newApplication!.citizen.grandFatherName.toString();
    } else {
      return "";
    }
  }

  String getNameCountry(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
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
            getAppointmentdate(widget.icsAllPassportIdApplication),
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_12,
            ),
          ),
        ],
      ),
    );
  }

  String getAppointmentdate(
      IcsAllPassportApplication icsAllPassportIdApplication) {
    if (icsAllPassportIdApplication.newApplication != null) {
      if (icsAllPassportIdApplication.newApplication!.appointments.isNotEmpty) {
        String formattedDateTime = DateFormat("EEE/d/yyyy").format(
            icsAllPassportIdApplication
                .newApplication!.appointments.first.date);
        return formattedDateTime;
      }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),
        widget.icsAllPassportIdApplication.renewApplication != null
            ? Expanded(child: buildFaqListRenew())
            : Expanded(child: buildFaqListForNew())
      ],
    );
  }

  ListView buildFaqListForNew() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemCount: controller.groupedAppliaction.length,
      itemBuilder: (context, index) {
        var data = widget.icsAllPassportIdApplication.newApplication!
            .newApplicationDocuments[index];
        CurrentCountry documentType = data.documentType;
        return ItemDoc(
          title: data.documentType.name,
          documentType: documentType,
          applicationId:
              widget.icsAllPassportIdApplication.newApplication!.id.toString(),
          controller: controller,
          listOfDoc: controller.groupedAppliaction[index].document,
        );
      },
    );
  }

  ListView buildFaqListRenew() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 1.0,
      ),
      itemCount: widget.icsAllPassportIdApplication.renewApplication!
          .renewPassportApplicationDocuments.length,
      itemBuilder: (context, index) {
        var data = widget.icsAllPassportIdApplication.renewApplication!
            .renewPassportApplicationDocuments[index];
        CurrentCountry documentType = data.documentType;

        return ItemDoc(
          title: data.documentType.name,
          documentType: documentType,
          applicationId: '',
          controller: controller,
          listOfDoc: [],
        );
      },
    );
  }

  String getDateOfBirth(IcsAllPassportApplication icsNewApplicationModel) {
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

  getNationality(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.nationality.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.nationality.name;
    } else {
      return "";
    }
  }

  getBirthCountry(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.birthCountry.name;
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.birthCountry.name;
    } else {
      return "";
    }
  }

  getBirthPlace(IcsAllPassportApplication icsNewApplicationModel) {
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

  getGender(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.gender.toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.gender.toString();
    } else {
      return "";
    }
  }

  getAdoption(IcsAllPassportApplication icsNewApplicationModel) {
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

  getOccupation(IcsAllPassportApplication icsNewApplicationModel) {
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

  getHair(IcsAllPassportApplication icsNewApplicationModel) {
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

  geteyeColor(IcsAllPassportApplication icsNewApplicationModel) {
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

  getSkinColor(IcsAllPassportApplication icsNewApplicationModel) {
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

  getMarital(IcsAllPassportApplication icsNewApplicationModel) {
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

  getheight(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.citizen.height.toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.citizen.height.toString();
    } else {
      return "";
    }
  }

  getCurrentCountry(IcsAllPassportApplication icsNewApplicationModel) {
    if (icsNewApplicationModel.renewApplication != null) {
      return icsNewApplicationModel.renewApplication!.currentCountry.name
          .toString();
    } else if (icsNewApplicationModel.newApplication != null) {
      return icsNewApplicationModel.newApplication!.currentCountry.name
          .toString();
    } else {
      return "";
    }
  }

  getAddress(IcsAllPassportApplication icsNewApplicationModel) {
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

  getPhone(IcsAllPassportApplication icsNewApplicationModel) {
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

  String getNumber(IcsAllPassportApplication icsNewApplicationModel) {
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

  getQrData(IcsAllPassportApplication icsNewApplicationModel) {
    {
      if (icsNewApplicationModel.renewApplication != null) {
        return icsNewApplicationModel.renewApplication!.applicationNo
            .toString();
      } else if (icsNewApplicationModel.newApplication != null) {
        return icsNewApplicationModel.newApplication!.applicationNo.toString();
      } else {
        return "";
      }
    }
  }

  String? getImage(IcsAllPassportApplication icsAllPassportIdApplication) {
    if (icsAllPassportIdApplication.renewApplication != null) {
      if (icsAllPassportIdApplication.renewApplication!.citizen.photo != null) {
        return icsAllPassportIdApplication.renewApplication!.citizen.photo
            .toString();
      }
    } else if (icsAllPassportIdApplication.newApplication != null) {
      if (icsAllPassportIdApplication.newApplication!.citizen.photo != null) {
        return icsAllPassportIdApplication.newApplication!.citizen.photo
            .toString();
      }
    }

    return null;
  }

  getStatus(icsAllPassportIdApplication) {
    if (icsAllPassportIdApplication.renewApplication != null) {
      return "Pending";
    } else if (icsAllPassportIdApplication.newApplication != null) {
      return icsAllPassportIdApplication.newApplication!.reviewStatus
          .toString();
    } else {
      return "";
    }
  }
}
