import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/common/model/dropdown_common_model.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/confirmation_model.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';

import '../data/quary/get_all.dart';

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

  final newPassportformKey = GlobalKey<FormBuilderState>();

  //Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();

  final TextEditingController dateofbirth = TextEditingController();

  final RxString birthCountryvalue = ''.obs;
  final RxString gendervalue = ''.obs;

  var selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  //Step 2

  final TextEditingController height = TextEditingController();
  final RxString occupationvalue = ''.obs;
  final RxString haircolorvalue = ''.obs;
  final RxString eyecolorvalue = ''.obs;
  final RxString maritalstatusvalue = ''.obs;
  //Step 3
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final RxString countryvalue = ''.obs;

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

  @override
  void onInit() {
    getGender();
    super.onInit();
  }

  int currentStep = 0;

  final Rxn<Basemodel> baseData = Rxn<Basemodel>();
  GetallQuery getGenderQuery = GetallQuery();
  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  List<String> martial = [];

  List<String> bcountries = [];
  List<String> gender = [];

  Future<void> getGender() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getGenderQuery.fetchData(), {});

          

      baseData.value = Basemodel.fromJson(result);
      gender = baseData.value!.base_genders.map((e) => e.name).toList();
      martial =
          baseData.value!.base_marital_statuses.map((e) => e.name).toList();

      bcountries =
          baseData.value!.base_countries.map((e) => e.name_json).toList();
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>> $e");
    }
  }

  List<String> occupations = [
    'Waiter',
    'Dentist',
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

  List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Argentina',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
  ];
}

enum VideoTypenew { video, image, audio, unknown }
