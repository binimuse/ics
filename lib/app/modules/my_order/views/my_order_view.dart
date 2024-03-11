// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/views/widget/orgin_widget.dart';
import 'package:ics/app/modules/my_order/views/widget/passport_widget.dart';
import 'package:ics/app/modules/my_order/views/widget/visa_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../common/loading/custom_loading_widget.dart';
import '../controllers/my_order_controller.dart';

import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
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
        title: 'My',
        title2: 'Orders',
        showActions: false,
        showLeading: false,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Obx(() => controller.isfechedorder.isTrue
          ? buildBodyContent(context)
          : Center(child: CustomLoadingWidget())),
    );
  }

  buildBodyContent(BuildContext context) {
    return Column(children: [
      TabBar(
        controller: controller.tabController,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelStyle: AppTextStyles.bodyLargeBold
            .copyWith(fontSize: AppSizes.font_10, color: AppColors.primary),
        tabs: [
          Tab(
              text: 'Passport',
              icon: SvgPicture.asset(
                Assets.icons.passport,
                color: AppColors.primary,
                fit: BoxFit.contain,
              )),
          Tab(
              text: 'Origin ID',
              icon: SvgPicture.asset(
                Assets.icons.profileDefault,
                color: AppColors.primary,
                fit: BoxFit.contain,
              )),
          Tab(
              text: 'Visa',
              icon: SvgPicture.asset(
                Assets.icons.paper,
                color: AppColors.primary,
                fit: BoxFit.contain,
              )),
          Tab(
              text: 'Resident Permit',
              icon: SvgPicture.asset(
                Assets.icons.memo,
                color: AppColors.primary,
                fit: BoxFit.contain,
              )),
          Tab(
              text: 'Service Complaint',
              icon: SvgPicture.asset(
                Assets.icons.question,
                color: AppColors.primary,
                fit: BoxFit.contain,
              )),
        ],
      ),
      Expanded(
        child: TabBarView(
          controller: controller.tabController,
          children: [
            Container(
              height: 100.h,
              child: ListView.builder(
                itemCount: controller.allApplicationModel.length,
                itemBuilder: (context, index) {
                  var element = controller.allApplicationModel[index];
                  if (element.applicationType
                          .contains("NEW_PASSPORT_APPLICATION") ||
                      element.applicationType
                          .contains("RENEW_PASSPORT_APPLICATION")) {
                    return PassportWidget(
                      icsApplication: controller.allApplicationModel[index],
                      controller: controller,
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
            // Sample pages
            Container(
              height: 100.h,
              child: ListView.builder(
                itemCount: controller.allApplicationModel.length,
                itemBuilder: (context, index) {
                  var element = controller.allApplicationModel[index];
                  if (element.applicationType
                          .contains("NEW_ORIGIN_ID_APPLICATION") ||
                      element.applicationType
                          .contains("RENEW_ORIGIN_ID_APPLICATION")) {
                    return OrginIdWidget(
                      icsApplication: controller.allApplicationModel[index],
                      controller: controller,
                    );
                  }
                  return SizedBox();
                },
              ),
            ),

            Container(
              height: 100.h,
              child: ListView.builder(
                itemCount: controller.allVisaApplicationModel.length,
                itemBuilder: (context, index) {
                  return VisaWidget(
                    icsApplication: controller.allVisaApplicationModel[index],
                    controller: controller,
                  );
                },
              ),
            ),

            Container(height: 100.h, child: SizedBox()),
            Container(height: 100.h, child: SizedBox()),
          ],
        ),
      ),
    ]);
  }
}



  // buildBodyContent(BuildContext context) {
  //   return Obx(() {
  //     if (!controller.isFechtedOrder.value) {
  //       return Center(child: CircularProgressIndicator());
  //     } else if (controller.icsNewApplication.isEmpty) {
  //       return Center(child: Text('No Passport Order found'));
  //     } else {
  //       return PassportWidget(
  //         icsNewApplicationModel: controller.icsNewApplication,
  //       );
  //     }
  //   });
  // }