// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';
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
      appBar: CustomAppBar(
        title: 'Hello',
        title2: "welcome",
        showActions: true,
        actionIcon: SvgPicture.asset(
          color: AppColors.primary,
          Assets.icons.questionmark,
          height: 6.w,
          width: 9.w,
        ),
        routeName: Routes.HELP,
        showLeading: false,
      ),
      backgroundColor: AppColors.whiteOff.withOpacity(0.9),
      body: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          __buildBanner(),
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
                  text: 'E-Visa',
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
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildEVisa(context),
                        buildEVisaCard(),
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
                        buildRE(context),
                        buildRECard(),
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
                        buildSC(context),
                        buildbuildSCCard(),
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
              isOrgin: true,
              svgPath: controller.svgPathsOrgin[index],
              title: controller.Orgintitles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                  Get.toNamed(Routes.NEW_ORIGIN_ID);
                } else if (index == 1) {
                  Get.toNamed(Routes.RENEW_ORIGIN_ID);
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

  buildEVisa(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'E-Visa ',
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
              'Your E-Visa is an essential document in international travel and for identification purposes.',
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

  buildEVisaCard() {
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
        itemCount: 2, // Replace with the actual number of cards
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(
              isOrgin: true,
              svgPath: controller.evisa[index],
              title: controller.Evisatitles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                } else if (index == 1) {}
              });
        },
      ),
    );
  }

  buildRE(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Resident Permit ',
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
              'Your Resident Permit is an essential document in international travel and for identification purposes.',
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

  buildRECard() {
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
        itemCount: 2, // Replace with the actual number of cards
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(
              isOrgin: false,
              svgPath: controller.re[index],
              title: controller.REtitles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                } else if (index == 1) {}
              });
        },
      ),
    );
  }

  buildSC(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Service Complaint',
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
              'Your Service Complaint is an essential document in international travel and for identification purposes.',
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

  buildbuildSCCard() {
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
        itemCount: 2, // Replace with the actual number of cards
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(
              isOrgin: true,
              svgPath: controller.sc[index],
              title: controller.SCtitles[index],
              iconColor: controller.color[index],
              onPressed: () {
                if (index == 0) {
                } else if (index == 1) {}
              });
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final Color? iconColor;
  final Function? onPressed;
  final bool? isOrgin;
  final bool? isRe;

  CardWidget({
    required this.svgPath,
    required this.title,
    required this.iconColor,
    this.onPressed,
    this.isOrgin,
    this.isRe,
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
              top: isOrgin != true
                  ? -8
                  : 3, // Adjust the top position to move the image upwards
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
                SizedBox(height: 5.h),
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
