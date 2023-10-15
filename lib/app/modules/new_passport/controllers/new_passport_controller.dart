import 'package:get/get.dart';
import 'package:ics/gen/assets.gen.dart';

import '../model/confirmation_model.dart';

class NewPassportController extends GetxController {
  Future<List<ConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "Green Card",
        "image": Assets.icons.paper,
      },
      {
        "name": "Residence ID",
        "image": Assets.icons.origin,
      },
      {
        "name": "Birth certificate",
        "image": Assets.icons.paper,
      },
      {
        "name": "Parent passport",
        "image": Assets.icons.passport,
      },
    ];

    return data.map((item) => ConfirmationModel.fromJson(item)).toList();
  }

  final List<bool> termCheckedList = [false, false, false, false].obs;

  bool isTermChecked(int index) {
    return termCheckedList[index];
  }

  void toggleTerm(int index) {
    termCheckedList[index] = !termCheckedList[index];
    update();
  }

  bool areAllTermsSelected() {
    for (var isChecked in termCheckedList) {
      if (!isChecked) {
        return false;
      }
    }
    return true;
  }
}
