import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';
import 'widget/featured_news_item.dart';
import 'widget/news_carousel_slider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff.withOpacity(0.9),
      extendBody: true,
      bottomNavigationBar: Obx(() => FloatingNavbar(
            backgroundColor: AppColors.whiteOff.withOpacity(0.7),
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grayLight,
            selectedBackgroundColor: Colors.transparent,
            onTap: (int val) {
              controller.index.value = val;
              if (val == 0) {
                Get.toNamed('/home');
              } else if (val == 1) {
                if (val == 0) {
                  Get.toNamed('/home');
                } else if (val == 1) {
                  Get.toNamed('/explore');
                } else if (val == 2) {
                  Get.toNamed('/chat');
                } else if (val == 3) {
                  Get.toNamed('/settings');
                }
              }
            },
            currentIndex: controller.index.value,
            items: [
              FloatingNavbarItem(
                icon: Icons.home,
              ),
              FloatingNavbarItem(
                icon: Icons.explore,
              ),
              FloatingNavbarItem(icon: Icons.chat_bubble_outline),
              FloatingNavbarItem(
                icon: Icons.settings,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              buildName(context),
              //  buildcard(context),
              __buildBanner(),

              //buildcardwithNoEarnins(),
            ],
          ),
        ),
      ),
    );
  }

  __buildBanner() {
    controller.featuredNews = controller.images
        .map(
          (e) => FeaturedNewsItem(
            imageUrl: e,
            newsDescription:
                'It was pointed out that foreign employment is developing a system',
            date: 'NOV 19',
            locationCity: 'Addis Ababa',
          ),
        )
        .toList();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: AppSizes.mp_v_2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BannerCarouselSlider(
            items: controller.featuredNews,
            showIndicator: true,
          ),
        ],
      ),
    );
  }

  buildcard(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey, width: 1.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'August 2023',
                    style: AppTextStyles.bodyLargeBold.copyWith(
                        fontSize: AppSizes.font_16, color: AppColors.grayDark),
                  ),
                  SizedBox(width: 1.w),
                  IconButton(
                    icon: SvgPicture.asset(Assets.icons.chevronDown),
                    onPressed: () {
                      //  showModal(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 75.w,
              child: Divider(
                color: AppColors.grayLighter,
                thickness: 1,
                height: 1,
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Earnings',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmallBold.copyWith(
                    fontSize: AppSizes.font_14, color: AppColors.grayDark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$150.00',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayThreeBold.copyWith(
                    fontSize: AppSizes.font_32, color: AppColors.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 4.h,
                width: 75.w,
                decoration: BoxDecoration(
                  color: AppColors.grayLight.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Payout scheduled : 19 January 2023',
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: AppColors.grayDark,
                        fontSize: AppSizes.font_10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            'Hello,',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            'Biniyam musema',
            style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16, color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }
}
