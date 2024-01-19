import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class FeaturedNewsItem extends StatelessWidget {
  const FeaturedNewsItem({
    super.key,
    required this.imageUrl,
    required this.newsDescription,
    required this.date,
    required this.locationCity,
  });

  final String imageUrl;
  final String newsDescription;
  final String date;
  final String locationCity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  Get.toNamed(Routes.NEWS_DETAILS);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_1),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: 28.h,
                width: double.infinity,
                placeholder: (context, str) => Container(
                  color: AppColors.whiteOff,
                  height: 28.h,
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.whiteOff,
                  height: 28.h,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_2 * 0.8,
                  horizontal: AppSizes.mp_w_4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      newsDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmallBold.copyWith(
                          fontSize: AppSizes.font_10,
                          color: AppColors.whiteOff),
                    )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            color: AppColors.whiteOff,
                            fontWeight: FontWeight.w600,
                            fontSize: AppSizes.font_12,
                          ),
                        ),
                        SizedBox(height: AppSizes.mp_v_1 * 0.8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.mp_v_1 * 0.4,
                            horizontal: AppSizes.mp_w_2,
                          ),
                          child: Center(
                            child: Text(
                              locationCity,
                              style: TextStyle(
                                color: AppColors.whiteOff,
                                fontWeight: FontWeight.w600,
                                fontSize: AppSizes.font_10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
