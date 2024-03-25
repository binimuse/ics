import 'package:get/get.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/residency/data/models/base_residency_model.dart';
import 'package:ics/app/modules/residency/data/quary/get_residency_type.dart';

class ResidencyController extends GetxController {
  @override
  void onInit() {
    getResidencyType();

    super.onInit();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  GetResidencyTypeQuery getResidencyTypeQuery = GetResidencyTypeQuery();

  RxList<BaseResidencyTypeModel> baseResidencyTypeModel =
      List<BaseResidencyTypeModel>.of([]).obs;
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  void getResidencyType() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      dynamic result =
          await graphQLCommonApi.query(getResidencyTypeQuery.fetchData(), {});

      if (result != null) {
        baseResidencyTypeModel.value = (result['base_residency_types'] as List)
            .map((e) => BaseResidencyTypeModel.fromJson(e))
            .toList();

        networkStatus.value = NetworkStatus.SUCCESS;
      } else {
        networkStatus.value = NetworkStatus.ERROR;
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      print(e);
    }
  }
}
