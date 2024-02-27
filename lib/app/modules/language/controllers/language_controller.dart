import 'dart:async';


import 'package:get/get.dart';


class LanguageController extends GetxController {

  final String log = "APP_REFRESH_LOG";


  late final Timer timer;


  //Error and loading


  var isApiLoading = false.obs;


  var hasNetworkError = false.obs;


  Future<bool> changeLang(String lan) async {

    isApiLoading(true);


    hasNetworkError(false);


    return false;

  }

}

