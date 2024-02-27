import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';

import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/modules/logout/views/logout_view.dart';

import 'package:ics/app/routes/app_pages.dart';

import 'package:sizer/sizer.dart';

import '../controllers/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<SettingView> {
  late SettingController controller;

  @override
  void initState() {
    controller = Get.put(SettingController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
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
              ontaps: () {
                Get.toNamed(
                  Routes.ACCOUNT,
                );
              },
            ),

            _buildSettingCard(
              icon: Icons.language,
              title: 'Language'.tr,
              subtitle: 'Select your preferred language'.tr,
              ontaps: () {
                Get.toNamed(
                  Routes.LANGUAGE,
                );
              },
            ),

            SizedBox(
              height: 1.h,
            ),

            _buildSettingCard(
              icon: Icons.info,
              title: 'About us'.tr,
              subtitle: 'Learn more about us'.tr,
              ontaps: () {
                Get.toNamed(Routes.ABOUT_US, arguments: {
                  "ConfigModel": controller.configurationClassModel
                });
              },
            ),

            SizedBox(
              height: 1.h,
            ),

            _buildSettingCard(
              icon: Icons.message,
              title: 'Contact us'.tr,
              subtitle: 'Get in touch with us'.tr,
              ontaps: () {
                Get.toNamed(Routes.CONTACT_US);
              },
            ),

            SizedBox(
              height: 1.h,
            ),

            _buildSettingCard(
              icon: Icons.document_scanner_sharp,
              title: 'Terms and Conditions'.tr,
              subtitle: 'Read the terms and conditions'.tr,
              ontaps: () {
                Get.toNamed(Routes.TERMS_AND_CONDITIONS, arguments: {
                  "ConfigModel": controller.configurationClassModel
                });
              },
            ),

            SizedBox(
              height: 1.h,
            ),

            _buildSettingCard(
              icon: Icons.shield,
              title: 'Privacy Policy'.tr,
              subtitle: 'View our privacy policy'.tr,
              ontaps: () {
                Get.toNamed(Routes.PRIVACY_POLICY, arguments: {
                  "ConfigModel": controller.configurationClassModel
                });
              },
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

      elevation: 0,

      // shape: RoundedRectangleBorder(

      //   borderRadius: BorderRadius.circular(10),

      // ),

      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(title,
            style: AppTextStyles.bodyLargeRegular.copyWith(
              fontWeight: FontWeight.w400,
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
