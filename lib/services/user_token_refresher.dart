// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/services/data/refresh_token_mutation.dart';
import 'package:ics/services/graphql_conf.dart';
import 'package:ics/utils/constants.dart';
import 'package:ics/utils/encryption.dart';
import 'package:ics/utils/prefrence_utility.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';

class UserTokenChecker {
  static Future<UserTokenCheckerResponse> checkTokenNew(
      OperationException? exception, String queryStr) async {
    if (exception != null) {
      if (exception.graphqlErrors.isNotEmpty) {
        for (var element in exception.graphqlErrors) {
          if (element.message.contains('TOKEN_INVALID')) {
            logout();
          }

          if (element.message.contains('JWTExpired')) {
            bool isRefreshed = await refreshToken();
            if (isRefreshed) {
              return UserTokenCheckerResponse.TOKEN_REFRESHED_SUCCESS;
            } else {
              print(isRefreshed);
              print(
                  "TOKEN REFRESH TEST ======== refreshToken error TOKEN REFRESH TEST");
              logout();
              return UserTokenCheckerResponse.NETWORK_ERROR;
            }
          }
        }
      }
    } else {
      return UserTokenCheckerResponse.NETWORK_ERROR;
    }

    return UserTokenCheckerResponse.NETWORK_ERROR;
  }

  Future<bool> checkToken() async {
    while (true) {
      AppTokenRefresherState appTokenRefresherState = getRefresherState();

      if (appTokenRefresherState == AppTokenRefresherState.OTHER) {
        await Future.delayed(const Duration(seconds: 1));
        return true;
      }

      if (appTokenRefresherState == AppTokenRefresherState.REFRESHING) {
        await Future.delayed(const Duration(seconds: 1));
        continue;
      }

      if (appTokenRefresherState == AppTokenRefresherState.TOKEN_INVALID) {
        await logout();
        return false;
      }

      if (appTokenRefresherState == AppTokenRefresherState.TOKEN_VALID) {
        bool isTokenExp = await isTokenExpired();

        if (!isTokenExp) {
          return true;
        } else {
          await Future.delayed(const Duration(seconds: 1));
          continue;
        }
      }

      if (appTokenRefresherState == AppTokenRefresherState.NETWORK_ERROR) {
        await Future.delayed(const Duration(milliseconds: 500));
        continue;
      }

      return false;
    }
  }

  Future<bool> isTokenExpired() async {
    bool isRefreshTokenExpired = JwtDecoder.isExpired(
        EncryptionUtil.decrypt(PreferenceUtils.getString('refresh_token')));

    bool isAccessTokenExpired = DateTime.now().millisecondsSinceEpoch >
        JwtDecoder.getExpirationDate(
          EncryptionUtil.decrypt(
            PreferenceUtils.getString('access_token'),
          ),
        ).millisecondsSinceEpoch;

    if (isRefreshTokenExpired) {
      ///SET TOKEN INVALID STATE
      await PreferenceUtils.setString(
        Constants.REFRESHER_STATE,
        EnumToString.convertToString(AppTokenRefresherState.TOKEN_INVALID),
      );
    }

    return isAccessTokenExpired;
  }

  AppTokenRefresherState getRefresherState() {
    AppTokenRefresherState? appTokenRefresherState = EnumToString.fromString(
      AppTokenRefresherState.values,
      PreferenceUtils.getString(Constants.REFRESHER_STATE),
    );
    if (appTokenRefresherState != null) {
      return appTokenRefresherState;
    }
    return AppTokenRefresherState.OTHER;
  }

  static logout() async {
    ///SET TOKEN INVALID STATE
    await PreferenceUtils.setString(
      Constants.REFRESHER_STATE,
      EnumToString.convertToString(AppTokenRefresherState.OTHER),
    );
    final prefs = await SharedPreferences.getInstance();
    final acc = await prefs.remove(Constants.userAccessTokenKey);
    final ref = await prefs.remove(Constants.refreshTokenKey);
    final bio = await prefs.remove('BioID');

    if (acc && ref && bio) {
      Get.offAllNamed(Routes.SPLASH);
    }
  }

  static bool checkIfRefreshTokenExpired() {
    ///CHECK IF ACCESS AND REFRESH TOKEN IS EXPIRED
    bool isRefreshTokenExpired = JwtDecoder.isExpired(
        EncryptionUtil.decrypt(PreferenceUtils.getString('refresh_token')));

    ///default return
    return isRefreshTokenExpired;
  }

  static Future<bool> refreshToken() async {
    String refreshToken = EncryptionUtil.decrypt(
        PreferenceUtils.getString(Constants.refreshTokenKey));

    // Check if the refresh token is expired
    bool isRefreshTokenExpired = JwtDecoder.isExpired(refreshToken);
    if (isRefreshTokenExpired) {
      // If the refresh token is expired, you can't refresh the JWT token
      // You should handle this situation according to your app's requirements
      // For example, you can log out the user or show a message asking them to log in again
      logout();
      return false;
    }

    // If the refresh token is not expired, proceed with the refresh process
    GraphQLConfigurationRefresh graphQLConfiguration =
        GraphQLConfigurationRefresh();

    GraphQLClient client = graphQLConfiguration.clientToQuery();
    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(RefreshTokenMutation.refreshtoken),
      ),
    );

    if (!result.hasException) {
      // If the refresh process is successful, update the JWT token and refresh token
      String encryptToken = EncryptionUtil.encrypt(
        result.data!["refreshToken"]["tokens"]["access_token"],
      );

      String encryptRefreshToken = EncryptionUtil.encrypt(
        result.data!["refreshToken"]["tokens"]["refresh_token"],
      );

      await PreferenceUtils.setString(
          Constants.userAccessTokenKey, encryptToken);

      await PreferenceUtils.setString(
        Constants.refreshTokenKey,
        encryptRefreshToken,
      );

      return true;
    } else {
      // If the refresh process failed, handle the error
      // For example, you can log out the user or show an error message

      if (result.exception!.graphqlErrors.isNotEmpty) {
        for (var element in result.exception!.graphqlErrors) {
          if (element.message.contains('TOKEN_INVALID')) {
            logout();
            return false;
          }
        }
      }

      // If the refresh process failed for another reason, handle it accordingly
      // For example, you can log the error or show an error message
      print(
          "TOKEN REFRESH TEST ======== refreshToken error TOKEN REFRESH TEST");
      return false;
    }
  }
}

enum UserTokenCheckerResponse { NETWORK_ERROR, TOKEN_REFRESHED_SUCCESS }

enum AppTokenRefresherState {
  REFRESHING,
  TOKEN_INVALID,
  TOKEN_VALID,
  NETWORK_ERROR,
  OTHER,
}
