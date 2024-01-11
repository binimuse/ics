import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
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

  var isEmailValidated = false.obs;
  var isNextPressed = false.obs;
  var isPasswordValid = false.obs;
  late TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  var signingIn = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool validateEmail() {
    final email = emailController.text.trim();

    // Regular expression pattern for email validation
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (email.isNotEmpty && emailRegex.hasMatch(email)) {
      isEmailValidated.value = true;
      return true;
    } else {
      isEmailValidated.value = false;
      return false;
    }
  }

  bool validatePassword() {
    final password = passwordController.text;
    bool hasNumber = false;
    bool hasSpecialCharacter = false;

    if (password.length >= 8) {
      for (int i = 0; i < password.length; i++) {
        if (password[i].isNumericOnly) {
          hasNumber = true;
        } else if (!password[i].isAlphabetOnly) {
          hasSpecialCharacter = true;
        }
      }

      if (hasNumber && hasSpecialCharacter) {
        isPasswordValid(true);
        return true;
      }
    }

    isPasswordValid(false);
    return false;
  }

  void signIn(BuildContext context) async {
    signingIn(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(SignInQueryMutation.login),
        variables: <String, dynamic>{
          'object': {
            'email': emailController.text,
            'password': passwordController.text,
            'phone_number': "",
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

      Get.offAllNamed(Routes.MAIN_PAGE);
    } else {
      print(result.exception!.graphqlErrors);
      signingIn(false);

      handleException(result);
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
      Get.toNamed(Routes.OTP_VARIFICATION, arguments: {
        "email": emailController.text,
      });
    } else if (errorMessage.contains("INVALID_CREDENTIALS")) {
      AppToasts.showError("Incorrect Email or Password");
    } else {
      AppToasts.showError(errorMessage);
      // Handle other GraphQL errors
    }
  }
}
