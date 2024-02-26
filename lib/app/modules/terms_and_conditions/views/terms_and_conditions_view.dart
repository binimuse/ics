import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';

import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Terms And',
        title2: 'Conditions',
        showActions: false,
        showLeading: true,
      ),
      body: Center(
        child: Text(
          controller.baseSiteConfiguration.first.privacyPolicy!.en.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
