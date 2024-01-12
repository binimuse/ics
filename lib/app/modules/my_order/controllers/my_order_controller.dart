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
  RxList<IcsNewApplicationModel> icsNewApplication =
      List<IcsNewApplicationModel>.of([]).obs;
  GetanewPassportOrder getanewPassportOrderQuery = GetanewPassportOrder();
  var isfechedorder = false.obs;
  void GetNewPassport() async {
    try {
      dynamic result = await graphQLCommonApi
          .query(getanewPassportOrderQuery.fetchData(), {});

      if (result != null) {
        icsNewApplication.value = (result['ics_new_applications'] as List)
            .map((e) => IcsNewApplicationModel.fromJson(e))
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
