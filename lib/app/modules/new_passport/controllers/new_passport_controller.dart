import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
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

  //form
  final TextEditingController addressController = TextEditingController();
  int currentStep = 0;

  List<List<FormBuilderFieldOption>> stepOptions = [
    [
      FormBuilderFieldOption(value: 'Option 1'),
      FormBuilderFieldOption(value: 'Option 2'),
      FormBuilderFieldOption(value: 'Option 3'),
    ],
    [
      FormBuilderFieldOption(value: 'Option A'),
      FormBuilderFieldOption(value: 'Option B'),
      FormBuilderFieldOption(value: 'Option C'),
    ],
    [
      FormBuilderFieldOption(value: 'Option X'),
      FormBuilderFieldOption(value: 'Option Y'),
      FormBuilderFieldOption(value: 'Option Z'),
    ],
  ];

  List<String> stepFields = [
    'field1',
    'field2',
    'field3',
  ];
}
