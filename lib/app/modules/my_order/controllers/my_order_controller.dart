import 'package:get/get.dart';


import 'package:ics/app/common/data/graphql_common_api.dart';


import 'package:ics/app/modules/my_order/data/model/order_model_origin.dart';


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


  // void getNewPassport() async {


  //   try {


  //     // Set isFechtedOrder to true to indicate a loading state


  //     isFechtedOrder.value = true;


  //     Stream<dynamic> subscriptionStream = graphQLCommonApi


  //         .subscription(getanewPassportOrderQuery.fetchData(), {});


  //     subscriptionStream.listen(


  //       (event) {


  //         if (event.hasException) {


  //           print("Subscription error: ${event.exception}");


  //         } else if (event.isLoading) {


  //           // Handle loading state if needed


  //         } else if (event.data != null) {


  //           icsNewApplication.value =


  //               (event.data['ics_new_applications'] as List)


  //                   .map((e) => IcsNewApplicationModel.fromJson(e))


  //                   .toList();


  //         }


  //       },


  //       onError: (error) {


  //         isFechtedOrder.value = false;


  //         print("Subscription error: $error");


  //       },


  //       onDone: () {


  //         // Handle completion of the subscription stream if needed


  //       },


  //     );


  //   } catch (e) {


  //     isFechtedOrder.value = false;


  //     print(">>>>>>>>>>>>>>>>>> $e");


  //   }


  // }

}

