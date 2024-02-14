
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/app/modules/new_passport/data/model/confirmation_model.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/modules/new_passport/data/mutation/ics_citizens_mutuation.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_emabassies.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_url.dart';
import 'package:ics/app/modules/new_passport/data/quary/ics_citizens.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ics/services/graphql_conf.dart';

import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import '../data/quary/get_all.dart';


class NewPassportController extends GetxController {
  final TextEditingController AmfatherNameController = TextEditingController();
  final TextEditingController AmfirstNameController = TextEditingController();
  final TextEditingController AmgrandFatherNameController =
      TextEditingController();
  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;

  List<String> SkinColor = [
    'Black',
    'Brown',
    'Blue',
    'Other',
  ];

  final TextEditingController addressController = TextEditingController();
  final Rxn<Basemodel> baseData = Rxn<Basemodel>();
  final RxList<FamilyModel> familyModelvalue = RxList<FamilyModel>();

  List<AllowedContreyModel> allwoedCountries = [];
  List<CommonModel> base_document_types = [];
  List<PassportDocuments> documents = [];

  final Rxn<CommonModel> birthCountryvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> embassiesvalue = Rxn<CommonModel>();

  final TextEditingController countryController = TextEditingController();

  final Rxn<AllowedContreyModel> countryvalue = Rxn<AllowedContreyModel>();
  final Rxn<AllowedContreyModel> currentcountryvalue =
      Rxn<AllowedContreyModel>();

  int currentStep = 0;
  final TextEditingController dateofbirth = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();

  final TextEditingController fatherNameController = TextEditingController();
  //Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController birthplace = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();

  GetallQuery getGenderQuery = GetallQuery();
  GetUrlQuery geturlQuery = GetUrlQuery();
  Getaicscitizens getaicscitizens = Getaicscitizens();
  GetEmbassiesQuery getEmbassiesQuery = GetEmbassiesQuery();

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  final Rxn<CommonModel> haircolorvalue = Rxn<CommonModel>();

  //Step 2

  final TextEditingController height = TextEditingController();

  final TextEditingController familyfirstNameController =
      TextEditingController();
  final TextEditingController familyFatherNameController =
      TextEditingController();

  var isfeched = false.obs;
  var isAdoption = false.obs;
  var showAdoption = false.obs;

  final Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();

  List<CommonModel> martial = [];
  List<CommonModel> gender = [];
  List<CommonModel> occupations = [];
  List<CommonModel> familytype = [];
  List<CommonModel> bcountries = [];
  List<CommonModel> natinality = [];
  List<CommonModel> haircolor = [];
  List<CommonModel> eyecolor = [];
  final TextEditingController monthController = TextEditingController();
  final newPassportformKey = GlobalKey<FormBuilderState>();
  RxList<File> selectedImages = <File>[].obs;
  final phoneFocusNode = FocusNode();
  var isPhoneValid = false.obs;
  bool validatPhone() {
    final password = phonenumber.text;
    if (password.length >= 8) {
      isPhoneValid(true);
      return true;
    } else {
      isPhoneValid(false);
      return false;
    }
  }

  final Rxn<CommonModel> occupationvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> familytypevalue = Rxn<CommonModel>();
  //Step 3
  final TextEditingController phonenumber = TextEditingController();

  final reasonController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  final RxString skincolorvalue = ''.obs;
  final List<bool> termCheckedList = [
    false,
    false,
    false,
    false,
  ].obs;

  //for birthDate
  final TextEditingController yearController = TextEditingController();

  @override
  void onInit() {
    getAll();
    getCitizene();

    super.onInit();
  }

  List<DateTime> occupiedDates = [
    DateTime(2024, 2, 1),
    DateTime(2024, 2, 3),
    // Add more dates...
  ];

