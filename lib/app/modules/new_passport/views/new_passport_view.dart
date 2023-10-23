import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';

import '../controllers/new_passport_controller.dart';

class NewPassportView extends GetView<NewPassportController> {
  const NewPassportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: SizedBox(),
    );
  }
}
