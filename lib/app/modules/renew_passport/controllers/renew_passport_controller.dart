import 'package:file_picker/file_picker.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';

import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/home/data/models/base_renewtype_passport_model.dart';
import 'package:ics/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/modules/new_passport/data/mutation/ics_citizens_mutuation.dart';

import 'package:ics/app/modules/renew_passport/data/model/base_model_renew_passport.dart';

import 'package:ics/app/modules/renew_passport/data/model/citizens_model_renew_passport.dart';

import 'package:ics/app/modules/renew_passport/data/model/fileurl_passport.dart';

import 'package:ics/app/modules/renew_passport/data/mutation/ics_citizens_mutuation_passport.dart';

import 'package:ics/app/modules/renew_passport/data/quary/get_all_renew_passport.dart';

import 'package:ics/app/modules/renew_passport/data/quary/get_emabassies_passport.dart';

import 'package:ics/app/modules/renew_passport/data/quary/get_url_passport.dart';

import 'package:ics/app/modules/renew_passport/data/quary/ics_citizens_passport.dart';

import 'package:flutter/material.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/services/graphql_conf.dart';

import 'dart:async';

import 'dart:io';

import 'package:mime/mime.dart';

import 'package:intl/intl.dart';

class RenewPassportController extends GetxController
    with SingleGetTickerProviderMixin {
  final TextEditingController AmfatherNameController = TextEditingController();

  final TextEditingController AmfirstNameController = TextEditingController();

  final TextEditingController AmgrandFatherNameController =
      TextEditingController();

  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;

  final ScrollController scrollController = ScrollController();

  //NETWORK STATUS

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  List<String> SkinColor = [
    'Black',
    'Brown',
    'Blue',
    'Other',
  ];

  RxList<File> selectedImages = <File>[].obs;

  final TextEditingController addressController = TextEditingController();

  final Rxn<BasemodelRenewPassport> baseData = Rxn<BasemodelRenewPassport>();

  final Rxn<BaseDocRenewPassport> baseDocData = Rxn<BaseDocRenewPassport>();

  List<AllowedContreyModel> allwoedCountries = [];

  List<CommonModel> base_document_types = [];

  List<OrginIDDocuments> documents = [];

  final Rxn<CommonModel> birthCountryvalue = Rxn<CommonModel>();

  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();

  final Rxn<CommonModel> visatypevalue = Rxn<CommonModel>();

  final Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();

  final Rxn<CommonModel> embassiesvalue = Rxn<CommonModel>();

  final Rxn<CommonModel> correctionTypevalue = Rxn<CommonModel>();

  final TextEditingController countryController = TextEditingController();

  final Rxn<AllowedContreyModel> countryvalue = Rxn<AllowedContreyModel>();

  final Rxn<AllowedContreyModel> currentcountryvalue =
      Rxn<AllowedContreyModel>();

  var currentStep = 0.obs;

  final TextEditingController dateofbirth = TextEditingController();

  final TextEditingController dayController = TextEditingController();

  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();

  final TextEditingController fatherNameController = TextEditingController();

  final TextEditingController birthplace = TextEditingController();

  //Step 1

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController grandFatherNameController =
      TextEditingController();

  GetallQueryRenewPassport getGenderQuery = GetallQueryRenewPassport();

  GetUrlQueryRenewPassport geturlQuery = GetUrlQueryRenewPassport();

  GetaicscitizensRenewPassport getaicscitizens = GetaicscitizensRenewPassport();

  GetEmbassiesQueryRenewPassport getEmbassiesQuery =
      GetEmbassiesQueryRenewPassport();

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

  var isDataCorrection = false.obs;

  final Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();

  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();

  List<CommonModel> martial = [];

  List<CommonModel> gender = [];

  List<CommonModel> occupations = [];

  List<CommonModel> familytype = [];

  List<CommonModel> bcountries = [];

  List<CommonModel> correctiontyoe = [];

  List<CommonModel> natinality = [];

  List<CommonModel> haircolor = [];

  List<CommonModel> visaType = [];

  List<CommonModel> eyecolor = [];

  final TextEditingController monthController = TextEditingController();

  final renewPassportformKey = GlobalKey<FormBuilderState>();

  //step 4

  final TextEditingController passportNumberContoller = TextEditingController();

  final TextEditingController visanumberContoller = TextEditingController();

  final TextEditingController orginIdnumberContoller = TextEditingController();

  final TextEditingController passportIssueDateController =
      TextEditingController();

  final TextEditingController visaIssueDateController = TextEditingController();

  final TextEditingController passportExpiryDateController =
      TextEditingController();

  final TextEditingController visaExpiryDateController =
      TextEditingController();

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

  final RxList<FamilyModel> familyModelvalue = RxList<FamilyModel>();

  var countryCode = "+251";

  //Step 3

  final TextEditingController phonenumber = TextEditingController();

  final reasonController = TextEditingController();

  var selectedDate = DateTime.now().obs;

  final RxString skincolorvalue = ''.obs;

  //for birthDate

  final TextEditingController yearController = TextEditingController();
  late TabController tabController;
  late BasePassportRenewalType renewType;

  dynamic argumentdata = Get.arguments;

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    renewType = argumentdata["RenewType"];

    print("huhuh ${renewType.id}");

    getAll();

    getCitizene();

    super.onInit();
  }

  List<DateTime> occupiedDates = [
    DateTime(2024, 2, 1),

    DateTime(2024, 2, 3),

    // Add more dates...
  ];

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

      baseData.value = BasemodelRenewPassport.fromJson(result);

      gender = baseData.value!.base_genders.map((e) => e).toList();

      eyecolor = baseData.value!.base_eye_colors.map((e) => e).toList();

      haircolor = baseData.value!.base_hair_colors.map((e) => e).toList();

      martial = baseData.value!.base_marital_statuses.map((e) => e).toList();

      occupations = baseData.value!.base_occupations.map((e) => e).toList();

      familytype = baseData.value!.base_family_types.map((e) => e).toList();

      bcountries = baseData.value!.base_countries.map((e) => e).toList();

      correctiontyoe =
          baseData.value!.base_correction_types.map((e) => e).toList();

      natinality = baseData.value!.base_countries.map((e) => e).toList();

      allwoedCountries =
          baseData.value!.allowed_countries.map((e) => e).toList();

      visaType = baseData.value!.base_visa_types.map((e) => e).toList();

      isfeched(true);
    } catch (e, s) {
      print(e);

      print(s);

      isfeched(false);
    }
  }

  GetDocQueryRenewPassport getDocQueryRenewOrginId = GetDocQueryRenewPassport();

  Future<void> getDoctype(String type) async {
    try {
      dynamic result = await graphQLCommonApi
          .query(getDocQueryRenewOrginId.fetchData(type), {});

      baseDocData.value = BaseDocRenewPassport.fromJson(result);

      base_document_types =
          baseDocData.value!.base_document_types.map((e) => e).toList();

      for (var documentType in base_document_types) {
        documents
            .add(OrginIDDocuments(documentTypeId: documentType.id, files: []));
      }

      isfeched(true);
    } catch (e, s) {
      print(e);

      print(s);

      isfeched(false);
    }
  }

  void check() {
    final isValid = renewPassportformKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      renewPassportformKey.currentState!.save();

      send(); // Call report() when the form is valid
    }
  }

  final Rxn<GetUrlModelRenewPassport> getUrlModel =
      Rxn<GetUrlModelRenewPassport>();

  var isGetDocUrlStarted = false.obs;

  var isSend = false.obs;

  var isSendStared = false.obs;

  RxList<String> photoPath = <String>[].obs;

  var applicattionId;
  List<DocPathModel> docList = [];
  Future<void> send() async {
    networkStatus.value = NetworkStatus.LOADING;

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
          document: gql(IcscitizensMutationReNewPassport.ics_citizens),
          variables: <String, dynamic>{
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
              'occupation_id': occupationvalue.value?.id ?? null,
              'hair_colour': haircolorvalue.value?.name ?? null,
              'eye_colour': eyecolorvalue.value?.name ?? null,
              'marital_status': maritalstatusvalue.value!.name,
              'height': height.text.isEmpty ? null : height.text,
              'is_adopted': isAdoption.value,
              'photo': photoPath.first,
              'skin_colour': skincolorvalue.value,
              'abroad_country_id': countryvalue.value!.id,
              'abroad_address': addressController.text,
              'phone_number': countryCode.toString() + phonenumber.text,
              'embassy_id': embassiesvalue.value!.id,
              'current_country_id': currentcountryvalue.value!.id,
              'application_type': "RENEW_PASSPORT_APPLICATION",
              'renew_passport_applications': {
                "data": {
                  'passport_number': passportNumberContoller.text,
                  'correction_type_id': correctionTypevalue.value != null
                      ? correctionTypevalue.value!.id
                      : null,
                  'passport_renewal_type_id': renewType.id,
                }
              },
              'citizen_families': {
                "data":
                    familyModelvalue.map((element) => element.toJson()).toList()
              },
              'application_documents': {
                "data": docList.map((e) => e.toJson()).toList()
              },
            }
          },
        ),
      );

      if (result.hasException) {
        networkStatus.value = NetworkStatus.ERROR;

        print("""objects""");

        isSend.value = false;

        print(result.exception.toString());

        isSendStared.value = false;
      } else {
        networkStatus.value = NetworkStatus.SUCCESS;

        print(result.data);

        isSend.value = true;

        isSendStared.value = false;

        applicattionId = result.data!['insert_ics_applications']['returning'][0]
                ['id']
            .toString();
        updateNewApplication();
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;

      isSendStared.value = false;

      isSend.value = false;

      print('Errors: $s');

      if (e.toString().contains("Null ")) {
        //  AppToasts.showError("please provide Emabases");
      } else {
        AppToasts.showError("Something went wrong");
      }
    }
  }

  // var isSendDocSuccess = false.obs;

  // var newDocId;

  // Future<void> sendDoc(
  //   var documentTypeId,
  //   var path,
  // ) async {
  //   try {
  //     isSendStared.value = true;

  //     // file upload

  //     GraphQLClient graphQLClient;

  //     graphQLClient = GraphQLConfiguration().clientToQuery();

  //     final QueryResult result = await graphQLClient.mutate(
  //       MutationOptions(
  //         document: gql(NewDocApplications.newDoc),
  //         variables: <String, dynamic>{
  //           'objects': {
  //             'application_id': applicattionId,
  //             'files': {
  //               'path': path,
  //             },
  //             'document_type_id': documentTypeId,
  //           }
  //         },
  //       ),
  //     );

  //     if (result.hasException) {
  //       isSendStared.value = false;

  //       print(result.exception.toString());
  //     } else {
  //       isSendDocSuccess(true);

  //       isSendStared.value = false;

  //       AppToasts.showSuccess("Document uploaded successfully");
  //     }
  //   } catch (e) {
  //     isSendStared.value = false;

  //     print('Error: $e');
  //   }
  // }

  var isUpdateSuccess = false.obs;
  Future<void> updateNewApplication() async {
    try {
      //file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(UpdateNewApplication.update(applicattionId)),
        ),
      );

      if (result.hasException) {
        isUpdateSuccess(false);
        print(result.exception.toString());
      } else {
        Get.delete<RenewPassportController>();
        AppToasts.showSuccess("Passport request Sent successfully");
        // final MyOrderController controller = Get.put(MyOrderController());
        // controller.getNewPassport();
        MyOrderController myOrderController = Get.put(MyOrderController());

        myOrderController.getOrginOrder();

        Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
        Get.find<MainPageController>().changeBottomPage(1);
        myOrderController.tabController.index = 0;
        isUpdateSuccess(true);
      }
    } catch (e) {
      print(e.toString());
      isUpdateSuccess(false);
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
          document:
              gql(DeleteDocApplicationsReNewPassport.deleteDoc(documentTypeId)),
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

  RxList<IcsApplicationModelReNewPassport> icsCitizens =
      List<IcsApplicationModelReNewPassport>.of([]).obs;

  var isfechediCitizens = false.obs;

  void getCitizene() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_applications'] as List)
            .map((e) => IcsApplicationModelReNewPassport.fromJson(e))
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

class OrginIDDocuments {
  final documentTypeId;

  final List<PlatformFile> files;

  const OrginIDDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
