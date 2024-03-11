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

  late TabController tabController;

  @override
  void onInit() {
    getOrginOrder();

    getVisaApplication();
    getComplaint();
    // getDoc();
    tabController = TabController(length: 5, vsync: this);

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
        print(result.exception.toString());
      } else {
        isSendDocSuccess(true);

        AppToasts.showSuccess("Document uploaded successfully");
        documents.clear();
        getOrginOrder();
        Get.back();
      }
    } catch (e) {
      isSendDocSuccess(false);
      print('Error: $e');
    }
  }
}
