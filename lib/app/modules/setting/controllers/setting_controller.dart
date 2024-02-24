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

  late BaseSiteConfiguration configurationClassModel = BaseSiteConfiguration();
  var startTermPage = false.obs;
  var hasGetTermFetched = false.obs;
  void getConfigration() async {
    try {
      final result = await graphQLCommonApi
          .query(ConfigurationQuery.getconfiguration(), {});
      startTermPage(false);
      print(result);
      if (result != null) {
        configurationClassModel =
            BaseSiteConfiguration.fromMap(result["base_site_configurations"]);

        hasGetTermFetched(true);

        print("base_site_configurations");
      } else {
        print(result);
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
