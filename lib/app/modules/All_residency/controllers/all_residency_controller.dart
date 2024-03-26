import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/modules/All_residency/data/model/all_base_residency_model.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';
import 'package:ics/app/modules/All_residency/data/mutation/all_visa_mutuation.dart';
import 'package:ics/app/modules/All_residency/data/query/get_all_renew_orginid.dart';
import 'package:ics/app/modules/All_residency/data/query/ics_residency_application.dart';
import 'package:ics/app/modules/All_residency/views/widget/profile_view_residency.dart';
import 'package:ics/app/modules/all_visa/data/model/ics_companies.dart';
import 'package:ics/app/modules/all_visa/data/mutation/all_visa_mutuation.dart';
import 'package:ics/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';

import 'package:ics/app/modules/new_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_emabassies_orginid.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/model/fileurl.dart';
import 'package:ics/app/modules/residency/data/models/base_residency_model.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/services/graphql_conf.dart';

class AllResidencyController extends GetxController {
  final count = 0.obs;

  BaseResidencyTypeModel baseResidencyTypeModel = BaseResidencyTypeModel();
  final TextEditingController companyreference = TextEditingController();
//setp 1
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController emailAdress = TextEditingController();
  final Rxn<CommonModel> gendervalue = Rxn<CommonModel>();
  List<CommonModel> occupations = [];
  final Rxn<CommonModel> occupationvalue = Rxn<CommonModel>();

  //setp 2

  List<CommonModel> natinality = [];
  List<AllowedContreyModel> abrodCountry = [];
  final Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  final Rxn<AllowedContreyModel> abrodcountryvalue = Rxn<AllowedContreyModel>();
  final Rxn<AllowedContreyModel> adresscountryvalue =
      Rxn<AllowedContreyModel>();
  final TextEditingController localAddressController = TextEditingController();
  List<CommonModel> region = [];
  final Rxn<CommonModel> regionvalue = Rxn<CommonModel>();
  final TextEditingController woredaContoller = TextEditingController();
  final TextEditingController kebeleContoller = TextEditingController();
  //setp 3
  final TextEditingController passport_number = TextEditingController();
  final TextEditingController visa_number = TextEditingController();
  final TextEditingController visa_Refernce_number = TextEditingController();
  final TextEditingController passportIssueDate = TextEditingController();
  final TextEditingController passportexpiryDate = TextEditingController();

  final TextEditingController workvisaIssueDate = TextEditingController();

  //setp 4
  final Rxn<CommonModel> embassiesvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> countryvalue = Rxn<CommonModel>();
  final Rxn<CommonModel> currentcountryvalue = Rxn<CommonModel>();
  var isAgreedToTerms = false.obs;
  final residentformKey = GlobalKey<FormBuilderState>();
  int currentStep = 0;
  var countryCode = "+251";
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

  @override
  void onInit() {
    getAll();
    getCitizene();
    baseResidencyTypeModel = Get.arguments["ResidencyType"];

    super.onInit();
  }

  GetEmbassiesQueryOrginId getEmbassiesQuery = GetEmbassiesQueryOrginId();
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

