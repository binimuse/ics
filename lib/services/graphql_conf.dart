// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/utils/constants.dart';
import 'package:ics/utils/encryption.dart';
import 'package:ics/utils/prefrence_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLConfiguration {
  static const String _baseUrl = "http://196.189.30.108:8000/v1/graphql";
  static const String _websocketUrl = "ws://159.223.227.87:8888/v1/graphql";
  static const String xhasurarole = "user";

  static HttpLink httpLink = HttpLink(_baseUrl, defaultHeaders: {
    'x-hasura-role': xhasurarole,
  });

  static AuthLink authLink = AuthLink(getToken: () async {
    final prefs = await SharedPreferences.getInstance();

    return "Bearer ${EncryptionUtil.decrypt(prefs.getString(Constants.userAccessTokenKey))}";
  });

  static WebSocketLink websocketLink = WebSocketLink(
    _websocketUrl,
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(seconds: 30),
      initialPayload: () async {
        final prefs = await SharedPreferences.getInstance();
        late String token;
        if (EncryptionUtil.decrypt(prefs.getString('access_token'))
            .isNotEmpty) {
          token = EncryptionUtil.decrypt(prefs.getString('access_token'))
              .toString();
        }
        return {
          'headers': {'Authorization': 'Bearer $token'},
        };
      },
    ),
  );

  static Link websoket = authLink.concat(websocketLink).concat(httpLink);
  final Link links = Link.split(
    (request) => request.isSubscription,
    websocketLink,
    authLink.concat(httpLink),
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: websoket,
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: links,
      cache: GraphQLCache(),
    );
  }
}

class GraphQLConfigurationForauth {
  static HttpLink httpLink = HttpLink("http://196.189.30.108:8000/v1/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );

  final Link link = (httpLink);

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}

class GraphQLConfigurationRefresh {
  static HttpLink httpLink = HttpLink(
    "http://196.189.30.108:8000/v1/graphql",
    defaultHeaders: {
      'x-hasura-role': "anonymous",
    },
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: AuthLink(getToken: () async {
        return "Bearer ${EncryptionUtil.decrypt(PreferenceUtils.getString(Constants.refreshTokenKey))}";
      }).concat(httpLink),
    );
  }
}
