import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/my_order/views/widget/doc_viewer.dart';
import 'package:ics/gen/assets.gen.dart';

class ItemDoc extends StatefulWidget {
  const ItemDoc({super.key, required this.title, required this.pdfPath});

  final String title;
  final String pdfPath;

  @override
  State<ItemDoc> createState() => _ItemFaqState();
}

class _ItemFaqState extends State<ItemDoc> {
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
          SvgPicture.asset(
            Assets.icons.paper,
            color: isExpanded ? AppColors.primary : AppColors.grayDefault,
            fit: BoxFit.contain,
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
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: AppColors.grayLight,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.mp_w_6,
                vertical: AppSizes.mp_w_1,
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.mp_v_1 * 0.7,
                ),
                itemBuilder: (context, index) {
                  return buildPDFViewer();
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
            ),
          )
        : const SizedBox();
  }

  buildPDFViewer() {
    return BuildDocViewer(
      pdfPath: widget.pdfPath,
    );
  }
}
