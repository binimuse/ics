import 'dart:async';


import 'dart:io';


import 'package:dio/dio.dart' as Mydio;


import 'package:file_picker/file_picker.dart';


import 'package:flutter_form_builder/flutter_form_builder.dart';


import 'package:get/get.dart';


import 'package:flutter/material.dart';


import 'package:graphql_flutter/graphql_flutter.dart';


import 'package:ics/app/common/app_toasts.dart';


import 'package:ics/app/common/data/graphql_common_api.dart';


import 'package:ics/app/data/enums.dart';


import 'package:ics/app/modules/home/data/models/base_renewtype_model.dart';


import 'package:ics/app/modules/renew_origin_id/data/model/base_model_renew_orgin.dart';


import 'package:ics/app/modules/renew_origin_id/data/model/citizens_model_renew_orginId.dart';


import 'package:ics/app/modules/renew_origin_id/data/model/fileurl_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/data/mutation/ics_citizens_mutuation_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/data/quary/get_all_renew_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/data/quary/get_emabassies_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/data/quary/get_url_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/data/quary/ics_citizens_orginid.dart';


import 'package:ics/services/graphql_conf.dart';


import 'package:mime/mime.dart';


import 'package:http_parser/http_parser.dart';


import 'package:intl/intl.dart';


class RenewOriginIdController extends GetxController {

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


  final TextEditingController addressController = TextEditingController();


  final Rxn<BasemodelRenewOrginId> baseData = Rxn<BasemodelRenewOrginId>();


  final Rxn<BaseDocRenewOrginId> baseDocData = Rxn<BaseDocRenewOrginId>();


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


  int currentStep = 0;


  final TextEditingController dateofbirth = TextEditingController();


  final TextEditingController dayController = TextEditingController();


  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();


  final TextEditingController fatherNameController = TextEditingController();


  final TextEditingController birthplace = TextEditingController();


  //Step 1


  final TextEditingController firstNameController = TextEditingController();


  final TextEditingController grandFatherNameController =

      TextEditingController();


  GetallQueryRenewOrginId getGenderQuery = GetallQueryRenewOrginId();


  GetUrlQueryRenewOrginId geturlQuery = GetUrlQueryRenewOrginId();


  GetaicscitizensRenewOrginId getaicscitizens = GetaicscitizensRenewOrginId();


  GetEmbassiesQueryRenewOrginId getEmbassiesQuery =

      GetEmbassiesQueryRenewOrginId();


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


  final reneworginIdformKey = GlobalKey<FormBuilderState>();


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


  //Step 3


  final TextEditingController phonenumber = TextEditingController();


  final reasonController = TextEditingController();


  var selectedDate = DateTime.now().obs;


  final RxString skincolorvalue = ''.obs;


  //for birthDate


  final TextEditingController yearController = TextEditingController();


  late BaseOriginIdRenewalType renewType;


  dynamic argumentdata = Get.arguments;


  @override

  void onInit() {

    renewType = argumentdata["RenewType"];


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


      baseData.value = BasemodelRenewOrginId.fromJson(result);


      gender = baseData.value!.base_genders.map((e) => e).toList();


      eyecolor = baseData.value!.base_eye_colors.map((e) => e).toList();


      haircolor = baseData.value!.base_hair_colors.map((e) => e).toList();


      martial = baseData.value!.base_marital_statuses.map((e) => e).toList();


      occupations = baseData.value!.base_occupations.map((e) => e).toList();


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


  GetDocQueryRenewOrginId getDocQueryRenewOrginId = GetDocQueryRenewOrginId();


  Future<void> getDoctype(String type) async {

    try {

      dynamic result = await graphQLCommonApi

          .query(getDocQueryRenewOrginId.fetchData(type), {});


      baseDocData.value = BaseDocRenewOrginId.fromJson(result);


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

    final isValid = reneworginIdformKey.currentState!.validate();


    if (!isValid) {

      return;

    } else {

      reneworginIdformKey.currentState!.save();


      send(); // Call report() when the form is valid

    }

  }


  final Rxn<GetUrlModelRenewOrginid> getUrlModel =

      Rxn<GetUrlModelRenewOrginid>();


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

          GetUrlModelRenewOrginid.fromJson(result!['getSignedUploadUrl']);


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

          renewOriginIDApplicationId,

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


  var renewOriginIDApplicationId;


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

          document: gql(IcscitizensMutationReNewOrginId.ics_citizens),

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

              'renewal_origin_id_applications': {

                "data": {

                  'embassy_id': embassiesvalue.value!.id,

                  'current_passport_expiry_date':

                      passportExpiryDateController.text,

                  'current_passport_issued_date':

                      passportIssueDateController.text,

                  'current_passport_number': passportNumberContoller.text,
                  'visa_expiry_date': visaExpiryDateController.text ?? null,
                  'visa_issued_date': visaExpiryDateController.text ?? null,

                  'visa_type_id': visatypevalue.value?.id ?? null,

                  'visa_number': visanumberContoller.text ?? null,

                  'origin_id_number': orginIdnumberContoller.text,

                  'correction_type_id': correctionTypevalue.value != null

                      ? correctionTypevalue.value!.id

                      : null,

                  'origin_id_renewal_type_id': renewType.id,

                  'current_country_id': currentcountryvalue.value!.id,

                }

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


        renewOriginIDApplicationId = result.data!['insert_ics_citizens']

                ['returning'][0]['renewal_origin_id_applications'][0]['id']

            .toString();

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


  var isSendDocSuccess = false.obs;


  var newDocId;


  Future<void> sendDoc(

    dynamic reneworginID,

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

          document: gql(ReNewDocApplicationsOrginId.newDoc),

          variables: <String, dynamic>{

            'objects': {

              'renew_origin_id_application_id': reneworginID,

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

          document:

              gql(DeleteDocApplicationsReNewOrginId.deleteDoc(documentTypeId)),

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


  RxList<IcsCitizenModelReNewOrginId> icsCitizens =

      List<IcsCitizenModelReNewOrginId>.of([]).obs;


  var isfechediCitizens = false.obs;


  void getCitizene() async {

    try {

      dynamic result =

          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});


      if (result != null) {

        icsCitizens.value = (result['ics_citizens'] as List)

            .map((e) => IcsCitizenModelReNewOrginId.fromJson(e))

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

