import 'package:get/get.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/investment_visa/data/query/get_all_renew_orginid.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';

// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/booked_date_model.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_booked_date.dart';
import 'package:ics/app/modules/new_passport/data/quary/get_url.dart';
import 'package:ics/app/modules/new_passport/data/quary/ics_citizens.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

class InvestmentVisaController extends GetxController {
//terms
  final TextEditingController companyreference = TextEditingController();

  //setp 1
  final TextEditingController givenNameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();
  List<CommonModel> gender = [];
  final Rxn<CommonModel> citizenship = Rxn<CommonModel>();
  final Rxn<CommonModel> birthCountryvalue = Rxn<CommonModel>();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController birthplace = TextEditingController();
  final TextEditingController emailAdress = TextEditingController();
  List<CommonModel> occupations = [];
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

  final Rxn<AllowedContreyModel> accommodationtype = Rxn<AllowedContreyModel>();
  final TextEditingController accommodation_name = TextEditingController();
  final TextEditingController accommodation_city = TextEditingController();
  final TextEditingController accommodation_street_address =
      TextEditingController();
  final TextEditingController accommodation_Telephone = TextEditingController();
  //step 5
  final Rxn<AllowedContreyModel> passporttype = Rxn<AllowedContreyModel>();
  final TextEditingController passport_number = TextEditingController();
  final TextEditingController passportIssueDate = TextEditingController();
  final TextEditingController passportexpiryDate = TextEditingController();
  final Rxn<AllowedContreyModel> passportIssueCountry =
      Rxn<AllowedContreyModel>();
  final TextEditingController passportIssueAuthority = TextEditingController();

  var isAgreedToTerms = false.obs;

  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;

  final Rxn<Basemodel> baseData = Rxn<Basemodel>();
  final Rxn<BookedDate> bookedDate = Rxn<BookedDate>();

  List<AllowedContreyModel> allwoedCountries = [];
  List<CommonModel> base_document_types = [];
  List<PassportDocuments> documents = [];

  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();

  final TextEditingController countryController = TextEditingController();

  int currentStep = 0;
  final TextEditingController dateofbirth = TextEditingController();

  final Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();

  GetallQueryInvestemntVisa getallQueryInvestemntVisa =
      GetallQueryInvestemntVisa();
  GetBookedDate getBookedDate = GetBookedDate();
  GetUrlQuery geturlQuery = GetUrlQuery();
  Getaicscitizens getaicscitizens = Getaicscitizens();

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  final Rxn<CommonModel> haircolorvalue = Rxn<CommonModel>();
  var isSend = false.obs;
  var isSendStared = false.obs;
  //Step 2

  var isfeched = false.obs;

  var showAdoption = false.obs;

  final Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();

  List<CommonModel> martial = [];

  List<CommonModel> familytype = [];
  List<CommonModel> bcountries = [];
  List<CommonModel> natinality = [];
  List<CommonModel> haircolor = [];
  List<CommonModel> eyecolor = [];

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
  final List<String> investmentType = [
    'Single entry 30 days',
    'Multiple entry 90 days',
    'Multiple entry 6 months',
    'Multiple entry 1 year',
  ];

  final count = 0.obs;

  var setFetchedStatus = false.obs;
  var isfechediCitizens = false.obs;
  RxList<IcsApplicationModel> icsApplicationModel =
      List<IcsApplicationModel>.of([]).obs;
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  @override
  void onInit() {
    getAll();
    getCitizene();

    super.onInit();
  }

  var isfechedEmbassies = false.obs;

  Future<void> getAll() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result = await graphQLCommonApi
          .query(getallQueryInvestemntVisa.fetchData(), {});
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

  void getCitizene() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      networkStatus.value = NetworkStatus.SUCCESS;
      dynamic result =
          await graphQLCommonApi.query(getaicscitizens.fetchData(), {});

      if (result != null) {
        icsApplicationModel.value = (result['ics_applications'] as List)
            .map((e) => IcsApplicationModel.fromJson(e))
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
    // try {
    //   //file upload

    //   GraphQLClient graphQLClient;

    //   graphQLClient = GraphQLConfiguration().clientToQuery();

    //   final QueryResult result = await graphQLClient.mutate(
    //     MutationOptions(
    //       document: gql(UpdateNewApplication.update(newApplicationId)),
    //     ),
    //   );

    //   if (result.hasException) {
    //     isUpdateSuccess(false);
    //     print(result.exception.toString());
    //   } else {
    //     isUpdateSuccess(true);
    //   }
    // } catch (e) {
    //   print(e.toString());
    //   isUpdateSuccess(false);
    //   print('Error: $e');
    // }
  }