  Future<List<NewConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "New applicants",
        "description":
            "New applicants who are unable to attend on the appointment date will apply again.",
        "image": Assets.icons.camera,
      },
      {
        "name": "Amharic Keybord",
        "description":
            "make sure you have amahric keybord installed on your Phone.",
        "image": Assets.icons.batteryLow,
      },
      {
        "name": "Document in PDF Fromat",
        "description": "we only accept documents in PDF format. ",
        "image": Assets.icons.paper,
      },
      {
        "name": "Passport",
        "description": "To use more than one passport is strictly prohibited",
        "image": Assets.icons.origin,
      },
    ];

    return data.map((item) => NewConfirmationModel.fromJson(item)).toList();
  }

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

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

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

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  var setFetchedStatus = false.obs;

  Future<void> getAll() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getGenderQuery.fetchData(), {});
      baseData.value = Basemodel.fromJson(result);

      if (baseData.value == null) {
        throw Exception("Base data is null");
      }

      mapBaseDataToLists();
      setFetchedStatus(true);
      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print("Error occurred while fetching data: $e");
      setFetchedStatus(false);
    }
  }

  void mapBaseDataToLists() {
    gender = baseData.value!.base_genders;
    eyecolor = baseData.value!.base_eye_colors;
    haircolor = baseData.value!.base_hair_colors;
    martial = baseData.value!.base_marital_statuses;
    occupations = baseData.value!.base_occupations;
    familytype = baseData.value!.base_family_types;
    bcountries = baseData.value!.base_countries;
    natinality = baseData.value!.base_countries;
    allwoedCountries = baseData.value!.allowed_countries;

    print("nini${baseData.value!.base_document_types}");
    base_document_types = baseData.value!.base_document_types;

    for (var documentType in base_document_types) {
      documents
          .add(PassportDocuments(documentTypeId: documentType.id, files: []));
    }
  }

  void check() {
    final isValid = newPassportformKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      newPassportformKey.currentState!.save();
      send(); // Call report() when the form is valid
    }
  }

  final Rxn<GetUrlModel> getUrlModel = Rxn<GetUrlModel>();

  var isGetDocUrlStarted = false.obs;

  var isSend = false.obs;
  var isSendStared = false.obs;
  var newApplicationId;
  Future<void> send() async {
    try {
      isSendStared.value = true;
      DateTime dateOfBirth = DateTime(
        int.parse(yearController.text),
        int.parse(monthController.text),
        int.parse(dayController.text),
      );
      String formattedDateOfBirth =
          DateFormat('yyyy-MM-dd').format(dateOfBirth);
      GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(IcscitizensMutation.ics_citizens),
          variables: buildVariablesMap(formattedDateOfBirth),
        ),
      );

      handleMutationResult(result);
    } catch (e) {
      handleSendException(e);
    } finally {
      isSendStared.value = false;
    }
  }

  Map<String, dynamic> buildVariablesMap(String formattedDateOfBirth) {
    return {
      'objects': {
        'first_name': firstNameController.text,
        'father_name': fatherNameController.text,
        'grand_father_name': grandFatherNameController.text,
        'first_name_json': firstnameToJson(),
        'father_name_json': fathernameToJson(),
        'grand_father_name_json': gfathernameToJson(),
        'gender': gendervalue.value!.name,
        'birth_place': birthplace.text,
        'birth_country_id': birthCountryvalue.value!.id,
        'nationality_id': natinalityvalue.value!.id,
        'date_of_birth': formattedDateOfBirth,
        'occupation_id': occupationvalue.value!.id,
        'hair_colour': haircolorvalue.value!.name,
        'eye_colour': eyecolorvalue.value!.name,
        'marital_status': maritalstatusvalue.value!.name,
        'height': height.text,
        'is_adopted': isAdoption.value,
        'skin_colour': skincolorvalue.value,
        'abroad_country_id': countryvalue.value!.id,
        'abroad_address': addressController.text,
        'phone_number': phonenumber.text,
        'new_applications': {
          "data": {
            "delivery_date": null,
            'embassy_id': embassiesvalue.value!.id,
            'current_country_id': currentcountryvalue.value!.id,
          }
        },
        'citizen_families': {
          "data": familyModelvalue.map((element) => element.toJson()).toList()
        }
      }
    };
  }

  void handleMutationResult(QueryResult result) {
    if (result.hasException) {
      isSend.value = false;
      print("Error executing mutation: ${result.exception}");
    } else {
      isSend.value = true;
      newApplicationId = result.data!['insert_ics_citizens']['returning'][0]
              ['new_applications'][0]['id']
          .toString();
    }
  }

  void handleSendException(dynamic e) {
    isSend.value = false;
    print('Error sending data: $e');
    if (!e.toString().contains("Null")) {
      AppToasts.showError("An error occurred while sending data.");
    }
  }

  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    var documentTypeId,
    var path,
  ) async {
    try {
      isSendStared.value = true;
      // file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(NewDocApplications.newDoc),
          variables: <String, dynamic>{
            'objects': {
              'new_application_id': newApplicationId,
              'files': {
                'path': path,
              },
              'document_type_id': documentTypeId,
            }
          },
        ),
      );

      if (result.hasException) {
        isSendStared.value = false;

        print(result.exception.toString());
      } else {
        isSendDocSuccess(true);
        isSendStared.value = false;

        AppToasts.showSuccess("Document uploaded successfully");
      }
    } catch (e) {
      isSendStared.value = false;
      print('Error: $e');
    }
  }

  var isDeleteDocSuccess = false.obs;
  Future<void> deleteDoc(
    var documentTypeId,
  ) async {
    try {
      //file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(DeleteDocApplications.deleteDoc(documentTypeId)),
        ),
      );

      if (result.hasException) {
        isDeleteDocSuccess(false);
        print(result.exception.toString());
      } else {
        isDeleteDocSuccess(true);

        AppToasts.showSuccess("Documnet Deleted successfully");
      }
    } catch (e) {
      print(e.toString());
      isDeleteDocSuccess(false);
      print('Error: $e');
    }
  }

  Map<String, dynamic> firstnameToJson() {
    Map<String, dynamic> nameJson = {
      "en": "${firstNameController.text}",
      "am": "${AmfirstNameController.text}",
    };

    return nameJson;
  }

  Map<String, dynamic> fathernameToJson() {
    Map<String, dynamic> fanameJson = {
      "en": "${fatherNameController.text}",
      "am": "${AmfatherNameController.text}",
    };

    return fanameJson;
  }

  Map<String, dynamic> gfathernameToJson() {
    Map<String, dynamic> nameJson = {
      "en": "${grandFatherNameController.text}",
      "am": "${AmgrandFatherNameController.text}",
    };

    return nameJson;
  }

  RxList<IcsCitizenModel> icsCitizens = List<IcsCitizenModel>.of([]).obs;
  var isfechediCitizens = false.obs;
  void getCitizene() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      networkStatus.value = NetworkStatus.SUCCESS;
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_citizens'] as List)
            .map((e) => IcsCitizenModel.fromJson(e))
            .toList();

        // countLabours.value = getlabour.value.length;
      }

      isfechediCitizens(true);
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechediCitizens(false);
      print(">>>>>>>>>>>>>>>>>> getCitizene $e");
      print(">>>>>>>>>>>>>>>>>> getCitizene $s");
    }
  }

  var isfechedEmbassies = false.obs;

  List<CommonModel> base_embassies = [];
  void getEmbassies(String id) async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getEmbassiesQuery.fetchData(id), {});

      if (result != null) {
        base_embassies = (result['base_embassies'] as List)
            .map((e) => CommonModel.fromJson(e))
            .toList();

        if (base_embassies.isNotEmpty) {
          isfechedEmbassies.value = true;
        } else {
          isfechedEmbassies.value = false;
        }

        // countLabours.value = getlabour.value.length;
      }
    } catch (e) {
      isfechedEmbassies.value = false;
      print(">>>>>>>>>>>>>>>>>> getEmbassies $e");
    }
  }
}

class PassportDocuments {
  final documentTypeId;
  final List<PlatformFile> files;

  const PassportDocuments({
    required this.documentTypeId,
    required this.files,
  });
}

enum ExportResult {
  success,
  error,
}
