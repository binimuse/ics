import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:ics/app/app_language/translations.dart';

import 'package:ics/utils/lang_util.dart';

import 'package:ics/utils/prefrence_utility.dart';

import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

import 'services/graphql_conf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

late String selectedLocale;

void main() async {
  //for status  bar color
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();

  selectedLocale = LanUtil.getSelecctedLanguage();
  await Future<void>.delayed(const Duration(milliseconds: 5000));
  runApp(App());
}

Sizer App() {
  return Sizer(
    builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GraphQLProvider(
        client: graphQLConfiguration.client,
        child: CacheProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: GetMaterialApp(
              theme: ThemeData(
                primaryColor: Colors.white,
              ),
              translations: MainTranslations(),
              locale: Locale(
                selectedLocale,
              ),
              themeMode: ThemeMode.light,
              title: "Immigration and citizen service",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      );
    },
  );
}
