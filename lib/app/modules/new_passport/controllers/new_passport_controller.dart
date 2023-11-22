import 'package:get/get.dart';
import 'package:ics/app/modules/new_passport/model/confirmation_model.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';

class NewPassportController extends GetxController {
  Future<List<NewConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": " Ethiopian National",
        "description":
            "This Passport application form is applied only by Ethiopian National",
        "image": Assets.icons.paper,
      },
      {
        "name": "Passport",
        "description": "To use more than one passport is strictly prohibited",
        "image": Assets.icons.origin,
      },
      {
        "name": "Already have Passport",
        "description":
            "Ordinary passport Applicant who have already passport should not be apply for new passport",
        "image": Assets.icons.paper,
      },
      {
        "name": "Documents",
        "description":
            "Bring your original documents including your passport during collection.",
        "image": Assets.icons.passport,
      },
      {
        "name": "New applicants",
        "description":
            "New applicants who are unable to attend on the appointment date will apply again.",
        "image": Assets.icons.camera,
      },
    ];

    return data.map((item) => NewConfirmationModel.fromJson(item)).toList();
  }

  final List<bool> termCheckedList = [false, false, false, false, false].obs;

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

  //Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();

  final TextEditingController dateofbirth = TextEditingController();

  var selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  //Step 1

  final TextEditingController height = TextEditingController();
  //address
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  //contact detail
  final TextEditingController mobilePhoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
//Passport detail
  final TextEditingController passportnumberController =
      TextEditingController();
  final TextEditingController placeOfIssueController = TextEditingController();
  final TextEditingController validtyPerdiodController =
      TextEditingController();

  final reasonController = TextEditingController();

  //signature
  Future<VideoTypenew> getVideoType(File file) async {
    final String? mimeType = lookupMimeType(file.path);

    if (mimeType != null && mimeType.startsWith('video/')) {
      return VideoTypenew.video;
    }

    if (mimeType != null && mimeType.startsWith('audio/')) {
      return VideoTypenew.audio;
    }

    return VideoTypenew.unknown;
  }

  RxList<File> selectedVideos = <File>[].obs;
  VideoPlayerController? videoController;

  int currentStep = 0;

  List<String> gender = ['Male', 'Female'];
  List<String> occupation = [
    'Waiter',
    'Dentist',
    'Nurse',
    'Nurse',
    'Doctor',
    'Surgeon',
    'Postman',
  ];

  List<String> haircolor = [
    'Black',
    'Brown',
    'Blonde',
    'Red',
    'Gray and White Hair',
  ];

  List<String> eyecolor = [
    'Black',
    'Brown',
    'Blue',
    'Other',
  ];

  List<String> martial = [
    'Married',
    'Widowed',
    'Separated',
    'Divorced',
    'Single',
  ];
}

enum VideoTypenew { video, image, audio, unknown }
