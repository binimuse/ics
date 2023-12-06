import 'package:dio/dio.dart' as Mydio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/app/modules/new_passport/data/model/confirmation_model.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/modules/new_passport/data/mutation/ics_citizens_mutuation.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_emabassies.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_url.dart';
import 'package:ics/app/modules/new_passport/data/quary/ics_citizens.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ics/services/graphql_conf.dart';

import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import '../data/quary/get_all.dart';

import 'package:http_parser/http_parser.dart';

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
  List<CommonJsonModel> bcountries = [];
  List<AllowedContreyModel> allwoedCountries = [];
  List<CommonIDModel> base_document_types = [];
  List<PassportDocuments> documents = [];

  final Rxn<CommonJsonModel> birthCountryvalue = Rxn<CommonJsonModel>();
  final Rxn<CommonJsonModel> embassiesvalue = Rxn<CommonJsonModel>();

  final TextEditingController countryController = TextEditingController();

  final Rxn<AllowedContreyModel> countryvalue = Rxn<AllowedContreyModel>();

  int currentStep = 0;
  final TextEditingController dateofbirth = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  List<String> eyecolor = [
    'Black',
    'Brown',
    'Blue',
    'Other',
  ];

  final RxString eyecolorvalue = ''.obs;
  final TextEditingController fatherNameController = TextEditingController();
  //Step 1
  final TextEditingController firstNameController = TextEditingController();

  GetallQuery getGenderQuery = GetallQuery();
  GetUrlQuery geturlQuery = GetUrlQuery();
  Getaicscitizens getaicscitizens = Getaicscitizens();
  GetEmbassiesQuery getEmbassiesQuery = GetEmbassiesQuery();
  final TextEditingController grandFatherNameController =
      TextEditingController();

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  List<String> haircolor = [
    'Black',
    'Brown',
    'Blonde',
    'Red',
    'Gray and White Hair',
  ];

  final RxString haircolorvalue = ''.obs;
  //Step 2

  final TextEditingController height = TextEditingController();

  var isfeched = false.obs;

  final Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();

  List<CommonModel> martial = [];
  List<CommonModel> gender = [];
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

  List<String> occupations = [
    'Waiter',
    'Dentist',
    'Nurse',
    'Doctor',
    'Surgeon',
    'Postman',
  ];

  final RxString occupationvalue = ''.obs;
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
        "description":
            "we only accept documents in PDF format. This requirement ensures that the application forms are standardized and can be easily processed",
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

  Future<void> getAll() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getGenderQuery.fetchData(), {});

      baseData.value = Basemodel.fromJson(result);
      gender = baseData.value!.base_genders.map((e) => e).toList();
      martial = baseData.value!.base_marital_statuses.map((e) => e).toList();

      bcountries = baseData.value!.base_countries.map((e) => e).toList();
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
      print(">>>>>>>>>>>>>>>>>> $e");
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
      AppToasts.showError("Document must not be empty");
      return;
    } else {
      await Future.delayed(const Duration(seconds: 1));
      AppToasts.showSuccess("New Passport Sent successfully");
      Get.offAllNamed(Routes.MAIN_PAGE);
    }
  }

  final Rxn<GetUrlModel> getUrlModel = Rxn<GetUrlModel>();
  Future<void> geturl(
    documentTypeId,
    PlatformFile files,
  ) async {
    try {
      dynamic result = await graphQLCommonApi.query(
        geturlQuery.fetchData("pdf", ""),
        {},
      );

      getUrlModel.value = GetUrlModel.fromJson(result!['getSignedUploadUrl']);
      isSendDocStarted(true);
      sendUrl(documentTypeId, getUrlModel.value!.url, files);
      isfeched(true);
    } catch (e) {
      isfeched(false);
      print("Error occurred while getting URL: $e");
    }
  }

  var isGetDocUrlStarted = false.obs;
  void sendUrl(
    String? documentTypeId,
    String? url,
    PlatformFile files,
  ) async {
    try {
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
        print('File uploaded successfully');
        sendDoc(
          newApplicationId,
          documentTypeId,
          url,
        );

        print(response);
      } else {
        isGetDocUrlStarted(false);
        print('Failed to upload file. Error: ${response.statusCode}');
      }
    } catch (e) {
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
          document: gql(IcscitizensMutation.ics_citizens),
          variables: <String, dynamic>{
            'objects': {
              'first_name': firstNameController.text,
              'father_name': fatherNameController.text,
              'first_name_json': firstnameToJson(),
              'father_name_json': fathernameToJson(),
              'grand_father_name_json': gfathernameToJson(),
              'gender': gendervalue.value!.name,
              'birth_place': birthCountryvalue.value!.name_json,
              'birth_country_id': birthCountryvalue.value!.id,
              'date_of_birth': formattedDateOfBirth,
              'occupation': occupationvalue.value,
              'hair_colour': haircolorvalue.value,
              'eye_colour': eyecolorvalue.value,
              'marital_status': maritalstatusvalue.value!.name,
              'height': height.text,
              'skin_colour': skincolorvalue.value,
              'abroad_country_id': countryvalue.value!.id,
              'abroad_address': addressController.text,
              'embassy_id': embassiesvalue.value!.id,
              'abroad_phone_number': phonenumber.text,
              'new_applications': {
                "data": {"delivery_date": null}
              }
            }
          },
        ),
      );

      if (result.hasException) {
        isSend.value = false;
        print(result.exception.toString());
        isSendStared.value = false;
      } else {
        print(result.data);
        print("""object""");
        isSend.value = true;
        isSendStared.value = false;

        newApplicationId = result.data!['insert_ics_citizens']['returning'][0]
                ['new_applications'][0]['id']
            .toString();
      }
    } catch (e) {
      isSendStared.value = false;
      isSend.value = false;
      print('Error: $e');
    }
  }

  var isSendDocStarted = false.obs;
  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    dynamic newApplicationId,
    var documentTypeId,
    var url,
  ) async {
    try {
      // file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(NewDocApplications.newDoc),
          variables: <String, dynamic>{
            'objects': {
              'new_application_id': newApplicationId,
              'files': url,
              'document_type_id': documentTypeId,
            }
          },
        ),
      );

      if (result.hasException) {
        isSendDocStarted(false);
        print(result.exception.toString());
      } else {
        isSendDocSuccess(true);
        isSendDocStarted(false);

        AppToasts.showSuccess("Document uploaded successfully");
      }
    } catch (e) {
      isSendDocStarted(false);
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
    try {
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_citizens'] as List)
            .map((e) => IcsCitizenModel.fromJson(e))
            .toList();

        // countLabours.value = getlabour.value.length;
      }

      isfechediCitizens(true);
    } catch (e) {
      isfechediCitizens(false);
      print(">>>>>>>>>>>>>>>>>> $e");
    }
  }

  var isfechedEmbassies = false.obs;
  RxList<CommonJsonModel> base_embassies = List<CommonJsonModel>.of([]).obs;
  void getEmbassies(String id) async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getEmbassiesQuery.fetchData(id), {});

      if (result != null) {
        base_embassies.value = (result['base_embassies'] as List)
            .map((e) => CommonJsonModel.fromJson(e))
            .toList();

        // countLabours.value = getlabour.value.length;
      }

      isfechedEmbassies(true);
    } catch (e) {
      isfechedEmbassies(false);
      print(">>>>>>>>>>>>>>>>>> $e");
    }
  }
}

enum VideoTypenew { video, image, audio, unknown }

enum base_marital_statuses_enum {
  Married,
}

class PassportDocuments {
  final documentTypeId;
  final List<PlatformFile> files;

  const PassportDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
