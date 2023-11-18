import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/modules/signup/data/mutation/signup_mutuation.dart';
import 'package:ics/services/graphql_conf.dart';

class SignupController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

//usernmae
  late TextEditingController fNameController = TextEditingController();
  late TextEditingController lNameController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  final emailFocusNode = FocusNode();

  var isEmailValidated = false.obs;
  var isNextPressed = false.obs;
  var countryCode = "";
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
    otpController = TextEditingController();
    isjustForinit(true);
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
    if (password.length >= 8) {
      isPasswordValid(true);
      return true;
    } else {
      isPasswordValid(false);
      return false;
    }
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

  //mobile varification

  final phoneFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  var isPhoneValid = false.obs;
  var isNextPressedMobile = false.obs;
  var isOtpValid = false.obs;
  var isjustForinit = false.obs;

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

  //signupp
  var signingUp = false.obs;
  var otpverfy = false.obs;
  void signUp() async {
    final bool isConnected = await isInternetConnected();
    if (!isConnected) {
      signingUp(false);
      AppToasts.showError("No internet, Please connect to internet and retry");
    } else {
      // other validation checks
      if (phoneController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          lNameController.text.isNotEmpty &&
          fNameController.text.isNotEmpty) {
        signingUp(true);
        signUpMutation().then((result) {
          if (!result.hasException) {
            // success handling

            signingUp(false);

            AppToasts.showSuccess("Successfully registered");
          } else {
            print(result);
            // error handling
            signingUp(false);

            //  AppToasts.showError("Phone number is already registered");
            AppToasts.showError("Something went wrong");
          }
        }).catchError((error) {
          print(error);
          // handle error
          signingUp(false);

          AppToasts.showError("Something went wrong");
        });
      } else {
        print("am here");
        signingUp(false);

        AppToasts.showError("Something went wrong");
      }
    }
  }

  Future<bool> isInternetConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (Platform.isIOS) {
      return true;
    }
    return connectivityResult != ConnectivityResult.none;
  }

  Future<QueryResult> signUpMutation() async {
    GraphQLClient client = GraphQLProvider.of(Get.context!).value;

    return client.mutate(
      MutationOptions(
        document: gql(SignupQueryMutation.register),
        variables: <String, dynamic>{
          'email': emailController.text,
          'name': fNameController.text + lNameController.text,
          'password': passwordController.text,
          'phone_number': countryCode.toString() + phoneController.text,
        },
      ),
    );
  }
}
