import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/customappbar.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy',
        title2: 'Policy',
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