  GetallQueryResidency getallQueryResidency = GetallQueryResidency();
  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  var isfechedEmbassies = false.obs;
  final Rxn<BaseResidencyModel> baseResidencyModel = Rxn<BaseResidencyModel>();
  Future<void> getAll() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getallQueryResidency.fetchData(), {});
      baseResidencyModel.value = BaseResidencyModel.fromMap(result);

      if (baseResidencyModel.value == null) {
        throw Exception("Base data is null");
      }

      mapBaseDataToLists();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print("Error occurred while fetching data: $e");
    }
  }

  List<CommonModel> gender = [];
  List<CommonModel> accommodationTypes = [];
  List<CommonModel> bcountries = [];
  List<CommonModel> regsions = [];

  List<AllowedContreyModel> allwoedCountries = [];
  void mapBaseDataToLists() {
    gender = baseResidencyModel.value!.baseGenders!;

    occupations = baseResidencyModel.value!.baseOccupations!;

    accommodationTypes = baseResidencyModel.value!.baseAccommodationTypes!;

    bcountries = baseResidencyModel.value!.baseCountries!;
    natinality = baseResidencyModel.value!.baseCountries!;
    allwoedCountries = baseResidencyModel.value!.baseAllowedCountries!;
    regsions = baseResidencyModel.value!.baseRegions!;
  }

  GetallQueryInvestemntResidency getallQueryInvestemntResidency =
      GetallQueryInvestemntResidency();
  List<AllResidencyDocuments> documents = [];
  final Rxn<BaseDocAllVisa> baseDocData = Rxn<BaseDocAllVisa>();
  List<CommonModel> base_document_types = [];
  Future<void> getDoctype(String type) async {
    try {
      dynamic result = await graphQLCommonApi
          .query(getallQueryInvestemntResidency.fetchData(type), {});

      baseDocData.value = BaseDocAllVisa.fromJson(result);

      base_document_types =
          baseDocData.value!.base_document_types.map((e) => e).toList();

      for (var documentType in base_document_types) {
        documents.add(
            AllResidencyDocuments(documentTypeId: documentType.id, files: []));
      }
    } catch (e, s) {
      print(e);

      print(s);
    }
  }

  GetAllresidencyplication getAllResidencyApplication =
      GetAllresidencyplication();

  RxList<IcsResidencyApplication> icsResidencyApplication =
      List<IcsResidencyApplication>.of([]).obs;
  void getCitizene() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      networkStatus.value = NetworkStatus.SUCCESS;
      dynamic result = await graphQLCommonApi
          .query(getAllResidencyApplication.fetchData(), {});

      if (result != null) {
        icsResidencyApplication.value =
            (result['ics_residency_applications'] as List)
                .map((e) => IcsResidencyApplication.fromJson(e))
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

  Future<List<NewOrginIdConfirmationModel>> fetchConfirmationModelCar() async {
    // simulate network delay

    // This is the dummy data
    List<Map<String, dynamic>> data = [
      {
        "name": "valid passport",
        "description": "You must have a valid passport from your home country.",
        "image": Assets.icons.paper,
      },
      {
        "name": "Visa ",
        "description": "You must have a valid visa to enter Ethiopia.",
        "image": Assets.icons.batteryLow,
      },
      {
        "name": "Age",
        "description": "You must be over the age of 18.",
        "image": Assets.icons.paper,
      },
      {
        "name": "Criminal record",
        "description": "You must have a clean criminal record",
        "image": Assets.icons.origin,
      },
      {
        "name": "finance",
        "description": "You must be able to support yourself financially.",
        "image": Assets.icons.batteryLow,
      },
    ];

    return data
        .map((item) => NewOrginIdConfirmationModel.fromJson(item))
        .toList();
  }

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  var isfechediCitizens = false.obs;

  RxList<IcsCompanies> icsCompanies = List<IcsCompanies>.of([]).obs;
  CheckreferenceNumber checkreferenceNumber = CheckreferenceNumber();
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
        Get.to(ProfileViewResidency(
          icsCompanies: icsCompanies,
        ));
        networkStatus.value = NetworkStatus.SUCCESS;
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e.toString());

      print('Error: $e');
    }
  }

  List<DocPathModel> docList = [];
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
              gql(DeleteResidancyApplicationsDoc.deleteDoc(documentTypeId)),
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

  var residencyApplicationId;
  RxList<String> photoPath = <String>[].obs;
  Future<void> send() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(AllResidancyMutation.ics_citizens),
          variables: buildVariablesMap(),
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

  Map<String, dynamic> buildVariablesMap() {
    return {
      'objects': {
        'first_name': firstName.text,
        'father_name': middleName.text,
        'grand_father_name': lastName.text,
        'gender': gendervalue.value!.name,
        'phone_number': countryCode.toString() + phonenumber.text,
        'email_address': emailAdress.text,
        'nationality_id': natinalityvalue.value!.id,
        'occupation_id': occupationvalue.value!.id,
        'abroad_country_id': abrodcountryvalue.value!.id,
        'local_address': localAddressController.text,
        'region_id': regionvalue.value!.id,
        'woreda': woredaContoller.text,
        'kebele': kebeleContoller.text,
        'zone_subcity': kebeleContoller.text,
        'passport_number': passport_number.text,
        'residency_type_id': baseResidencyTypeModel.id,
        'passport_expiry_date': passportexpiryDate.text,
        'passport_issued_date': passportIssueDate.text,
        'visa_number': visa_number.text,
        'visa_workpermit_issued_date': workvisaIssueDate.text,
        'embassy_id': embassiesvalue.value!.id,
        'visa_reference_no': companyreference.text,
        'residency_application_documents': {
          "data": docList.map((e) => e.toJson()).toList()
        },
      }
    };
  }

  void handleMutationResult(QueryResult result) {
    if (result.hasException) {
      print("Error executing mutation: ${result.exception}");
    } else {
      print(result.data!);

      residencyApplicationId = result.data!['insert_ics_residency_applications']
              ['returning'][0]['id']
          .toString();
      updateNewApplication();
    }
  }

  void handleSendException(dynamic e) {
    networkStatus.value = NetworkStatus.ERROR;
    print('Error sending data: $e');
    if (!e.toString().contains("Null")) {
      AppToasts.showError("An error occurred while sending data.");
    }
  }

  Future<void> updateNewApplication() async {
    print(">>>>>>>>>>>>>>>>>> updateNewApplication");
    try {
      //file upload
      networkStatus.value = NetworkStatus.LOADING;
      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(UpdateAllResidency.update(residencyApplicationId)),
        ),
      );

      if (result.hasException) {
        networkStatus.value = NetworkStatus.ERROR;

        print(result.exception.toString());
      } else {
        Get.delete<AllResidencyController>();

        networkStatus.value = NetworkStatus.SUCCESS;
        AppToasts.showSuccess("Residency Application successfully");
        MyOrderController myOrderController = Get.put(MyOrderController());

        myOrderController.getVisaApplication();

        Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
        Get.find<MainPageController>().changeBottomPage(1);
        myOrderController.tabController.index = 3;
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e.toString());
      print(s.toString());

      print('Error: $e');
    }
  }
}

class AllResidencyDocuments {
  final documentTypeId;

  final List<PlatformFile> files;

  const AllResidencyDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
