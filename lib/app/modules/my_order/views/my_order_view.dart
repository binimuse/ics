import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/modules/my_order/views/widget/passport_widget.dart';
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
      body: Obx(() => controller.isFechtedOrder.isTrue
          ? buildBodyContent(context)
          : Center(child: CustomLoadingWidget())),
    );
  }

  buildBodyContent(BuildContext context) {
    return Obx(() {
      if (!controller.isFechtedOrder.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.icsNewApplication.isEmpty) {
        return Center(child: Text('No Passport Order found'));
      } else {
        return PassportWidget(
          icsNewApplicationModel: controller.icsNewApplication,
        );
      }
    });
  }
}
