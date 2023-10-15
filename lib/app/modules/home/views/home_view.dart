import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

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
            children: [
              SizedBox(
                height: 3.h,
              ),
              buildName(context),

              __buildBanner(),
              //passport
              buildPassport(context),

              buildcards(),
              SizedBox(
                height: 2.h,
              ),
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

  buildcards() {
    return Container(
      height: 80.h,
      child: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 6, // Replace with the actual number of cards
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

  buildPassport(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            'Services',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
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
