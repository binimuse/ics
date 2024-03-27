import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/my_order/data/model/doc_type_model.dart';
import 'package:ics/app/modules/my_order/data/model/grouped_application.dart';
import 'package:ics/app/modules/my_order/data/model/ics_complaint_model.dart';
import 'package:ics/app/modules/my_order/data/model/ics_visa_application.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_all_appllication.dart';
import 'package:ics/app/modules/my_order/data/model/residency_appliaction_model.dart';
import 'package:ics/app/modules/my_order/data/mutation/update_rating.dart';
import 'package:ics/app/modules/my_order/data/quary/get_all_residency.dart';
import 'package:ics/app/modules/my_order/data/quary/ics_complaint.dart';

import 'package:ics/app/modules/my_order/data/quary/ics_new_passport_order.dart';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ics/app/modules/my_order/data/quary/ics_visa_order.dart';
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/base_model_orgin.dart';

import 'package:ics/app/modules/new_passport/data/mutation/ics_citizens_mutuation.dart';
import 'package:ics/services/graphql_conf.dart';

import '../data/quary/get_doc_type.dart';

class MyOrderController extends GetxController
    with SingleGetTickerProviderMixin {
  final count = 0.obs;
  var selectedRating = 0.obs;
  late TabController tabController;
  late TabController tabControllerorgin;
  late TabController tabControllervisa;
  late TabController tabControllerPassport;
  final TextEditingController complaint = TextEditingController();
  @override
  void onInit() {
    getOrginOrder();

    getVisaApplication();
    getComplaint();
    getResidencyApplication();
    // getDoc();
    tabController = TabController(length: 5, vsync: this);
    tabControllerorgin = TabController(length: 3, vsync: this);
    tabControllervisa = TabController(length: 3, vsync: this);
    tabControllerPassport = TabController(length: 3, vsync: this);

    super.onInit();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  RxList<IcsApplication> allApplicationModel = List<IcsApplication>.of([]).obs;
  RxList<IcsVisaApplication> allVisaApplicationModel =
      List<IcsVisaApplication>.of([]).obs;

  GetOrginOrder getOrginOrders = GetOrginOrder();
  GetVisaOrder getVisaOrder = GetVisaOrder();

  var isfechedorder = false.obs;

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  getOrginOrder() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getOrginOrders.fetchData(), {});

      if (result != null) {
        allApplicationModel.clear();
        allApplicationModel.value = (result['ics_applications'] as List)
            .map((e) => IcsApplication.fromMap(e))
            .toList();

        networkStatus.value = NetworkStatus.SUCCESS;

        isfechedorder.value = true;
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechedorder.value = false;

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
  }

  RxList<IcsServiceComplaintModel> icsServiceComplaintModel =
      List<IcsServiceComplaintModel>.of([]).obs;
  GetIcsComplaint getIcsComplaint = GetIcsComplaint();
  getComplaint() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getIcsComplaint.fetchData(), {});

      if (result != null) {
        icsServiceComplaintModel.clear();
        icsServiceComplaintModel.value =
            (result['ics_service_complaints'] as List)
                .map((e) => IcsServiceComplaintModel.fromJson(e))
                .toList();

        networkStatus.value = NetworkStatus.SUCCESS;

        isfechedorder.value = true;
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechedorder.value = false;

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
  }

  RxList<ResidencyModel> residencyModel = List<ResidencyModel>.of([]).obs;
  GetResidencyQuery getResidencyQuery = GetResidencyQuery();
  getResidencyApplication() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getResidencyQuery.fetchData(), {});

      if (result != null) {
        residencyModel.clear();
        residencyModel.value = (result['ics_residency_applications'] as List)
            .map((e) => ResidencyModel.fromJson(e))
            .toList();

        networkStatus.value = NetworkStatus.SUCCESS;

        isfechedorder.value = true;
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechedorder.value = false;

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
  }

  getVisaApplication() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getVisaOrder.fetchData(), {});

      if (result != null) {
        allVisaApplicationModel.clear();
        allVisaApplicationModel.value =
            (result['ics_visa_applications'] as List)
                .map((e) => IcsVisaApplication.fromJson(e))
                .toList();

        networkStatus.value = NetworkStatus.SUCCESS;

        isfechedorder.value = true;
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechedorder.value = false;

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
  }

  GetDocType getDocType = GetDocType();
  List<CommonModel> base_document_types = [];
  List<OrginIDDocuments> documents = [];
  final Rxn<BaseDocModel> baseData = Rxn<BaseDocModel>();
  Future<void> getDoc() async {
    try {
      dynamic result = await graphQLCommonApi.query(getDocType.fetchData(), {});

      baseData.value = BaseDocModel.fromJson(result);

      base_document_types =
          baseData.value!.base_document_types.map((e) => e).toList();

      for (var documentType in base_document_types) {
        documents
            .add(OrginIDDocuments(documentTypeId: documentType.id, files: []));
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  RxList<GroupedAppliaction> groupedAppliaction =
      List<GroupedAppliaction>.of([]).obs;

  List<CurrentCountry> documentspassport = [];
  groupDocumnats(String applicationid) {
    groupedAppliaction.clear();

    allApplicationModel.forEach((element) {
      if (element.id == applicationid) {
        element.applicationDocuments.forEach((element) {
          final docTypeID = element.documentType.id;
          int existingIndex = groupedAppliaction
              .indexWhere((group) => group.documentType.id == docTypeID);

          if (existingIndex != -1) {
            // If an existing OrderGroup is found, add the order to its list of orders
            groupedAppliaction[existingIndex].document.add(element);
          } else {
            // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
            GroupedAppliaction newGroup = GroupedAppliaction(
              documentType: element.documentType,
              document: [element],
            );

            groupedAppliaction.add(newGroup);
          }
        });
      }
    });
  }

  RxList<GroupedAppliactionResidency> groupedAppliactionResidency =
      List<GroupedAppliactionResidency>.of([]).obs;

  groupDocumnatsForResidency(String applicationid) {
    groupedAppliactionResidency.clear();

    residencyModel.forEach((element) {
      if (element.id == applicationid) {
        element.residencyApplicationDocuments.forEach((element) {
          final docTypeID = element.documentType.id;
          int existingIndex = groupedAppliactionResidency
              .indexWhere((group) => group.documentType.id == docTypeID);

          if (existingIndex != -1) {
            // If an existing OrderGroup is found, add the order to its list of orders
            groupedAppliactionResidency[existingIndex].document.add(element);
          } else {
            // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
            GroupedAppliactionResidency newGroup = GroupedAppliactionResidency(
              documentType: element.documentType,
              document: [element],
            );

            groupedAppliactionResidency.add(newGroup);
          }
        });
      }
    });
  }

  RxList<GroupedAppliactionVisa> groupedAppliactionvisa =
      List<GroupedAppliactionVisa>.of([]).obs;

  groupDocumnatsForVisa(String applicationid) {
    groupedAppliactionvisa.clear();

    allVisaApplicationModel.forEach((element) {
      if (element.id == applicationid) {
        element.visaApplicationDocuments.forEach((element) {
          final docTypeID = element.documentType.id;
          int existingIndex = groupedAppliactionvisa
              .indexWhere((group) => group.documentType.id == docTypeID);

          if (existingIndex != -1) {
            // If an existing OrderGroup is found, add the order to its list of orders
            groupedAppliactionvisa[existingIndex].document.add(element);
          } else {
            // If no existing OrderGroup is found, create a new OrderGroup and add it to the list
            GroupedAppliactionVisa newGroup = GroupedAppliactionVisa(
              documentType: element.documentType,
              document: [element],
            );

            groupedAppliactionvisa.add(newGroup);
          }
        });
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  //reupload

  var isSendStared = false.obs;
  var isSendDocSuccess = false.obs;
  var newDocId;
  Future<void> sendDoc(
    var documentTypeId,
    var path,
    var newApplicationId,
    bool isVisa,
  ) async {
    try {
      // file upload

      if (isVisa == false) {
        forpassportAndOrgin(documentTypeId, path, newApplicationId);
      } else {
        forVisa(documentTypeId, path, newApplicationId);
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      isSendDocSuccess(false);
      print('Error: $e');
    }
  }

  Future<void> rateComplaint(
      String id, int rating, BuildContext context) async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      //file upload

      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(Updaterating.update(id, rating)),
        ),
      );
      selectedRating.value = 0;
      if (result.hasException) {
        networkStatus.value = NetworkStatus.ERROR;
        print(result.exception.toString());
      } else {
        Navigator.pop(context); // Return false if cancel is pressed
        networkStatus.value = NetworkStatus.SUCCESS;
        AppToasts.showSuccess("Rated successfully");
        MyOrderController myOrderController = Get.put(MyOrderController());

        myOrderController.getComplaint();
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e.toString());

      print('Error: $e');
    }
  }

  void forpassportAndOrgin(documentTypeId, path, newApplicationId) async {
    GraphQLClient graphQLClient;

    graphQLClient = GraphQLConfiguration().clientToQuery();

    final QueryResult result = await graphQLClient.mutate(
      MutationOptions(
        document: gql(NewDocApplications.newDoc),
        variables: <String, dynamic>{
          'objects': {
            'application_id': newApplicationId,
            'files': {
              'path': path,
            },
            'document_type_id': documentTypeId,
          }
        },
      ),
    );

    if (result.hasException) {
      networkStatus.value = NetworkStatus.ERROR;
      print(result.exception.toString());
    } else {
      networkStatus.value = NetworkStatus.SUCCESS;
      isSendDocSuccess(true);

      AppToasts.showSuccess("Document uploaded successfully");

      documents.clear();

      Get.back();

      getOrginOrder();
    }
  }

  void forVisa(documentTypeId, path, newApplicationId) async {
    GraphQLClient graphQLClient;

    graphQLClient = GraphQLConfiguration().clientToQuery();

    final QueryResult result = await graphQLClient.mutate(
      MutationOptions(
        document: gql(NewDocApplicationsVisa.newDoc),
        variables: <String, dynamic>{
          'objects': {
            'visa_application_id': newApplicationId,
            'files': {
              'path': path,
            },
            'document_type_id': documentTypeId,
          }
        },
      ),
    );

    if (result.hasException) {
      networkStatus.value = NetworkStatus.ERROR;
      print(result.exception.toString());
    } else {
      networkStatus.value = NetworkStatus.SUCCESS;
      isSendDocSuccess(true);

      AppToasts.showSuccess("Document uploaded successfully");

      documents.clear();

      Get.back();
      // groupDocumnats(newApplicationId);

      getVisaApplication();
    }
  }
}
