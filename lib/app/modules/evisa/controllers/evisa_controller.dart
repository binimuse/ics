import 'package:get/get.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';

import 'package:ics/app/modules/evisa/data/models/base_visatype_model.dart';

import 'package:ics/app/modules/evisa/data/quary/get_visa_type.dart';

class EvisaController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    getVisatype();

    super.onInit();
  }

  var startGettype = false.obs;

  var hasgettype = false.obs;

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  GetVisaTypeQuery getVisaTypeQuery = GetVisaTypeQuery();

  RxList<BaseVisaTypeModel> baseVisaTypeModel =
      List<BaseVisaTypeModel>.of([]).obs;

  void getVisatype() async {
    startGettype(true);

    dynamic result =
        await graphQLCommonApi.query(getVisaTypeQuery.fetchData(), {});

    startGettype(false);

    if (result != null) {
      baseVisaTypeModel.value = (result['base_visa_categories'] as List)
          .map((e) => BaseVisaTypeModel.fromJson(e))
          .toList();

      hasgettype(true);
    } else {
      hasgettype(false);

      startGettype(false);
    }

    try {} catch (e) {
      print(e);

      hasgettype(false);

      startGettype(false);
    }
  }
}
