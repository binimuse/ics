import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spalsh_controller.dart';

class SpalshView extends GetView<SpalshController> {
  const SpalshView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpalshView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpalshView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
