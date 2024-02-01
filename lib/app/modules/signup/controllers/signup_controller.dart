import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/data/enums.dart';
import 'package:ics/app/modules/signup/data/mutation/signup_mutuation.dart';

import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/services/graphql_conf.dart';

class SignupController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

//usernmae
  late TextEditingController fNameController = TextEditingController();
  late TextEditingController lNameController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  final emailFocusNode = FocusNode();
  GraphQLConfigurationForauth graphQLConfiguration =
      GraphQLConfigurationForauth();

  var isEmailValidated = false.obs;
  var isNextPressed = false.obs;
  var countryCode = "+39";
  var isNotAvalableCountry = false.obs;

  var isPasswordValid = false.obs;
  late TextEditingController phoneController = TextEditingController();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    fNameController = TextEditingController();
    lNameController = TextEditingController();

    phoneController = TextEditingController();
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

  var isUsernameCorrect = false.obs;
  bool validateusername() {
    if (fNameController.text.isNotEmpty && lNameController.text.isNotEmpty) {
      isUsernameCorrect.value = true;
      return true;
    } else {
      isUsernameCorrect.value = false;
      return false;
    }
  }

  //signupp
  var signingUp = false.obs;


   Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  void signUp() async {

    networkStatus.value = NetworkStatus.LOADING;
    try {
      if (phoneController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          lNameController.text.isNotEmpty &&
          fNameController.text.isNotEmpty) {
        signingUp(true);
        signUpMutation().then((result) {
                networkStatus.value = NetworkStatus.SUCCESS;
          if (!result.hasException) {
            // success handling

            signingUp(false);
            AppToasts.showSuccess("Successfully registered");
            Future.delayed(const Duration(milliseconds: 300), () {
              AppToasts.showSuccess("Verify otp");
              Get.toNamed(Routes.OTP_VARIFICATION, arguments: {
                "email": emailController.text,
              });
            });
          } else {
            print(result);
            // error handling
            signingUp(false);

            //  AppToasts.showError("Phone number is already registered");
            //    AppToasts.showError("Something went wrong");

            if (result.exception!.graphqlErrors.isNotEmpty) {
              if (result.exception!.graphqlErrors[0].message
                  .contains("CREDENTIALS_IS_ALREADY_IN_USE")) {
                AppToasts.showError("Email has already been taken");

                Future.delayed(const Duration(milliseconds: 300), () {
                  Get.back();
                  Get.back();
                });
              }
            }
          }
        }).catchError((error) {
            networkStatus.value = NetworkStatus.ERROR;
          print(error);
          // handle error
          signingUp(false);

          AppToasts.showError("Something went wrong");
        });
      } else {
             networkStatus.value = NetworkStatus.ERROR;
        print("am here");
        signingUp(false);

        AppToasts.showError("Something went wrong");
      }
    } on Exception catch (e) {
           networkStatus.value = NetworkStatus.ERROR;
      print(e);
      // TODO
    }
  }

  Future<QueryResult> signUpMutation() async {
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    return client.mutate(
      MutationOptions(
        document: gql(SignupQueryMutation.register),
        variables: <String, dynamic>{
          'object': {
            'email': emailController.text,
            'name': fNameController.text + "" + lNameController.text,
            'password': passwordController.text,
            'phone_number': countryCode.toString() + phoneController.text,
          }
        },
      ),
    );
  }

  Future<bool> isInternetConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (Platform.isIOS) {
      return true;
    }
    return connectivityResult != ConnectivityResult.none;
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
