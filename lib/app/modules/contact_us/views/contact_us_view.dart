import 'package:flutter/material.dart';


import 'package:get/get.dart';

import 'package:ics/app/common/customappbar.dart';


import '../controllers/contact_us_controller.dart';


class ContactUsView extends GetView<ContactUsController> {

  const ContactUsView({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(

        title: 'Contact',

        title2: 'Us',

        showActions: false,

        showLeading: true,

      ),

      body: const Center(

        child: Text(

          'ContactUsView is working',

          style: TextStyle(fontSize: 20),

        ),

      ),

    );

  }

}

