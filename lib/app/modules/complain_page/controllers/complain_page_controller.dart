import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/data/graphql_common_api.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/complain_page/data/model/base_complaint_services.dart';
import 'package:ics/app/modules/complain_page/data/mutation/comlinat_mutuation.dart';

import 'package:ics/app/modules/complain_page/data/quary/get_com_services.dart';
import 'package:ics/app/modules/main_page/controllers/main_page_controller.dart';
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/quary/get_emabassies_orginid.dart';
import 'package:ics/app/modules/new_passport/data/model/basemodel.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/services/graphql_conf.dart';

class ComplainPageController extends GetxController {
  final TextEditingController complaint = TextEditingController();
  var rating;
  List<DocPathModel> documents = [];

  @override
  void onInit() {
    getCompliantServices();
    getBaseCountries();

    super.onInit();
  }

  var startGettype = false.obs;

  var hasgettype = false.obs;
  var hasbaseCountry = false.obs;

  GetCompliantService getCompliantService = GetCompliantService();
  BaseCountries baseCountriesquery = BaseCountries();

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  RxList<BaseComplaintService> baseComplaintService =
      List<BaseComplaintService>.of([]).obs;

  RxList<BaseCountryModel> baseCountries = List<BaseCountryModel>.of([]).obs;

  void getCompliantServices() async {
    startGettype(true);

    dynamic result =
        await graphQLCommonApi.query(getCompliantService.fetchData(), {});

    startGettype(false);

    if (result != null) {
      baseComplaintService.value = (result['base_complaint_services'] as List)
          .map((e) => BaseComplaintService.fromJson(e))
          .toList();

      hasgettype(true);
    } else {
      hasgettype(false);

      startGettype(false);
    }
  }

  final Rxn<CommonModel> embassiesvalue = Rxn<CommonModel>();
  var isfechedEmbassies = false.obs;
  GetEmbassiesQueryOrginId getEmbassiesQuery = GetEmbassiesQueryOrginId();
  List<CommonModel> base_embassies = [];
  void getEmbassies(String id) async {
    try {
      dynamic result =
          await graphQLCommonApi.query(getEmbassiesQuery.fetchData(id), {});

      if (result != null) {
        base_embassies = (result['base_embassies'] as List)
            .map((e) => CommonModel.fromJson(e))
            .toList();

        if (base_embassies.isNotEmpty) {
          isfechedEmbassies.value = true;
        } else {
          isfechedEmbassies.value = false;
        }

        // countLabours.value = getlabour.value.length;
      }
    } catch (e) {
      isfechedEmbassies.value = false;
      print(">>>>>>>>>>>>>>>>>> getEmbassies $e");
    }
  }

  final Rxn<BaseCountryModel> baseCountriesvalue = Rxn<BaseCountryModel>();
  void getBaseCountries() async {
    dynamic result =
        await graphQLCommonApi.query(baseCountriesquery.fetchData(), {});

    if (result != null) {
      baseCountries.value = (result['base_countries'] as List)
          .map((e) => BaseCountryModel.fromJson(e))
          .toList();

      hasbaseCountry(true);
    } else {
      hasbaseCountry(false);
    }
  }

  List<String> icons = [
    'assets/icons/passport.svg',
    'assets/icons/profile_default.svg',
    'assets/icons/paper.svg',
    'assets/icons/memo.svg',
    'assets/icons/question.svg',
  ];

  final List<Color> color = [
    AppColors.success,
    AppColors.warning,
    AppColors.accent,
    AppColors.secondary,
    AppColors.primaryDark,
  ];

  final Rxn<ComplaintType> complaintTypevalue = Rxn<ComplaintType>();
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  Future<void> send() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();

      final QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(ComliantMutation.ics_citizens),
          variables: buildVariablesMap(),
        ),
      );

      handleMutationResult(result);
    } catch (e) {
      handleSendException(e);
    } finally {
      networkStatus.value = NetworkStatus.ERROR;
    }
  }

  Map<String, dynamic> buildVariablesMap() {
    return {
      'objects': {
        'complaint_type_id': complaintTypevalue.value!.id,
        'message': complaint.text,
        'rating': 0,
        'embassy_id': embassiesvalue.value!.id,
        'files': documents.map((e) => e.toJson()).toList(),
      }
    };
  }

  void handleMutationResult(QueryResult result) {
    if (result.hasException) {
      networkStatus.value = NetworkStatus.ERROR;
      print("Error executing mutation: ${result.exception}");
    } else {
      complaint.clear();
      documents.clear();
      networkStatus.value = NetworkStatus.SUCCESS;
      AppToasts.showSuccess("Complaint Sent");

      MyOrderController myOrderController = Get.put(MyOrderController());

      myOrderController.getOrginOrder();

      Get.toNamed(Routes.MAIN_PAGE);
      Get.find<MainPageController>().changeBottomPage(1);
      myOrderController.tabController.index = 4;
    }
  }

  void handleSendException(dynamic e) {
    networkStatus.value = NetworkStatus.ERROR;
    print('Error sending data: $e');
    if (!e.toString().contains("Null")) {
      AppToasts.showError("An error occurred while sending data.");
    }
  }
}

class DocPathModel {
  String? path;

  DocPathModel({
    this.path,
  });

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}
