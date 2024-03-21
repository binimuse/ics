import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/all_visa/data/model/all_visa_model.dart';
import 'package:ics/app/modules/all_visa/data/model/ics_companies.dart';
import 'package:ics/app/modules/all_visa/data/model/visa_appliaction_model.dart';
import 'package:ics/app/modules/all_visa/data/mutation/all_visa_mutuation.dart';
import 'package:ics/app/modules/all_visa/data/query/get_all_renew_orginid.dart';
import 'package:ics/app/modules/all_visa/data/query/ics_visa_application.dart';
import 'package:ics/app/modules/all_visa/views/widget/profile_view_i_visa.dart';

import 'package:ics/app/modules/evisa/data/models/base_visatype_model.dart';
import 'package:ics/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/services/graphql_conf.dart';
import 'package:intl/intl.dart';

// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/booked_date_model.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_booked_date.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_url.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

class ALLVisaController extends GetxController
    with SingleGetTickerProviderMixin {
//terms
  final TextEditingController companyreference = TextEditingController();

  //setp 1
  final TextEditingController givenNameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();

  final Rxn<CommonModel> citizenship = Rxn<CommonModel>();
  final Rxn<CommonModel> birthCountryvalue = Rxn<CommonModel>();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController birthplace = TextEditingController();
  final TextEditingController emailAdress = TextEditingController();
  List<CommonModel> occupations = [];
  List<CommonModel> passportTypes = [];
  List<CommonModel> accommodationTypes = [];
  final Rxn<CommonModel> occupationvalue = Rxn<CommonModel>();
  //setp 2
  final Rxn<AllowedContreyModel> countryvalue = Rxn<AllowedContreyModel>();
  final Rxn<AllowedContreyModel> adresscountryvalue =
      Rxn<AllowedContreyModel>();

  final TextEditingController addresscityController = TextEditingController();
  final TextEditingController streetaddressController = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  //step 3

  final TextEditingController arrivaldDateController = TextEditingController();

  final Rxn<AllowedContreyModel> departurecountry = Rxn<AllowedContreyModel>();

  final TextEditingController departurecity = TextEditingController();
  final TextEditingController airline = TextEditingController();
  final TextEditingController flight_Number = TextEditingController();

  //setp 4

  final Rxn<CommonModel> accommodationtypevalue = Rxn<CommonModel>();
  final TextEditingController accommodation_name = TextEditingController();
  final TextEditingController accommodation_city = TextEditingController();
  final TextEditingController accommodation_street_address =
      TextEditingController();
  final TextEditingController accommodation_Telephone = TextEditingController();
  //step 5
  final Rxn<CommonModel> passporttypevalue = Rxn<CommonModel>();
  final TextEditingController passport_number = TextEditingController();
  final TextEditingController passportIssueDate = TextEditingController();
  final TextEditingController passportexpiryDate = TextEditingController();
  final Rxn<AllowedContreyModel> passportIssueCountry =
      Rxn<AllowedContreyModel>();
  final TextEditingController passportIssueAuthority = TextEditingController();

  var isAgreedToTerms = false.obs;

  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;

  final Rxn<BookedDate> bookedDate = Rxn<BookedDate>();

  BaseVisaTypeModel baseVisaTypeModel = BaseVisaTypeModel();
  List<AllowedContreyModel> allwoedCountries = [];
  List<CommonModel> base_document_types = [];

  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();

  final TextEditingController countryController = TextEditingController();

  int currentStep = 0;
  final TextEditingController dateofbirth = TextEditingController();

  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();

  GetallQueryVisa getallQueryVisa = GetallQueryVisa();
  GetBookedDate getBookedDate = GetBookedDate();
  GetUrlQuery geturlQuery = GetUrlQuery();
  GetAllVisaAPplication getAllVisaAPplication = GetAllVisaAPplication();

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  final Rxn<CommonModel> haircolorvalue = Rxn<CommonModel>();
  var isSend = false.obs;

  //Step 2

  var isfeched = false.obs;

  var showAdoption = false.obs;

  final Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();

  List<CommonModel> martial = [];

  List<CommonModel> bcountries = [];
  List<CommonModel> natinality = [];

  List<String> contentTexts = [
    'Size of the image/document should be less than 2MB.'.tr,
    'Photo and Passport Copy should be only in Image file type of JPEG, JPG, PNG format.'
        .tr,
    'Allowed Images/documents file type extensions are JPEG, JPG, PNG and PDF format only.'
        .tr,
    'An image/document with blurred or unclean background is not acceptable.'
        .tr,
    'Please use the below Screenshot for Photograph Tips.'.tr,
  ];
  var countryCode = "+251";

  DateTime oneWeekFromNow = DateTime.now().add(Duration(days: 7));
  //tab
  late TabController tabController;

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

  final reasonController = TextEditingController();

  final RxString skincolorvalue = ''.obs;

  final count = 0.obs;

  var setFetchedStatus = false.obs;
  var isfechediCitizens = false.obs;
  RxList<IcsVisaApplicationModel> icsVisaApplicationModel =
      List<IcsVisaApplicationModel>.of([]).obs;
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    getAll();
    getCitizene();
    baseVisaTypeModel = Get.arguments["VisaType"];

    super.onInit();
  }

  var isfechedEmbassies = false.obs;
  final Rxn<BaseVisaModel> baseVisaModel = Rxn<BaseVisaModel>();
  Future<void> getAll() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getallQueryVisa.fetchData(), {});
      baseVisaModel.value = BaseVisaModel.fromMap(result);

      if (baseVisaModel.value == null) {
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

  List<CommonModel> gender = [];
  void mapBaseDataToLists() {
    gender = baseVisaModel.value!.baseGenders!;

    occupations = baseVisaModel.value!.baseOccupations!;
    passportTypes = baseVisaModel.value!.basePassportTypes!;
    accommodationTypes = baseVisaModel.value!.baseAccommodationTypes!;

    bcountries = baseVisaModel.value!.baseCountries!;
    natinality = baseVisaModel.value!.baseCountries!;
    allwoedCountries = baseVisaModel.value!.baseAllowedCountries!;

    print("bini ${allwoedCountries.first.name}");
  }

  GetallQueryInvestemntVisaId getallQueryInvestemntVisaId =
      GetallQueryInvestemntVisaId();
  List<AllVisaDocuments> documents = [];
  final Rxn<BaseDocAllVisa> baseDocData = Rxn<BaseDocAllVisa>();
  Future<void> getDoctype(String type) async {
    try {
      dynamic result = await graphQLCommonApi
          .query(getallQueryInvestemntVisaId.fetchData(type), {});

      baseDocData.value = BaseDocAllVisa.fromJson(result);

      base_document_types =
          baseDocData.value!.base_document_types.map((e) => e).toList();

      for (var documentType in base_document_types) {
        documents
            .add(AllVisaDocuments(documentTypeId: documentType.id, files: []));
      }

      isfeched(true);
    } catch (e, s) {
      print(e);

      print(s);

      isfeched(false);
    }
  }

  void getCitizene() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      networkStatus.value = NetworkStatus.SUCCESS;
      dynamic result =
          await graphQLCommonApi.query(getAllVisaAPplication.fetchData(), {});

      if (result != null) {
        icsVisaApplicationModel.value =
            (result['ics_visa_applications'] as List)
                .map((e) => IcsVisaApplicationModel.fromMap(e))
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

  late DateTime? selectedDate;
  late DateTime? selectedDateTime;
  var isUpdateSuccess = false.obs;
  Future<void> updateNewApplication() async {
    print(">>>>>>>>>>>>>>>>>> updateNewApplication");
    try {
      //file upload
      networkStatus.value = NetworkStatus.LOADING;
      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(UpdateAllVisa.update(visaApplicationId)),
        ),
      );

      if (result.hasException) {
        networkStatus.value = NetworkStatus.ERROR;
        isUpdateSuccess(false);
        print(result.exception.toString());
      } else {
        Get.delete<ALLVisaController>();

        networkStatus.value = NetworkStatus.SUCCESS;
        AppToasts.showSuccess("Visa Application successfully");
        MyOrderController myOrderController = Get.put(MyOrderController());

        myOrderController.getVisaApplication();

        Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
        Get.find<MainPageController>().changeBottomPage(1);
        myOrderController.tabController.index = 2;
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e.toString());
      isUpdateSuccess(false);
      print('Error: $e');
    }
  }

  var visaApplicationId;
  var visa_category_validity_type_id;
  RxList<String> photoPath = <String>[].obs;
  Future<void> send() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
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
          document: gql(AllVisaMutation.ics_citizens),
          variables: buildVariablesMap(formattedDateOfBirth),
        ),
      );

      handleMutationResult(result);
    } catch (e) {
      ;
      handleSendException(e);
    } finally {
      networkStatus.value = NetworkStatus.ERROR;
    }
  }

  List<DocPathModel> docList = [];
  Map<String, dynamic> buildVariablesMap(String formattedDateOfBirth) {
    return {
      'objects': {
        'given_name': givenNameController.text,
        'surname': surNameController.text,
        'gender': gendervalue.value!.name,
        'nationality_id': citizenship.value!.id,
        'birth_place': birthplace.text,
        'birth_country_id': birthCountryvalue.value!.id,
        'birth_date': formattedDateOfBirth,
        'email': emailAdress.text,
        'occupation_id': occupationvalue.value!.id,
        'street_address': addresscityController.text,
        'city': addresscityController.text,
        'phone_number': countryCode.toString() + phonenumber.text,
        'abroad_country_id': adresscountryvalue.value!.id,
        'arrival_date': arrivaldDateController.text,
        'departure_country_id': departurecountry.value!.id,
        'departure_city': departurecity.text,
        'airline': airline.text,
        'flight_number': flight_Number.text,
        'accommodation_type_id': accommodationtypevalue.value!.id,
        'accommodation_city': accommodation_city.text,
        'accommodation_name': accommodation_name.text,
        'accommodation_street_address': accommodation_street_address.text,
        'accommodation_telephone': accommodation_Telephone.text,
        'passport_number': passport_number.text,
        'passport_type_id': passporttypevalue.value!.id,
        'passport_issued_date': passportIssueDate.text,
        'passport_expiry_date': passportexpiryDate.text,
        'passport_issuing_country_id': passportIssueCountry.value!.id,
        'passport_issuing_authority': passportIssueAuthority.text,
        'visa_category_id': baseVisaTypeModel.id,
        'visa_category_validity_type_id': visa_category_validity_type_id,
        'company_reference_number': companyreference.text,
        'visa_application_documents': {
          "data": docList.map((e) => e.toJson()).toList()
        },
      }
    };
  }

  void handleMutationResult(QueryResult result) {
    if (result.hasException) {
      isSend.value = false;
      print("Error executing mutation: ${result.exception}");
    } else {
      print(result.data!);
      isSend.value = true;

      visaApplicationId = result.data!['insert_ics_visa_applications']
              ['returning'][0]['id']
          .toString();
      updateNewApplication();
    }
  }

  void handleSendException(dynamic e) {
    isSend.value = false;
    networkStatus.value = NetworkStatus.ERROR;
    print('Error sending data: $e');
    if (!e.toString().contains("Null")) {
      AppToasts.showError("An error occurred while sending data.");
    }
  }

  void increment() => count.value++;

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
          document: gql(DeleteVisaApplicationsDoc.deleteDoc(documentTypeId)),
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

  CheckreferenceNumber checkreferenceNumber = CheckreferenceNumber();

  RxList<IcsCompanies> icsCompanies = List<IcsCompanies>.of([]).obs;
  checkTheNumber() async {
    try {
      // File upload
      networkStatus.value = NetworkStatus.LOADING;

      dynamic result = await graphQLCommonApi.query(
        checkreferenceNumber.check(companyreference.text),
        {},
      );

      icsCompanies.value = (result!['ics_companies'] as List)
          .map((e) => IcsCompanies.fromJson(e))
          .toList();

      // Check if the ics_companies list within the result is empty
      if (icsCompanies.isEmpty) {
        networkStatus.value = NetworkStatus.ERROR;
        AppToasts.showError("Companies reference number not found");
      } else {
        Get.to(ProfileViewInvestmentvisa(
          icsCompanies: icsCompanies,
        ));
        networkStatus.value = NetworkStatus.SUCCESS;
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e.toString());
      isUpdateSuccess(false);
      print('Error: $e');
    }
  }
}

class AllVisaDocuments {
  final documentTypeId;

  final List<PlatformFile> files;

  const AllVisaDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
