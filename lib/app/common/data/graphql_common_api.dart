// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/services/graphql_conf.dart';

import '../../modules/logout/controllers/logout_controller.dart';

class GraphQLCommonApi {
  Future<bool> isInternetConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>?> query(
      String queryStr, Map<String, dynamic> variables) async {
    /// CHECK INTERNET CONNECTIVITY
    final bool isConnected = await isInternetConnected();

    if (!isConnected) {
      AppToasts.showError("No internet");
    } else {
      /// GET GRAPHQL CLIENT
      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      QueryResult result = await graphQLClient.query(
        QueryOptions(
          document: gql(queryStr),
          variables: variables,
        ),
      );

      if (!result.hasException) {
        // print("API RESPONSE => CALLED ${result.data}");

        return result.data;
      } else {
        print("API RESPONSE => CALLED ${result.exception}");
        if (result.exception.toString().contains('JWTExpired')) {
          final LogoutController logoutController = Get.put(LogoutController());

          logoutController.logout();
        }
      }
    }

    return null;
  }

  Future<Map<String, dynamic>?> mutation(
      String queryStr, Map<String, dynamic> variables) async {
    /// CHECK INTERNET CONNECTIVITY
    final bool isConnected = await isInternetConnected();
    if (!isConnected) {
    } else {
      /// GET GRAPHQL CLIENT
      GraphQLClient graphQLClient;

      graphQLClient = GraphQLConfiguration().clientToQuery();

      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(queryStr),
          variables: variables,
        ),
      );

      if (!result.hasException) {
        // print("API RESPONSE => CALLED ${result.data}");

        return result.data;
      } else {
        print("API RESPONSE => CALLED ${result.exception}");
        if (result.exception.toString().contains('JWTExpired')) {
          final LogoutController logoutController = Get.put(LogoutController());

          logoutController.logout();
        }
      }
    }

    return null;
  }
}
