import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/gen/assets.gen.dart';

class DateTextPickerInput extends StatefulWidget {
  const DateTextPickerInput({
    Key? key,
    required this.controller,
    required this.dateValidator,
    required this.monthValidator,
    required this.yearValidator,
  }) : super(key: key);

  final NewPassportController controller;
  final String? Function(String?)? dateValidator;
  final String? Function(String?)? monthValidator;
  final String? Function(String?)? yearValidator;

  @override
  State<DateTextPickerInput> createState() => _DateTextPickerInputState();
}

class _DateTextPickerInputState extends State<DateTextPickerInput> {
  late FocusNode yearFocusNode;
  late FocusNode monthFocusNode;
  late FocusNode dayFocusNode;

  @override
  void initState() {
    super.initState();
    yearFocusNode = FocusNode();
    monthFocusNode = FocusNode();
    dayFocusNode = FocusNode();
  }

  @override
  void dispose() {
    yearFocusNode.dispose();
    monthFocusNode.dispose();
    dayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            validator: widget.dateValidator,
            textAlign: TextAlign.center,
            maxLength: 2,
            controller: widget.controller.dayController,
            keyboardType: TextInputType.number,
            focusNode: dayFocusNode,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(monthFocusNode);
              }
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "DD",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black,
                ),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
          child: SvgPicture.asset(
            Assets.icons.slashforward,
            color: AppColors.grayLight,
            height: AppSizes.icon_size_6,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: widget.monthValidator,
            controller: widget.controller.monthController,
            maxLength: 2,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            focusNode: monthFocusNode,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(yearFocusNode);
              }
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "MM",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black,
                ),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
          child: SvgPicture.asset(
            Assets.icons.slashforward,
            color: AppColors.grayLight,
            height: AppSizes.icon_size_6,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: widget.yearValidator,
            controller: widget.controller.yearController,
            maxLength: 4,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            focusNode: yearFocusNode,
            onChanged: (value) {
              if (value.length == 4) {}
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "YYYY",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayLight,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black,
                ),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
