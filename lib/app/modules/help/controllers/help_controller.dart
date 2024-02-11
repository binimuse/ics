import 'package:get/get.dart';



class HelpController extends GetxController {

  final count = 0.obs;

  @override

  void onInit() {

    super.onInit();

  }


  @override

  void onReady() {

    super.onReady();

  }


  @override

  void onClose() {

    super.onClose();

  }


  List<Map<String, dynamic>> data = [

    {

      "question": "Renew origin application",

      "answer":

          "Is applied only by former Ethiopian citizen, and foreign citizen with Ethiopian parents and individual married to person with Origin ID.",

    },

    {

      "question": "Renew Origin ID Applicant",

      "answer":

          "Who has a previous yellow card should apply for a new Origin ID.",

    },

  ];

  void increment() => count.value++;

}

