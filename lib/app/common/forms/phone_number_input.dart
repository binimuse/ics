// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import '../../../../gen/assets.gen.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({
    Key? key,
    required this.hint,
    required this.labelText,
    required this.controller,
    required this.onChanged,
    this.validator,
    required this.focusNode,
    required this.isMandatory,
    this.autofocus = false,
  }) : super(key: key);

  final String hint;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final bool autofocus;
  final bool isMandatory;

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  bool _showClearButton = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.isNotEmpty;
      });
    });

    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          cursorColor: AppColors.primary,
          autofocus: widget.autofocus,
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            PhoneNumberInputFormatter(
                maxLength: 10), // Set maximum length to 10 characters
          ],
          style: AppTextStyles.titleBold.copyWith(
              color: AppColors.blackLight, fontSize: AppSizes.font_12),
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: _isFocused ? null : widget.hint,
            hintStyle: AppTextStyles.captionBold.copyWith(
                color: AppColors.grayLighter, fontSize: AppSizes.font_12),
            labelStyle: AppTextStyles.captionBold.copyWith(
                color: AppColors.grayLight, fontSize: AppSizes.font_12),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIconConstraints: BoxConstraints(
              maxWidth: AppSizes.icon_size_10,
              maxHeight: AppSizes.icon_size_10,
            ),
            suffixIcon: _showClearButton || widget.isMandatory
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
              _isFocused = value.isNotEmpty;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onTap: () {
            setState(() {
              _isFocused = true;
            });

            // Request focus for the field
            FocusScope.of(context).requestFocus(widget.focusNode);
          },
          focusNode: widget.focusNode,
        ),
      ],
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  final int maxLength;

  PhoneNumberInputFormatter({required this.maxLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters from the input
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply maximum length restriction
    final limitedDigits = digitsOnly.length > maxLength
        ? digitsOnly.substring(0, maxLength)
        : digitsOnly;

    // Set the new value with the limited digits
    return TextEditingValue(
      text: limitedDigits,
      selection: TextSelection.collapsed(offset: limitedDigits.length),
    );
  }
}
