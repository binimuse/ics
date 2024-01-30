import 'package:dio/dio.dart' as Mydio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/base_model_orgin.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';
import 'package:ics/app/modules/new_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/model/fileurl_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/mutation/ics_citizens_mutuation_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_emabassies_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_url_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/ics_citizens_orginid.dart';

import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ics/services/graphql_conf.dart';

import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import '../data/quary/get_all_orginid.dart';

import 'package:http_parser/http_parser.dart';

class NewOriginIdController extends GetxController {
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
  final Rxn<BasemodelOrginId> baseData = Rxn<BasemodelOrginId>();
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

  int currentStep = 0;
  final TextEditingController dateofbirth = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();

  final TextEditingController fatherNameController = TextEditingController();
  //Step 1
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();

  GetallQueryOrginId getGenderQuery = GetallQueryOrginId();
  GetUrlQueryOrginId geturlQuery = GetUrlQueryOrginId();
  GetaicscitizensOrginId getaicscitizens = GetaicscitizensOrginId();
  GetEmbassiesQueryOrginId getEmbassiesQuery = GetEmbassiesQueryOrginId();

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
    false,
  ].obs;

  final List<bool> orginIDType = [
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

  Future<List<NewOrginIdConfirmationModel>> fetchorginId() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "Orgin Id For Adults",
        "description":
            "Foreign nationals of Ethiopian origin, former Ethiopian citizens with Ethiopian passport or adults with Ethiopian parents.",
        "image": Assets.icons.paper,
      },
      {
        "name": "Orgin Id For Children",
        "description":
            "Foreign nationals of Ethiopian origin under 18 years old, former Ethiopian citizens with Ethiopian passport or children with Ethiopian parents.",
        "image": Assets.icons.batteryLow,
      },
      {
        "name": "Orgin Id For spouse",
        "description":
            "Foreign national who are married to person with Ethiopian origin ID or Ethiopian Yellow Card.",
        "image": Assets.icons.paper,
      },
    ];

    return data
        .map((item) => NewOrginIdConfirmationModel.fromJson(item))
        .toList();
  }

  Future<List<NewOrginIdConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "This origin application form",
        "description":
            "is applied only by former Ethiopian citizen, and foreign citizen with Ethiopian parents and individual married to person with Origin ID.",
        "image": Assets.icons.paper,
      },
      {
        "name": "Origin ID Applicant",
        "description":
            "who has a previous yellow card should apply for new Origin ID.",
        "image": Assets.icons.batteryLow,
      },
      {
        "name": "Origin ID ",
        "description":
            "Applicant who have already Origin ID should not be apply for new Origin ID.",
        "image": Assets.icons.paper,
      },
      {
        "name": "Documents",
        "description":
            "Bring your original documents including your passport during collection.",
        "image": Assets.icons.origin,
      },
      {
        "name": "Amharic Keybord",
        "description":
            "make sure you have amahric keybord installed on your Phone.",
        "image": Assets.icons.batteryLow,
      },
    ];

    return data
        .map((item) => NewOrginIdConfirmationModel.fromJson(item))
        .toList();
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

  Future<void> getAll() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getGenderQuery.fetchData(), {});

      baseData.value = BasemodelOrginId.fromJson(result);
      gender = baseData.value!.base_genders.map((e) => e).toList();

      eyecolor = baseData.value!.base_eye_colors.map((e) => e).toList();
      haircolor = baseData.value!.base_hair_colors.map((e) => e).toList();
      martial = baseData.value!.base_marital_statuses.map((e) => e).toList();
      occupations = baseData.value!.base_occupations.map((e) => e).toList();
      familytype = baseData.value!.base_family_types.map((e) => e).toList();
      bcountries = baseData.value!.base_countries.map((e) => e).toList();
      natinality = baseData.value!.base_countries.map((e) => e).toList();
      allwoedCountries =
          baseData.value!.allowed_countries.map((e) => e).toList();
      base_document_types =
          baseData.value!.base_document_types.map((e) => e).toList();

      for (var documentType in base_document_types) {
        documents
            .add(PassportDocuments(documentTypeId: documentType.id, files: []));
      }
      isfeched(true);
    } catch (e) {
      isfeched(false);
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

  void checkdoc() async {
    if (documents.isEmpty) {
      AppToasts.showError("Document are empty");
      return;
    } else if (documents.any((element) => element.files.isEmpty)) {
      isSendStared.value = false;
      AppToasts.showError("Document must not be empty");
      return;
    } else {
      isSendStared.value = true;
      await Future.delayed(const Duration(seconds: 1));
      isSendStared.value = false;
      AppToasts.showSuccess("New Passport Sent successfully");
      final MyOrderController controller = Get.put(MyOrderController());
      controller.GetNewPassport();
      Get.offAllNamed(Routes.MAIN_PAGE);
    }
  }

  final Rxn<GetUrlModelOrginid> getUrlModel = Rxn<GetUrlModelOrginid>();
  Future<void> geturl(
    documentTypeId,
    PlatformFile files,
  ) async {
    try {
      isSendStared.value = true;
      dynamic result = await graphQLCommonApi.query(
        geturlQuery.fetchData("pdf", ""),
        {},
      );

      getUrlModel.value =
          GetUrlModelOrginid.fromJson(result!['getSignedUploadUrl']);
      isSendStared.value = true;
      sendUrl(documentTypeId, getUrlModel.value!.url, getUrlModel.value!.path,
          files);
      isfeched(true);
    } catch (e) {
      isSendStared.value = false;
      isfeched(false);
      print("Error occurred while getting URL: $e");
    }
  }

  var isGetDocUrlStarted = false.obs;
  void sendUrl(
    String? documentTypeId,
    String? url,
    String? path,
    PlatformFile files,
  ) async {
    try {
      isSendStared.value = true;
      print(Uri.parse(url!).toString());
      var dio = Mydio.Dio();

      Mydio.FormData formData = Mydio.FormData.fromMap({
        'file': await Mydio.MultipartFile.fromFile(
          files.path!,
          contentType: MediaType('application', 'octet-stream'),
        ),
      });

      isGetDocUrlStarted(true);
      var response = await dio.put(url, data: formData);
      if (response.statusCode == 200) {
        isSendStared.value = false;
        print('File uploaded successfully');
        sendDoc(
          newApplicationId,
          documentTypeId,
          url,
          path,
        );

        print(response);
      } else {
        isSendStared.value = false;
        isGetDocUrlStarted(false);
        print('Failed to upload file. Error: ${response.statusCode}');
      }
    } catch (e) {
      isSendStared.value = false;
      isGetDocUrlStarted(false);
      print('Error uploading file: $e');
    }
  }

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
      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(IcscitizensMutationOrginId.ics_citizens),
          variables: <String, dynamic>{
            'objects': {
              'first_name': firstNameController.text,
              'father_name': fatherNameController.text,
              'grand_father_name': grandFatherNameController.text,
              'first_name_json': firstnameToJson(),
              'father_name_json': fathernameToJson(),
              'grand_father_name_json': gfathernameToJson(),
              'gender': gendervalue.value!.name,
              'birth_place': birthCountryvalue.value!.name,
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
              'abroad_phone_number': phonenumber.text,
              'new_applications': {
                "data": {
                  "delivery_date": null,
                  'embassy_id': embassiesvalue.value!.id,
                }
              },
              'citizen_families': {
                "data":
                    familyModelvalue.map((element) => element.toJson()).toList()
              }
            }
          },
        ),
      );

      if (result.hasException) {
        print("""objects""");
        isSend.value = false;
        print(result.exception.toString());
        isSendStared.value = false;
      } else {
        print(result.data);

        isSend.value = true;
        isSendStared.value = false;

        newApplicationId = result.data!['insert_ics_citizens']['returning'][0]
                ['new_applications'][0]['id']
            .toString();
      }
    } catch (e) {
      isSendStared.value = false;
      isSend.value = false;
      print('Errors: $e');
      if (e.toString().contains("Null ")) {
        AppToasts.showError("please provide Emabases");
      } else {
        AppToasts.showError("Something went wrong");
      }
    }
  }

  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    dynamic newApplicationId,
    var documentTypeId,
    var url,
    var path,
  ) async {
    try {
      isSendStared.value = true;
      // file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(NewDocApplicationsOrginId.newDoc),
          variables: <String, dynamic>{
            'objects': {
              'new_application_id': newApplicationId,
              'files': path,
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
          document: gql(DeleteDocApplicationsOrginId.deleteDoc(documentTypeId)),
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

  RxList<IcsCitizenModelOrginId> icsCitizens =
      List<IcsCitizenModelOrginId>.of([]).obs;
  var isfechediCitizens = false.obs;
  void getCitizene() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_citizens'] as List)
            .map((e) => IcsCitizenModelOrginId.fromJson(e))
            .toList();

        // countLabours.value = getlabour.value.length;
      }

      isfechediCitizens(true);
    } catch (e, s) {
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

enum VideoTypenew { video, image, audio, unknown }

class PassportDocuments {
  final documentTypeId;
  final List<PlatformFile> files;

  const PassportDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
