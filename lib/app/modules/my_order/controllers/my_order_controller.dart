import 'package:get/get.dart';


import 'package:ics/app/common/data/graphql_common_api.dart';


import 'package:ics/app/modules/my_order/data/model/order_model.dart';


import 'package:ics/app/modules/my_order/data/model/order_model_pasport.dart';


import 'package:ics/app/modules/my_order/data/quary/ics_new_passport_order.dart';


// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';


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


  RxList<IcsAllPassportIdApplication> passportApplication =

      List<IcsAllPassportIdApplication>.of([]).obs;


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

                .map((e) => IcsAllPassportIdApplication.fromMap(e))

                .toList();


        // countLabours.value = getlabour.value.length;

      }


      isfechedorder(true);

    } catch (e) {

      isfechedorder(false);


      print(">>>>>>>>>>>>>>>>>> $e");

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

}

