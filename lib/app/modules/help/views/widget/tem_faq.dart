import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/gen/assets.gen.dart';

class ItemFaq extends StatefulWidget {
  const ItemFaq({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  State<ItemFaq> createState() => _ItemFaqState();
}

class _ItemFaqState extends State<ItemFaq> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///BUILD TOP VIEW
        buildTopView(),

        Divider(
          color: AppColors.grayLighter,
          thickness: 1.0,
          height: 1.0,
        ),

        ///BUILD EXPANDED VIEW
        buildExpandedView(),
      ],
    );
  }

  Padding buildTopView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.mp_w_6,
        vertical: AppSizes.mp_v_1,
      ),
      child: Row(
        children: [
          Text(
            "Q",
            style: isExpanded
                ? AppTextStyles.bodyLargeBold.copyWith(
                    color: AppColors.primary,
                  )
                : AppTextStyles.bodyLargeRegular.copyWith(
                    color: AppColors.primary,
                  ),
          ),
          SizedBox(
            width: AppSizes.mp_w_4,
          ),
          Expanded(
            child: Text(
              widget.title,
              style: isExpanded
                  ? AppTextStyles.bodyLargeBold.copyWith(
                      color: AppColors.blackLight,
                    )
                  : AppTextStyles.bodyLargeRegular.copyWith(
                      color: AppColors.blackLight,
                    ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: SvgPicture.asset(
              isExpanded ? Assets.icons.chevronDown : Assets.icons.chevronRight,
              width: AppSizes.icon_size_6,
              color: AppColors.grayDefault,
            ),
          ),
        ],
      ),
    );
  }

  buildExpandedView() {
    return isExpanded
        ? Container(
            color: AppColors.primaryLighter,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_6,
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_4 * 0.7,
              ),
              itemBuilder: (context, index) {
                return buildAnswer();
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: AppSizes.mp_v_4 * 0.8,
                );
              },
              itemCount: 1,
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: widget.description
            //       .map(
            //         (e) => Padding(
            //           padding: EdgeInsets.only(bottom: AppSizes.mp_v_2),
            //           child: Text(
            //             e,
            //             style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.primaryDark),
            //           ),
            //         ),
            //       )
            //       .toList(),
            // ),
          )
        : const SizedBox();
  }

  buildAnswer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.subtitle,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
