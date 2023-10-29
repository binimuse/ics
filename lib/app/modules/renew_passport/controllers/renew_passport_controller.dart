import 'package:get/get.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:io';
import '../data/model/confirmation_model.dart';

import 'package:mime/mime.dart';

class RenewPassportController extends GetxController {
  Future<List<ConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "Green Card",
        "description":
            "Green Card Description larem ipsum larem ipsum larem ipsum larem ipsum",
        "image": Assets.icons.paper,
      },
      {
        "name": "Residence ID",
        "description":
            "Residence ID Description larem ipsum larem ipsum larem ipsum larem ipsum",
        "image": Assets.icons.origin,
      },
      {
        "name": "Birth certificate",
        "description":
            "Birth certificate Description larem ipsum larem ipsum larem ipsum larem ipsum",
        "image": Assets.icons.paper,
      },
      {
        "name": "Passport",
        "description":
            "Passport Description larem ipsum larem ipsum larem ipsum larem ipsum",
        "image": Assets.icons.passport,
      },
      {
        "name": "Phone camera",
        "description":
            "Phone camera Description larem ipsum larem ipsum larem ipsum larem ipsum",
        "image": Assets.icons.camera,
      },
    ];

    return data.map((item) => ConfirmationModel.fromJson(item)).toList();
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

  //form
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();

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
  Future<VideoType> getVideoType(File file) async {
    final String? mimeType = lookupMimeType(file.path);

    if (mimeType != null && mimeType.startsWith('video/')) {
      return VideoType.video;
    }

    if (mimeType != null && mimeType.startsWith('audio/')) {
      return VideoType.audio;
    }

    return VideoType.unknown;
  }

  RxList<File> selectedVideos = <File>[].obs;
  VideoPlayerController? videoController;

  int currentStep = 0;

  // List<List<FormBuilderFieldOption>> stepOptions = [
  //   [
  //     FormBuilderFieldOption(value: 'Option 1'),
  //     FormBuilderFieldOption(value: 'Option 2'),
  //     FormBuilderFieldOption(value: 'Option 3'),
  //   ],
  //   [
  //     FormBuilderFieldOption(value: 'Option A'),
  //     FormBuilderFieldOption(value: 'Option B'),
  //     FormBuilderFieldOption(value: 'Option C'),
  //   ],
  //   [
  //     FormBuilderFieldOption(value: 'Option X'),
  //     FormBuilderFieldOption(value: 'Option Y'),
  //     FormBuilderFieldOption(value: 'Option Z'),
  //   ],
  // ];

  List<String> stepFields = [
    'field1',
    'field2',
    'field3',
  ];
}

enum VideoType { video, image, audio, unknown }
