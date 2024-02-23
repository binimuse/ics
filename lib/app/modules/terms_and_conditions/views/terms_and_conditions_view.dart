import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TermsAndConditionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TermsAndConditionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
