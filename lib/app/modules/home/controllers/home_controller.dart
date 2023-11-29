import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/common/data/graphql_common_api.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/modules/home/data/models/user_model.dart';
import 'package:ics/app/modules/home/data/quary/configartion_quary.dart';
import 'package:ics/gen/assets.gen.dart';
import 'package:ics/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //banner
  List<Widget> featuredNews = [];
  List<String> images = [
    "https://images.unsplash.com/photo-1688989680825-0790dc6488fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1664689528330-2d7ad01f8319?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80",
    "https://images.unsplash.com/photo-1636910054073-ad228600476e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1636910054073-ad228600476e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
  ];
  RxInt index = 0.obs;
  RxString action = "Home".obs;
  //for passport card
  final List<String> svgPaths = [
    Assets.icons.passport,
    Assets.icons.passport,
    Assets.icons.passport,
    Assets.icons.passport,
  ];

  final List<String> titles = [
    'New \n Passport',
    'Renew \n Passport',
    'Passport \n Correction',
    'Lost \n Passport',
  ];

  //for OrginID card
  final List<String> svgPathsOrgin = [
    Assets.icons.origin,
    Assets.icons.origin,
    Assets.icons.origin,
    Assets.icons.origin,
  ];

  final List<String> Orgintitles = [
    'New \n Origin Id',
    'Renew  \n Origin Id',
    'Origin Id \n Correction',
    'Lost \n Origin Id',
  ];

  final List<Color> color = [
    AppColors.success,
    AppColors.warning,
    AppColors.accent,
    AppColors.secondary,
  ];

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  late UsersByPk usersModel = UsersByPk();
  var startGetUser = false.obs;
  var hasGetUser = false.obs;
  GetUser_byPk_Query getUser_byPk_Query = GetUser_byPk_Query();

  void getUser() async {
    startGetUser(true);
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(Constants.userId);

    if (id != null) {
      dynamic result =
          await graphQLCommonApi.query(getUser_byPk_Query.fetchData(id), {});
      startGetUser(false);

      if (result != null) {
        print("object");
        usersModel = UsersByPk.fromJson(result["users_by_pk"]);

        hasGetUser(true);
      } else {
        hasGetUser(false);
        startGetUser(false);
      }
      try {} catch (e) {
        print(e);
        hasGetUser(false);
        startGetUser(false);
      }
    } else {}
  }
}
