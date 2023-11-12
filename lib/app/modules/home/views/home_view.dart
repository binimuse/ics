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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              buildName(context),

              __buildBanner(),
              //passport
              buildPassport(context),

              buildcardsPassport(),

              buildOrgin(context),

              buildOriginId(),
              //ID
              // buildOriginId(context),
              // buildcardsOrigin(),
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
              Text(
                'Biniyam musema',
                style: AppTextStyles.bodyLargeBold.copyWith(
                    fontSize: AppSizes.font_16, color: AppColors.grayDark),
              ),
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
      height: 30.h,
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
              title: controller.titles[index],
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
              svgPath: controller.svgPathsOrgin[index],
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
                  fontSize: AppSizes.font_14, color: AppColors.grayDark),
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
                  fontSize: AppSizes.font_14, color: AppColors.grayDark),
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              color: iconColor,
              svgPath,
              height: 8.w,
              width: 8.w,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              title,
              style: AppTextStyles.menuBold.copyWith(
                fontSize: AppSizes.font_12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
