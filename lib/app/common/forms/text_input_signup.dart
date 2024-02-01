// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/signup/controllers/signup_controller.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class TextInputSignup extends StatefulWidget {
  const TextInputSignup({
    Key? key,
    required this.hint,
    this.maxLength,
    this.isPassword = false,
    required this.controller,
    this.signupController,
    this.validator,
    this.moreInstructions,
    required this.autofocus,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.onChanged, // Added onChanged callback
  }) : super(key: key);

  final String hint;
  final bool isPassword;
  final bool autofocus;
  final int? maxLength;
  final TextEditingController controller;
  final SignupController? signupController;
  final List<String>? moreInstructions;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onChanged; // Callback when the text changes

  @override
  State<TextInputSignup> createState() => _TextInputLoginState();
}

class _TextInputLoginState extends State<TextInputSignup> {
  bool _isFocused = false;
  bool isPasswordVisible = false; // Added property

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });

    if (widget.focusNode != null) {
      widget.focusNode!.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.focusNode!.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny spaces
          ],
          maxLength: widget.maxLength,
          cursorColor: AppColors.primary,
          controller: widget.controller,
          keyboardType: widget.keyboardType,

          autofocus: widget.autofocus,
          style: AppTextStyles.titleBold.copyWith(
            color: AppColors.blackLight,
            fontSize:
                checkIsPassword() ? AppSizes.font_14 * 0.9 : AppSizes.font_16,
          ),
          obscureText: checkIsPassword() ? !isPasswordVisible : false,
          obscuringCharacter: '⬤',
          //obscuringCharacter: '\u2022', // Customize the obscuring character
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: checkIsPassword()
                  ? AppSizes.mp_v_1 * 1.2
                  : AppSizes.mp_v_1 / 2,
              top: AppSizes.mp_v_1 / 2,
            ),
            labelText: _isFocused ? widget.hint : null,
            hintText: _isFocused ? null : widget.hint,
            hintStyle:
                AppTextStyles.titleBold.copyWith(color: AppColors.grayLighter),
            labelStyle:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayLight),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIconConstraints: BoxConstraints(
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
          onChanged: (value) {
            setState(() {
              _isFocused = value.isNotEmpty;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value); // Call the onChanged callback
            }
          },
          onTap: () {
            setState(() {
              _isFocused = true;
            });
            if (widget.focusNode != null) {
              // Request focus for the field
              FocusScope.of(context).requestFocus(widget.focusNode);
            }
            // Request focus for the password field when tapping
          },
          focusNode: widget.focusNode,
        ),
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
    if (widget.isPassword) {
      return true;
    }
    return false;
  }

  bool checkHasMoreInstructions() {
    if (widget.moreInstructions != null) {
      return true;
    }
    return false;
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

  buildHideUnhideButton() {
    return MaterialButton(
      padding: EdgeInsets.only(
        left: AppSizes.mp_w_2,
        right: AppSizes.mp_w_1 / 2,
      ),
      onPressed: () {
        setState(() {
          isPasswordVisible =
              !isPasswordVisible; // Toggle the visibility of the password
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SvgPicture.asset(
              isPasswordVisible
                  ? Assets.icons.eye
                  : Assets.icons
                      .eyeSlash, // Use different icons based on the password visibility
              color:
                  isPasswordVisible ? AppColors.primary : AppColors.grayLight,
              width: AppSizes.icon_size_6,
            ),
          ),
          SizedBox(
            width: AppSizes.mp_w_1,
          ),
          Flexible(
            child: Text(
              isPasswordVisible
                  ? "Show"
                  : "Hidden", // Change the text based on the password visibility
              style: AppTextStyles.captionBold.copyWith(
                color:
                    isPasswordVisible ? AppColors.primary : AppColors.grayLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
