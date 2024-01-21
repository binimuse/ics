import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/empty_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/views/widget/passport_widget.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import '../../../common/loading/custom_loading_widget.dart';
import '../controllers/my_order_controller.dart';

class MyOrderView extends GetView<MyOrderController> {
  MyOrderView({Key? key}) : super(key: key);

  final MyOrderController controller = Get.put(MyOrderController());

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Container(
          child: DefaultTabController(
            length: 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SegmentedTabControl(
                    // Customization of widget
                    radius: const Radius.circular(3),
                    backgroundColor: Colors.grey.shade300,
                    indicatorColor: AppColors.primary,
                    tabTextColor: Colors.black45,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,
                    height: 45,
                    tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: AppTextStyles.bodyLargeBold.copyWith(
                        fontSize: AppSizes.font_16, color: AppColors.primary),
                    // Options for selection
                    // All specified values will override the [SegmentedTabControl] setting
                    tabs: [
                      SegmentTab(
                        label: 'Passport',
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                      ),
                      SegmentTab(
                        label: 'Orgin ID',
                      ),
                    ],
                  ),
                ),
                // Sample pages
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      controller.icsNewApplication.isEmpty
                          ? EmpityWidget(
                              title: "No Passport Order found",
                            )
                          : PassportWidget(
                              icsNewApplicationModel:
                                  controller.icsNewApplication),
                      EmpityWidget(
                        title: "No Orgin ID Order found",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
