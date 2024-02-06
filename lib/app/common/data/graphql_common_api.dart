// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/services/graphql_conf.dart';
import 'package:ics/services/user_token_refresher.dart';

class GraphQLCommonApi {
  final ConfigurationRole configurationRole;
  final snackBarInterval = const Duration(seconds: 5);

  GraphQLCommonApi({
    this.configurationRole = ConfigurationRole.USER,
  });

  Future<bool> isInternetConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (Platform.isIOS) {
      return true;
    }
    return connectivityResult != ConnectivityResult.none;
  }

  bool isSnackBarShown = false;
  Future<Map<String, dynamic>?> query(
      String queryStr, Map<String, dynamic> variables) async {
    /// CHECK INTERNET CONNECTIVITY
    final bool isConnected = await isInternetConnected();

    if (!isConnected) {
      if (!isSnackBarShown) {
        AppToasts.showError("No internet");
        isSnackBarShown = true;

        // Using Timer
        Timer(snackBarInterval, () {
          isSnackBarShown = false;
        });
      }
    } else {
      isSnackBarShown = false;

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
        UserTokenCheckerResponse userTokenCheckerResponse =
            await UserTokenChecker.checkTokenNew(result.exception, queryStr);

        if (userTokenCheckerResponse ==
            UserTokenCheckerResponse.NETWORK_ERROR) {
          throw result.exception!;
        }

        if (userTokenCheckerResponse ==
            UserTokenCheckerResponse.TOKEN_REFRESHED_SUCCESS) {
          ///CALL FUNCTION AGAIN
          query(queryStr, variables);
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
        UserTokenCheckerResponse userTokenCheckerResponse =
            await UserTokenChecker.checkTokenNew(result.exception, queryStr);

        if (userTokenCheckerResponse ==
            UserTokenCheckerResponse.NETWORK_ERROR) {
          throw result.exception!;
        }

        if (userTokenCheckerResponse ==
            UserTokenCheckerResponse.TOKEN_REFRESHED_SUCCESS) {
          ///CALL FUNCTION AGAIN
          query(queryStr, variables);
        }
      }
    }

    return null;
  }

  Stream<dynamic> subscription(
      String subscriptionStr, Map<String, dynamic> variables) {
    // Use the existing GraphQL client configured for subscriptions
    final GraphQLClient graphQLClient = GraphQLConfiguration().clientToQuery();

    // Create a StreamController to manage the subscription stream
    final StreamController<dynamic> controller = StreamController<dynamic>();

    // Set up the subscription
    final Stream<dynamic> subscriptionStream = graphQLClient.subscribe(
      SubscriptionOptions(
        document: gql(subscriptionStr),
        variables: variables,
        
      ),
    );

    // Add the subscription stream to the StreamController
    subscriptionStream.listen((event) {
      controller.add(event);
    }, onError: (error) {
      controller.addError(error);
    }, onDone: () {
      controller.close();
    });

    // Return the StreamController's stream
    return controller.stream;
  }
}
