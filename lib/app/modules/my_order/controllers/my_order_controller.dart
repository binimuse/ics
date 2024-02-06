import 'package:get/get.dart';


import 'package:ics/app/common/data/graphql_common_api.dart';


import 'package:ics/app/modules/my_order/data/model/order_model.dart';


import 'package:ics/app/modules/my_order/data/quary/ics_new_passport_order.dart';


class MyOrderController extends GetxController {

  final count = 0.obs;


  @override

  void onInit() {

    GetNewPassport();


    super.onInit();

  }


  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();


  GetanewPassportOrder getanewPassportOrderQuery = GetanewPassportOrder();


  var icsNewApplication = RxList<IcsNewApplicationModel>();


  // Flag to indicate if the order has been fetched


  var isFechtedOrder = false.obs;


  void GetNewPassport() async {

    try {

      // Set isFechtedOrder to true to indicate a loading state


      isFechtedOrder.value = true;


      Stream<dynamic> subscriptionStream = graphQLCommonApi

          .subscription(getanewPassportOrderQuery.fetchData(), {});


      subscriptionStream.listen(

        (event) {

          if (event.hasException) {

            print("Subscription error: ${event.exception}");

          } else if (event.isLoading) {

            // Handle loading state if needed

          } else if (event.data != null) {

            icsNewApplication.value =

                (event.data['ics_new_applications'] as List)

                    .map((e) => IcsNewApplicationModel.fromJson(e))

                    .toList();

          }

        },

        onError: (error) {

          isFechtedOrder.value = false;


          print("Subscription error: $error");

        },

        onDone: () {

          // Handle completion of the subscription stream if needed

        },

      );

    } catch (e) {

      isFechtedOrder.value = false;


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

