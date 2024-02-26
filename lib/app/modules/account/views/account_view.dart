import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My',
        title2: 'Account',
        showActions: false,
        showLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            ///HEADER TEXTS
            buildDialogHeader(context),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),

            const DottedLine(
              dashColor: Colors.grey,
            ),

            SizedBox(
              height: AppSizes.mp_v_2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //    Get.toNamed(Routes.JOB_NOTIFICATION);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      //  Get.toNamed(Routes.CHANGE_PASSWORD);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Pin".tr,
                          style: AppTextStyles.bodySmallBold,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () async {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Remove Acccount".tr,
                          style: AppTextStyles.bodySmallBold,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.mp_v_2,
            ),
          ],
        ),
      ),
    );
  }

  buildDialogHeader(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Accounts".tr,
                style: AppTextStyles.captionBold,
              ),
              IconButton(
                onPressed: () {
                  ///CLOSE DIALOG
                  Navigator.pop(context); // Close the dialog
                },
                icon: Icon(
                  Icons.settings,
                  size: AppSizes.icon_size_6,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              right: AppSizes.mp_w_4,
            ),
            child: Text(
              "Manage your account".tr,
              style: AppTextStyles.menuRegular,
            ),
          ),
        ],
      ),
    );
  }
}
