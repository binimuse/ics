import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About',
        title2: 'Us',
        showActions: false,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          controller.baseSiteConfiguration.first.siteAbout!.en.toString(),
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
