import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';
import 'services/graphql_conf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
void main() async {
  //for status  bar color

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
