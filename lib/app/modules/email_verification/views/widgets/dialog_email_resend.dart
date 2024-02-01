import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/button/button_primary_fill.dart';
import 'package:ics/app/common/dialogs/dialog_center_common_widget.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/utils/keyboard.dart';

class DialogEmailResend extends StatelessWidget {
  const DialogEmailResend({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogCenterCommonWidget(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: AppSizes.mp_v_4,
            ),
            Text(
              'E-mail Resend done',
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineBold,
            ),
            SizedBox(
              height: AppSizes.mp_v_2,
            ),
            Text(
              "If you don't get an e-mail,Please check whether the reception is blocked or not and the spam box.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmallRegular
                  .copyWith(color: AppColors.grayDefault),
            ),
            SizedBox(
              height: AppSizes.mp_v_4,
            ),
            ButtonPrimaryFill(
              isterms: false,
              buttonSizeType: ButtonSizeType.LARGE,
              isDisabled: false,
              text: "Confirm",
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                Get.back();
              },
            ),
            SizedBox(
              height: AppSizes.mp_v_2 * 1.4,
            ),
          ],
        ),
      ),
    );
  }
}
