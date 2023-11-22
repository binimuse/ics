import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class ReusableDropdown extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuItem<String>> items;

  final void Function(String?)? onChanged;
  final void Function(String?)? onsave;
  final String? Function(String?)? validator;
  ReusableDropdown({
    required this.labelText,
    required this.items,
    this.onChanged,
    this.onsave,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      validator: validator!,
      decoration: InputDecoration(
        labelText: labelText,
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grayLight,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
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
        labelStyle: AppTextStyles.captionBold
            .copyWith(color: AppColors.grayLight, fontSize: AppSizes.font_14),
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: Colors.transparent,
      ),
      items: items,
      onChanged: onChanged,
      onSaved: onsave,
      name: '',
    );
  }
}