  Future<void> sendBookedDates(BuildContext context) async {
    networkStatus.value = NetworkStatus.LOADING;
    // try {
    //   GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();
    //   // Remove the time component from the selectedDate
    //   // Convert selectedDate to a date string without the time component
    //   String dateString = selectedDate!.toIso8601String().split('T').first;

    //   print(dateString);

    //   print(newApplicationId);

    //   String timetz = DateFormat("HH:mm:ss").format(selectedDateTime!);

    //   print(timetz);

    //   final QueryResult result = await graphQLClient.mutate(
    //     MutationOptions(
    //       document: gql(NewAppointments.newApp),
    //       variables: <String, dynamic>{
    //         "objects": {
    //           "date": dateString,
    //           "application_id": newApplicationId,
    //           "start_time": timetz,
    //         }
    //       },
    //     ),
    //   );

    //   if (!result.hasException) {
    //     networkStatus.value = NetworkStatus.SUCCESS;
    //     AppToasts.showSuccess("New Passport Sent successfully");

    //     Get.offAllNamed(Routes.MAIN_PAGE);
    //   } else {
    //     networkStatus.value = NetworkStatus.ERROR;
    //     AppToasts.showError("Something went wrong");
    //     print(result);
    //   }
    // } catch (e, s) {
    //   AppToasts.showError("Something went wrong");
    //   print(e);
    //   print(s);
    //   networkStatus.value = NetworkStatus.ERROR;
    // }
  }

  RxList<String> photoPath = <String>[].obs;
  Future<void> send() async {
    // try {
    //   isSendStared.value = true;
    //   DateTime dateOfBirth = DateTime(
    //     int.parse(yearController.text),
    //     int.parse(monthController.text),
    //     int.parse(dayController.text),
    //   );
    //   String formattedDateOfBirth =
    //       DateFormat('yyyy-MM-dd').format(dateOfBirth);
    //   GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();

    //   final QueryResult result = await graphQLClient.mutate(
    //     MutationOptions(
    //       document: gql(IcscitizensMutation.ics_citizens),
    //       variables: buildVariablesMap(formattedDateOfBirth),
    //     ),
    //   );

    //   handleMutationResult(result);
    // } catch (e) {
    //   handleSendException(e);
    // } finally {
    //   isSendStared.value = false;
    // }
  }
  List<DateTime> occupiedDates = [
    // Add more dates...
  ];
  Future<void> getBookedDates(String embasiyId) async {
    print(embasiyId);
    //  networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getBookedDate.fetchData(embasiyId), {});
      bookedDate.value = BookedDate.fromMap(result);

      setFetchedStatus(true);
      //   networkStatus.value = NetworkStatus.SUCCESS;

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
      print("Error occurred while fetching data: $s");
      setFetchedStatus(false);
    }
  }

  void increment() => count.value++;

  var isDeleteDocSuccess = false.obs;
  Future<void> deleteDoc(
    var documentTypeId,
  ) async {
    // try {
    //   //file upload

    //   GraphQLClient graphQLClient;

    //   graphQLClient = GraphQLConfiguration().clientToQuery();

    //   final QueryResult result = await graphQLClient.mutate(
    //     MutationOptions(
    //       document: gql(DeleteDocApplications.deleteDoc(documentTypeId)),
    //     ),
    //   );

    //   if (result.hasException) {
    //     isDeleteDocSuccess(false);
    //     print(result.exception.toString());
    //   } else {
    //     isDeleteDocSuccess(true);

    //     AppToasts.showSuccess("Documnet Deleted successfully");
    //   }
    // } catch (e) {
    //   print(e.toString());
    //   isDeleteDocSuccess(false);
    //   print('Error: $e');
    // }
  }

  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    var documentTypeId,
    var path,
  ) async {
    // try {
    //   isSendStared.value = true;
    //   // file upload

    //   GraphQLClient graphQLClient;

    //   graphQLClient = GraphQLConfiguration().clientToQuery();

    //   final QueryResult result = await graphQLClient.mutate(
    //     MutationOptions(
    //       document: gql(NewDocApplications.newDoc),
    //       variables: <String, dynamic>{
    //         'objects': {
    //           'application_id': newApplicationId,
    //           'files': {
    //             'path': path,
    //           },
    //           'document_type_id': documentTypeId,
    //         }
    //       },
    //     ),
    //   );

    //   if (result.hasException) {
    //     isSendStared.value = false;

    //     print(result.exception.toString());
    //   } else {
    //     isSendDocSuccess(true);
    //     isSendStared.value = false;

    //     AppToasts.showSuccess("Document uploaded successfully");
    //   }
    // } catch (e) {
    //   isSendStared.value = false;
    //   print('Error: $e');
    // }
  }
}
