import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';

import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';

import 'package:ics/app/modules/my_order/data/quary/ics_new_passport_order.dart';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
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

  GetOrginOrder getOrginOrders = GetOrginOrder();

  var isfechedorder = false.obs;

  void getOrginOrder() async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getOrginOrders.fetchData(), {});

      if (result != null) {
        originIdApplication.value =
            (result['ics_all_origin_id_applications'] as List)
                .map((e) => IcsAllOriginIdApplication.fromMap(e))
                .toList();

        passportApplication.value =
            (result['ics_all_passport_applications'] as List)
                .map((e) => IcsAllPassportApplication.fromMap(e))
                .toList();

        // countLabours.value = getlabour.value.length;
      }

      isfechedorder(true);
    } catch (e, s) {
      isfechedorder(false);

      print(">>>>>>>>>>>>>>>>>> $e");

      print(">>>>>>>>>>>>>>>>>> $s");
    }
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
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
