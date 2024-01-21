import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/logout/views/logout_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My',
        title2: 'Settings',
        showActions: false,
        showLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 1.h,
            ),

            _buildSettingCard(
              icon: Icons.person,
              title: 'Account'.tr,
              subtitle: 'Manage your Account'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.info,
              title: 'About us'.tr,
              subtitle: 'Learn more about us'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.message,
              title: 'Contact us'.tr,
              subtitle: 'Get in touch with us'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.document_scanner_sharp,
              title: 'Terms and Conditions'.tr,
              subtitle: 'Read the terms and conditions'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.shield,
              title: 'Privacy Policy'.tr,
              subtitle: 'View our privacy policy'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.thumb_up,
              title: 'Rate us'.tr,
              subtitle: 'Leave a rating and review'.tr,
              ontaps: () {},
            ),
            SizedBox(
              height: 1.h,
            ),
            _buildSettingCard(
              icon: Icons.logout,
              title: 'Logout'.tr,
              subtitle: 'Sign out of your account'.tr,
              ontaps: () {
                Get.dialog(LogoutView());
              },
            ),

            // Add more notification cards here
            // Add more cards here
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback ontaps,
  }) {
    return Card(
      color: AppColors.whiteOff,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(title,
            style: AppTextStyles.bodyLargeBold.copyWith(
              fontWeight: FontWeight.w600,
            )),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: ontaps,
      ),
    );
  }
}
