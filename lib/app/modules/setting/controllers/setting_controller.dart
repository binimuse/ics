import 'package:get/get.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/modules/setting/data/model/configartionmodel.dart';
import 'package:ics/app/modules/setting/data/quary/configartion_quary.dart';

class SettingController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    getConfigration();
    super.onInit();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  RxList<BaseSiteConfiguration> configurationClassModel =
      List<BaseSiteConfiguration>.of([]).obs;

  var startTermPage = false.obs;
  var hasGetTermFetched = false.obs;
  void getConfigration() async {
    try {
      final result = await graphQLCommonApi
          .query(ConfigurationQuery.getconfiguration(), {});
      startTermPage(false);

      if (result != null) {
        configurationClassModel.value =
            (result['base_site_configurations'] as List)
                .map((e) => BaseSiteConfiguration.fromMap(e))
                .toList();

        hasGetTermFetched(true);
      } else {
        //print(result);
      }
    } catch (e, s) {
      print(s);
      hasGetTermFetched(false);
      startTermPage(false);
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
