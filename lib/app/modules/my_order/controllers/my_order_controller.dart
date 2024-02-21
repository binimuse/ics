import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';

import 'package:ics/app/modules/my_order/data/quary/ics_new_passport_order.dart';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/modules/new_passport/data/mutation/ics_citizens_mutuation.dart';
import 'package:ics/services/graphql_conf.dart';

class MyOrderController extends GetxController
    with SingleGetTickerProviderMixin {
  final count = 0.obs;

  late TabController tabController;

  @override
  void onInit() {
    getOrginOrder();

    tabController = TabController(length: 6, vsync: this);

    super.onInit();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  RxList<IcsAllOriginIdApplication> originIdApplication =
      List<IcsAllOriginIdApplication>.of([]).obs;

  RxList<IcsAllPassportApplication> passportApplication =
      List<IcsAllPassportApplication>.of([]).obs;

  RxList<GroupedAppliaction> groupedAppliaction =
      List<GroupedAppliaction>.of([]).obs;

  GetOrginOrder getOrginOrders = GetOrginOrder();

  var isfechedorder = false.obs;
  List<CommonModel> base_document_types = [];
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  void getOrginOrder() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getOrginOrders.fetchData(), {});

      originIdApplication.clear();
      passportApplication.clear();

      if (result != null) {
        originIdApplication.value =
            (result['ics_all_origin_id_applications'] as List)
                .map((e) => IcsAllOriginIdApplication.fromMap(e))
                .toList();

        passportApplication.value =
            (result['ics_all_passport_applications'] as List)
                .map((e) => IcsAllPassportApplication.fromMap(e))
                .toList();

        groupDocumnats();
        networkStatus.value = NetworkStatus.SUCCESS;
      }

      isfechedorder(true);
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      isfechedorder(false);

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
  }

  List<CurrentCountry> documentspassport = [];
  groupDocumnats() {
    groupedAppliaction.clear();
    passportApplication.forEach((element) {
      element.newApplication!.newApplicationDocuments.forEach((element) {
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
              'new_application_id': newApplicationId,
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
        getOrginOrder();
        update();
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
