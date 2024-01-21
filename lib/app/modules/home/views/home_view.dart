// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/assets.gen.dart';
import '../controllers/home_controller.dart';
import 'widget/featured_news_item.dart';
import 'widget/news_carousel_slider.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff.withOpacity(0.9),
      body: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          buildName(context),
          SizedBox(
            height: 1.h,
          ),
          __buildBanner(),
          TabBar(
            controller: controller.tabController,
            labelStyle: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_12, color: AppColors.primary),
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
                    Assets.icons.origin,
                    color: AppColors.primary,
                    fit: BoxFit.contain,
                  )),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPassport(context),
                        buildcardsPassport(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildOrgin(context),
                        buildOriginId(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BannerCarouselSlider(
          items: controller.featuredNews,
          showIndicator: true,
        ),
      ],
    );
  }

  buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.primary),
              ),
              SizedBox(
                width: 1.w,
              ),
              Obx(() => controller.hasGetUser.value
                  ? Text(
                      controller.usersModel.name.toString(),
                      style: AppTextStyles.bodyLargeBold.copyWith(
                          fontSize: AppSizes.font_16,
                          color: AppColors.grayDark),
                    )
                  : SizedBox()),
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
                color: AppColors.primary),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    color: AppColors.whiteOff,
                    Assets.icons.questionmark,
                    height: 6.w,
                    width: 6.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildcardsPassport() {
    return Container(
      height: 50.h,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 2,
        ),
        itemCount: 4, // Replace with the actual number of cards
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(
              svgPath: controller.svgPaths[index],
              title: controller.titles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                  Get.toNamed(Routes.NEW_PASSPORT);
                } else if (index == 1) {
                  Get.toNamed(Routes.RENEW_PASSPORT);
                } else if (index == 2) {
                } else if (index == 3) {
                } else if (index == 4) {
                } else if (index == 5) {}
              });
        },
      ),
    );
  }

  buildOriginId() {
    return Container(
      height: 40.h,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 4, // Replace with the actual number of cards
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(
              svgPath: controller.svgPaths[index],
              title: controller.Orgintitles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                } else if (index == 1) {
                  Get.toNamed(Routes.RENEW_PASSPORT);
                } else if (index == 2) {
                } else if (index == 3) {
                } else if (index == 4) {
                } else if (index == 5) {}
              });
        },
      ),
    );
  }

  buildPassport(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Passport ',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.primary),
              ),
              Text(
                'Services',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.grayDark),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your passport is an essential document in international travel and for identification purposes.',
              style: AppTextStyles.captionRegular.copyWith(
                  fontSize: AppSizes.font_12, color: AppColors.grayDark),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  buildOrgin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Origin Id ',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.primary),
              ),
              Text(
                'Services',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.grayDark),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your origin ID is an essential document while living in Ethiopia for identification purposes.',
              style: AppTextStyles.captionRegular.copyWith(
                  fontSize: AppSizes.font_12, color: AppColors.grayDark),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final Color? iconColor;
  final Function? onPressed;

  CardWidget({
    required this.svgPath,
    required this.title,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Card(
        margin: EdgeInsets.all(8),
        color: AppColors.whiteOff,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -8, // Adjust the top position to move the image upwards
              child: SvgPicture.asset(
                svgPath,
                color: iconColor,
                height: 12.w,
                width: 10.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: AppTextStyles.menuBold.copyWith(
                    fontSize: AppSizes.font_10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
