// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/config/theme/app_colors.dart';

import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/home/data/models/base_renewtype_model.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/booked_date_model.dart';
import 'package:ics/app/modules/new_passport/data/mutation/book_appointemts_mutation.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_booked_date.dart';

import 'package:ics/app/modules/renew_origin_id/data/model/base_model_renew_orgin.dart';

import 'package:ics/app/modules/renew_origin_id/data/model/citizens_model_renew_orginId.dart';

import 'package:ics/app/modules/renew_origin_id/data/model/fileurl_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/data/mutation/ics_citizens_mutuation_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/data/quary/get_all_renew_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/data/quary/get_emabassies_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/data/quary/get_url_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/data/quary/ics_citizens_orginid.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/services/graphql_conf.dart';

import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class RenewOriginIdController extends GetxController
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

  final TextEditingController addressController = TextEditingController();

  final Rxn<BasemodelRenewOrginId> baseData = Rxn<BasemodelRenewOrginId>();

  final Rxn<BaseDocRenewOrginId> baseDocData = Rxn<BaseDocRenewOrginId>();

  List<AllowedContreyModel> allwoedCountries = [];

  RxList<File> selectedImages = <File>[].obs;

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

  final RxString skincolorvalue = ''.obs;

  //for birthDate

  final TextEditingController yearController = TextEditingController();
  late TabController tabController;
  late BaseOriginIdRenewalType renewType;

  dynamic argumentdata = Get.arguments;

  @override
  void onInit() {
    renewType = argumentdata["RenewType"];
    tabController = TabController(length: 4, vsync: this);
    getAll();

    getCitizene();

    super.onInit();
  }

  List<DateTime> occupiedDates = [
    // Add more dates...
  ];
  var setFetchedStatus = false.obs;
  final Rxn<BookedDate> bookedDate = Rxn<BookedDate>();
  GetBookedDate getBookedDate = GetBookedDate();
  Future<void> getBookedDates(String embasiyId) async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getBookedDate.fetchData(embasiyId), {});
      bookedDate.value = BookedDate.fromMap(result);

      setFetchedStatus(true);
      networkStatus.value = NetworkStatus.SUCCESS;

      // first clear
      occupiedDates.clear();
      // Add fetched dates to occupiedDates list
      List<DateTime> fetchedDates = [];
      for (var bookedDate in bookedDate.value!.icsNewPassportBookedDates) {
        // Remove the time component from the DateTime object
        DateTime dateWithoutTime = DateTime(bookedDate.bookingDate.year,
            bookedDate.bookingDate.month, bookedDate.bookingDate.day);
        fetchedDates.add(dateWithoutTime);
      }
      occupiedDates = fetchedDates;
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      print("Error occurred while fetching data: $s");
      setFetchedStatus(false);
    }
  }

  late DateTime? selectedDate;
  late DateTime? selectedDateTime;
  Future<void> sendBookedDates(BuildContext context) async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();
      // Remove the time component from the selectedDate
      // Convert selectedDate to a date string without the time component
      String dateString = selectedDate!.toIso8601String().split('T').first;

      print(dateString);

      String timetz = DateFormat("HH:mm:ss").format(selectedDateTime!);

      print(timetz);

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(NewAppointments.newApp),
          variables: <String, dynamic>{
            "objects": {
              "date": dateString,
              "application_id": newApplicationID,
              "start_time": timetz,
            }
          },
        ),
      );

      if (!result.hasException) {
        networkStatus.value = NetworkStatus.SUCCESS;
        AppToasts.showSuccess("Renew Origin Sent");

        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        networkStatus.value = NetworkStatus.ERROR;
        AppToasts.showError("Something went wrong");
        print(result);
      }
    } catch (e, s) {
      AppToasts.showError("Something went wrong");
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
    }
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

      print("bini ${type}");

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

  var isGetDocUrlStarted = false.obs;

  var isSend = false.obs;

  var isSendStared = false.obs;

  RxList<String> photoPath = <String>[].obs;

  var newApplicationID;

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
              'photo': photoPath.first,
              'marital_status': maritalstatusvalue.value!.name,
              'height': height.text,
              'is_adopted': isAdoption.value,
              'skin_colour': skincolorvalue.value,
              'abroad_country_id': countryvalue.value!.id,
              'abroad_address': addressController.text,
              'phone_number': phonenumber.text,
              'embassy_id': embassiesvalue.value!.id,
              'current_country_id': currentcountryvalue.value!.id,
              'application_type': "RENEW_ORIGIN_ID_APPLICATION",
              'renewal_origin_id_applications': {
                "data": {
                  'current_passport_issued_date':
                      passportIssueDateController.text,
                  'current_passport_expiry_date':
                      passportExpiryDateController.text,
                  'current_passport_number': passportNumberContoller.text,
                  'visa_expiry_date': visaExpiryDateController.text,
                  'visa_issued_date': visaExpiryDateController.text,
                  'visa_type_id': visatypevalue.value?.id ?? null,
                  'visa_number': visanumberContoller.text,
                  'origin_id_number': orginIdnumberContoller.text,
                  'correction_type_id': correctionTypevalue.value != null
                      ? correctionTypevalue.value!.id
                      : null,
                  'origin_id_renewal_type_id': renewType.id,
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
        newApplicationID = result.data!['insert_ics_applications']['returning']
                [0]['id']
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
          document: gql(ReNewDocApplicationsOrginId.newDoc),
          variables: <String, dynamic>{
            'objects': {
              'application_id': newApplicationID,
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

  var isUpdateSuccess = false.obs;
  Future<void> updateNewApplication() async {
    try {
      //file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(UpdateNewApplication.update(newApplicationID)),
        ),
      );

      if (result.hasException) {
        isUpdateSuccess(false);
        print(result.exception.toString());
      } else {
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

  RxList<IcsApplicationModelReNewOrginId> icsCitizens =
      List<IcsApplicationModelReNewOrginId>.of([]).obs;

  var isfechediCitizens = false.obs;

  void getCitizene() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_applications'] as List)
            .map((e) => IcsApplicationModelReNewOrginId.fromJson(e))
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

  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.primary,
    exportBackgroundColor: AppColors.grayLight,
  );

  var showImage = false.obs;
  ImageProvider? signatureImage;
  void handleDrawFinish() {
    exportSignatureToPng(signatureController);
  }

  Future<ExportResult> exportSignatureToPng(
      SignatureController signatureController) async {
    try {
      showImage.value = false;
      // Convert the Signature to an image
      final Uint8List? pngBytes = await signatureController.toPngBytes();

      if (pngBytes != null) {
        // Encode the PNG image as a base64 string
        String base64Image = base64.encode(pngBytes);

        signatureImage = base64ToImage(base64Image);

        // Here you can use the base64Image string as needed
        print('Exported signature image successfully');
        return ExportResult.success;
      } else {
        showImage.value = false;
        throw Exception('Failed to export signature image');
      }
    } catch (e) {
      showImage.value = false;
      print('Failed to export signature image: $e');
      return ExportResult.error;
    }
  }

  ImageProvider base64ToImage(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    showImage.value = true;
    return MemoryImage(bytes);
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
