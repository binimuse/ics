import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/modules/All_residency/data/model/all_base_residency_model.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';
import 'package:ics/app/modules/All_residency/data/query/get_all_renew_orginid.dart';
import 'package:ics/app/modules/All_residency/data/query/ics_residency_application.dart';
import 'package:ics/app/modules/All_residency/views/widget/profile_view_residency.dart';
import 'package:ics/app/modules/all_visa/data/model/ics_companies.dart';
import 'package:ics/app/modules/all_visa/data/mutation/all_visa_mutuation.dart';

import 'package:ics/app/modules/new_origin_id/data/model/confirmation_model_orginid.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/residency/data/models/base_residency_model.dart';
import 'package:ics/gen/assets.gen.dart';

class AllResidencyController extends GetxController {
  final count = 0.obs;

  BaseResidencyTypeModel baseResidencyTypeModel = BaseResidencyTypeModel();
  final TextEditingController companyreference = TextEditingController();
  var isAgreedToTerms = false.obs;
  @override
  void onInit() {
    getAll();
    getCitizene();
    baseResidencyTypeModel = Get.arguments["ResidencyType"];

    super.onInit();
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

  List<CommonModel> occupations = [];
  List<CommonModel> gender = [];
  List<CommonModel> accommodationTypes = [];
  List<CommonModel> bcountries = [];
  List<CommonModel> natinality = [];
  List<AllowedContreyModel> allwoedCountries = [];
  void mapBaseDataToLists() {
    gender = baseResidencyModel.value!.baseGenders!;

    occupations = baseResidencyModel.value!.baseOccupations!;

    accommodationTypes = baseResidencyModel.value!.baseAccommodationTypes!;

    bcountries = baseResidencyModel.value!.baseCountries!;
    natinality = baseResidencyModel.value!.baseCountries!;
    allwoedCountries = baseResidencyModel.value!.baseAllowedCountries!;
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
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
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
}

class AllResidencyDocuments {
  final documentTypeId;

  final List<PlatformFile> files;

  const AllResidencyDocuments({
    required this.documentTypeId,
    required this.files,
  });
}
