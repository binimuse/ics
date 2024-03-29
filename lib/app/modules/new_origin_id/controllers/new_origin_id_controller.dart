// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/common/fileupload/common_file_uploder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/base_model_orgin.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';
import 'package:ics/app/modules/new_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/model/fileurl_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/mutation/ics_citizens_mutuation_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_emabassies_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_url_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/ics_citizens_orginid.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/booked_date_model.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_booked_date.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ics/services/graphql_conf.dart';
import 'dart:async';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import '../data/quary/get_all_orginid.dart';

class NewOriginIdController extends GetxController
    with SingleGetTickerProviderMixin {
  final TextEditingController AmfatherNameController = TextEditingController();
  final TextEditingController AmfirstNameController = TextEditingController();
  final TextEditingController AmgrandFatherNameController =
      TextEditingController();
  final ScrollController scrollController = ScrollController();
  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;
  //NETWORK STATUS
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  List<String> SkinColor = [
    'Black',
    'Brown',
    'Blue',
    'Other',
  ];

  final TextEditingController addressController = TextEditingController();

  final Rxn<BasemodelOrginId> baseData = Rxn<BasemodelOrginId>();
  var countryCode = "+251";
  List<AllowedContreyModel> allwoedCountries = [];
  List<CommonModel> base_document_types = [];
  List<OrginIDDocuments> documents = [];

  final Rxn<CommonModel> birthCountryvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> visatypevalue = Rxn<CommonModel>();
  final Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> embassiesvalue = Rxn<CommonModel>();

  final TextEditingController countryController = TextEditingController();
  RxList<File> selectedImages = <File>[].obs;
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
  List<CommonModel> visaType = [];
  List<CommonModel> eyecolor = [];
  final TextEditingController monthController = TextEditingController();
  final neworginIdformKey = GlobalKey<FormBuilderState>();

  //step 4
  final TextEditingController passportNumberContoller = TextEditingController();
  final TextEditingController visanumberContoller = TextEditingController();
  final TextEditingController passportIssueDateController =
      TextEditingController();
  final TextEditingController passportExpiryDateController =
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
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    getAll();
    getCitizene();

    super.onInit();
  }

  final Rxn<BookedDate> bookedDate = Rxn<BookedDate>();
  GetBookedDate getBookedDate = GetBookedDate();
  var setFetchedStatus = false.obs;
  List<DateTime> occupiedDates = [
    // Add more dates...
  ];

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

  DateTime? selectedDate;
  DateTime? selectedDateTime;

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

      bcountries = baseData.value!.base_countries.map((e) => e).toList();
      natinality = baseData.value!.base_countries.map((e) => e).toList();
      allwoedCountries =
          baseData.value!.allowed_countries.map((e) => e).toList();
      base_document_types =
          baseData.value!.base_document_types.map((e) => e).toList();
      visaType = baseData.value!.base_visa_types.map((e) => e).toList();
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
    final isValid = neworginIdformKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      neworginIdformKey.currentState!.save();
      send(); // Call report() when the form is valid
    }
  }

  final Rxn<GetUrlModelOrginid> getUrlModel = Rxn<GetUrlModelOrginid>();
  List<DocPathModel> docList = [];
  var isSend = false.obs;
  var isSendStared = false.obs;
  var newApplicationID;
  RxList<String> photoPath = <String>[].obs;
  RxList<String> signaturePath = <String>[].obs;
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

      String dateString = selectedDate!.toIso8601String().split('T').first;

      print(dateString);

      String timetz = DateFormat("HH:mm:ss").format(selectedDateTime!);

      print(timetz);

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
              'birth_place': birthplace.text,
              'birth_country_id': birthCountryvalue.value!.id,
              'nationality_id': natinalityvalue.value!.id,
              'date_of_birth': formattedDateOfBirth,
              'occupation_id': occupationvalue.value?.id ?? null,
              'hair_colour': haircolorvalue.value?.name ?? null,
              'eye_colour': eyecolorvalue.value?.name ?? null,
              'marital_status': maritalstatusvalue.value!.name,
              'height': height.text.isEmpty ? null : height.text,
              'photo': photoPath.first,
              'is_adopted': isAdoption.value,
              'skin_colour': skincolorvalue.value,
              'abroad_country_id': countryvalue.value!.id,
              'abroad_address': addressController.text,
              'phone_number': countryCode.toString() + phonenumber.text,
              'embassy_id': embassiesvalue.value!.id,
              'current_country_id': currentcountryvalue.value!.id,
              'application_type': "NEW_ORIGIN_ID_APPLICATION",
              'new_origin_id_applications': {
                "data": {
                  'signature': signaturePath.last,
                  'current_passport_expiry_date':
                      passportExpiryDateController.text,
                  'current_passport_issued_date':
                      passportIssueDateController.text,
                  'current_passport_number': passportNumberContoller.text,
                  'visa_type_id': visatypevalue.value?.id ?? null,
                  'visa_number': visanumberContoller.text,
                }
              },
              'application_documents': {
                "data": docList.map((e) => e.toJson()).toList()
              },
              'application_appointments': {
                "data": {
                  "date": dateString,
                  "start_time": timetz,
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

        updateNewApplication();
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      isSendStared.value = false;
      isSend.value = false;
      print('Errors: $e');
      if (e.toString().contains("Null ")) {
      } else {
        AppToasts.showError("Something went wrong");
      }
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

        Get.delete<NewOriginIdController>();
        AppToasts.showSuccess("New Orogin Sent successfully");
        MyOrderController myOrderController = Get.put(MyOrderController());

        myOrderController.getOrginOrder();

        Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
        Get.find<MainPageController>().changeBottomPage(1);
        myOrderController.tabController.index = 1;
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

  RxList<IcsApplicationModelOrginId> icsCitizens =
      List<IcsApplicationModelOrginId>.of([]).obs;
  var isfechediCitizens = false.obs;
  void getCitizene() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsCitizens.value = (result['ics_applications'] as List)
            .map((e) => IcsApplicationModelOrginId.fromJson(e))
            .toList();

        icsCitizens.forEach((element) {
          print(element.newOriginIdApplications.length);
        });

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
    exportSignatureToFile(signatureController);
    exportSignatureToPng(signatureController);
  }

  Future<PlatformFile?> exportSignatureToFile(
      SignatureController signatureController) async {
    // Get the signature as a Uint8List
    Uint8List? signatureBytes = await signatureController.toPngBytes();

    // Create a temporary file
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/signature.png').create();
    await file.writeAsBytes(signatureBytes!);

    // Create a PlatformFile from the file
    PlatformFile platformFile = PlatformFile(
      name: 'signature.png',
      size: file.lengthSync(),
      bytes: signatureBytes,
      path: file.path,
    );

    sendSignature(platformFile);

    return platformFile;
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

  sendSignature(PlatformFile pickedFile) async {
    networkStatus.value = NetworkStatus.LOADING;

    // Perform the async operations

    try {
      print("bini ${pickedFile}");
      MinioUploader uploader = MinioUploader();
      String responseUrl = await uploader.uploadFileToMinio(pickedFile, "");

      if (responseUrl.isNotEmpty) {
        signaturePath.clear();
        signaturePath.add(responseUrl);
        networkStatus.value = NetworkStatus.SUCCESS;

        // Response is successful
      }
    } on Exception catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;

      // Response is not successful

      print(s);
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
