// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class TextFormBuilder extends StatefulWidget {
  const TextFormBuilder({
    Key? key,
    required this.hint,
    this.labelText,
    this.isPassword,
    this.moreInstructions,
    required this.controller,
    this.autoFocus,
    required this.isMandatory,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.maxline,
    this.maxlength,
    this.inputFormatters,
    required this.showClearButton,
    this.onChanged, // Added onChanged callback
    this.onTap, // Added onChanged callback
  }) : super(key: key);

  final String hint;
  final String? labelText;
  final int? maxline;
  final int? maxlength;
  final bool? isPassword;
  final bool showClearButton;
  final List<String>? moreInstructions;
  final TextEditingController controller;
  final bool? autoFocus;
  final bool isMandatory;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged; // Callback when the text changes
  final String? Function(String?)? validator;
  final VoidCallback? onTap; // Callback when the text changes

  @override
  State<TextFormBuilder> createState() => _TextInputLoginState();
}

class _TextInputLoginState extends State<TextFormBuilder> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // widget.controller.addListener(() {
    //   setState(() {
    //     widget.showClearButton = widget.controller.text.isNotEmpty;
    //   });
    // });

    if (widget.focusNode != null) {
      widget.focusNode!.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderTextField(
          maxLines: widget.maxline,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxlength,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: TextInputAction.next,
          cursorColor: AppColors.primary,
          controller: widget.controller,
          autofocus: widget.autoFocus ?? false,
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize:
                checkIsPassword() ? AppSizes.font_14 * 0.9 : AppSizes.font_12,
          ),
          obscureText: checkIsPassword(),
          obscuringCharacter: '⬤',
          //obscuringCharacter: '\u2022', // Customize the obscuring character
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: checkIsPassword()
                  ? AppSizes.mp_v_1 * 1.2
                  : AppSizes.mp_v_1 / 2,
              top: AppSizes.mp_v_1 / 2,
            ),
            labelText: widget.labelText,
            hintText: _isFocused ? null : widget.hint,
            hintStyle: AppTextStyles.titleBold.copyWith(
                color: AppColors.grayDark, fontSize: AppSizes.font_12),
            labelStyle: AppTextStyles.captionBold.copyWith(
                color: AppColors.grayLight, fontSize: AppSizes.font_12),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIconConstraints: BoxConstraints(
              maxWidth: AppSizes.icon_size_10,
              maxHeight: AppSizes.icon_size_10,
            ),
            suffixIcon: widget.showClearButton || widget.isMandatory
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showClearButton)
                        Bounce(
                          onPressed: () {
                            setState(() {
                              widget.controller.clear();
                              _isFocused = false;
                            });
                          },
                          duration: const Duration(milliseconds: 120),
                          child: Padding(
                            padding: EdgeInsets.only(top: AppSizes.mp_v_1),
                            child: SvgPicture.asset(
                              Assets.icons.cancel,
                              color: AppColors.grayLight,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      if (widget.isMandatory)
                        Text(
                          "*",
                          style: TextStyle(
                              color: AppColors.danger,
                              fontSize: AppSizes.font_14),
                        ),
                    ],
                  )
                : null,
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
          onChanged: (value) {
            setState(() {
              _isFocused = value!.isNotEmpty;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!); // Call the onChanged callback
            }
          },
          onTap: widget.onTap,
          name: '',
        ),

        ///
        checkIsPassword()
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppSizes.mp_v_1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkHasMoreInstructions()
                          ? buildMoreInstructions()
                          : const SizedBox(),
                      buildHideUnhideButton()
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  bool checkIsPassword() {
    if (widget.isPassword != null) {
      if (widget.isPassword!) {
        return true;
      }
    }
    return false;
  }

  bool checkHasMoreInstructions() {
    if (widget.moreInstructions != null) {
      return true;
    }
    return false;
  }

  buildHideUnhideButton() {
    return MaterialButton(
      onPressed: () {},
      padding: EdgeInsets.only(
        left: AppSizes.mp_w_2,
        right: AppSizes.mp_w_1 / 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.icons.eyeSlash,
            color: AppColors.grayLighter,
            width: AppSizes.icon_size_6,
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
          Text(
            "Hidden",
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.grayLight,
            ),
          ),
        ],
      ),
    );
  }

  buildMoreInstructions() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: AppSizes.mp_w_4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.moreInstructions!.length,
            (index) => Text(
              widget.moreInstructions!.elementAt(index),
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.grayDefault,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
