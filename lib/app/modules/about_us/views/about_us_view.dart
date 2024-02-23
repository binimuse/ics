import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:ics/app/common/customappbar.dart';


import '../controllers/about_us_controller.dart';


class AboutUsView extends GetView<AboutUsController> {

  const AboutUsView({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(

        title: 'About',

        title2: 'Us',

        showActions: false,

        showLeading: true,

      ),

      body: const Center(

        child: Text(

          'AboutUsView is working',

          style: TextStyle(fontSize: 20),

        ),

      ),

    );

  }

}

