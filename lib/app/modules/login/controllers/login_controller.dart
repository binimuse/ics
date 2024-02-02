import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/login/data/mutation/signin_mutuation.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/services/graphql_conf.dart';
import 'package:ics/utils/constants.dart';
import 'package:ics/utils/encryption.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  late TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  GraphQLConfigurationForauth graphQLConfiguration =
      GraphQLConfigurationForauth();
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

  var isNextPressed = false.obs;
  var isPasswordValid = false.obs;
  late TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  var signingIn = false.obs;
  var countryCode = "+39";
  late TextEditingController phoneController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool validatePassword() {
    final password = passwordController.text;
    bool hasNumber = false;

    if (password.length >= 6) {
      for (int i = 0; i < password.length; i++) {
        if (password[i].isNumericOnly) {
          hasNumber = true;
        }
      }

      if (hasNumber) {
        isPasswordValid(true);
        return true;
      }
    }

    isPasswordValid(false);
    return false;
  }

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  void signIn(BuildContext context) async {
    networkStatus.value = NetworkStatus.LOADING;
    signingIn(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(SignInQueryMutation.login),
          variables: <String, dynamic>{
            'object': {
              'email': countryCode.toString() + phoneController.text,
              'password': passwordController.text,
              'phone_number': countryCode.toString() + phoneController.text,
            }
          },
        ),
      );

      if (!result.hasException) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            Constants.userAccessTokenKey,
            EncryptionUtil.encrypt(
                result.data!["login"]["tokens"]["access_token"]));

        await prefs.setString(
            Constants.refreshTokenKey,
            EncryptionUtil.encrypt(
                result.data!["login"]["tokens"]["refresh_token"]));

        await prefs.setString(
            Constants.userId, result.data!["login"]["user_id"].toString());
        networkStatus.value = NetworkStatus.SUCCESS;
        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        networkStatus.value = NetworkStatus.ERROR;
        print(result.exception!.graphqlErrors);
        signingIn(false);

        handleException(result);
      }
    } catch (e, s) {
      networkStatus.value = NetworkStatus.ERROR;
      signingIn(false);
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      AppToasts.showError("An error occurred during sign in");
    }
  }

  void handleException(QueryResult<Object?> result) {
    print(result);
    if (result.exception != null) {
      if (result.exception!.graphqlErrors.isNotEmpty) {
        handleGraphQLErrors(result.exception!.graphqlErrors);
      } else {
        print(result.exception);
        AppToasts.showError("try again later.");
      }
    }
  }

  void handleGraphQLErrors(List<GraphQLError> errors) {
    String errorMessage = errors[0].message;
    if (errorMessage == "CANT_FIND_USER_ACCESS_DENIED") {
      AppToasts.showError("User not found");
    } else if (errorMessage.contains("EMAIL_NOT_VERIFIED")) {
      AppToasts.showError("Email address is not verified.");
    } else if (errorMessage.contains("INVALID_CREDENTIALS")) {
      AppToasts.showError("Incorrect Email or Password");
    } else if (errorMessage.contains("PHONE")) {
      AppToasts.showError("Phone number  not verified.");
      Get.toNamed(Routes.OTP_VARIFICATION,
          arguments: {"phone": countryCode.toString() + phoneController.text});
    } else {
      // AppToasts.showError(errorMessage);
      // Handle other GraphQL errors
    }
  }

  final phoneFocusNode = FocusNode();
  var isPhoneValid = false.obs;
  bool validatPhone() {
    final password = phoneController.text;
    if (password.length >= 8) {
      isPhoneValid(true);
      return true;
    } else {
      isPhoneValid(false);
      return false;
    }
  }
}
