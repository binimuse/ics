import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/modules/otp_varification/data/muatation/otp_mutation.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/services/graphql_conf.dart';

import '../data/muatation/resendotp_mutation.dart';

class OtpVarificationController extends GetxController {
  var emailContoller = "".obs;

  final count = 0.obs;
  GraphQLConfigurationForauth graphQLConfiguration =
      GraphQLConfigurationForauth();

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
    isjustForinit(true);

    emailContoller.value = Get.arguments["email"];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  //mobile varification

  FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  var isNextPressedMobile = false.obs;
  var isOtpValid = false.obs;
  var isjustForinit = false.obs;
  var resendotpstarted = false.obs;
  var makeButtonEnable = true.obs;

  var countdownValue = 60.obs;
  Timer? countdownTimer;

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      countdownValue--;

      if (countdownValue == 0) {
        timer.cancel();

        makeButtonEnable(true);
      }
    });
  }

  resendOtp() async {
 
    resendotpstarted(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(ResendOTPQueryMutation.resenddotp),
        variables: <String, dynamic>{
          'object': {
            'email': emailContoller.value,
            'phone_number': "",
          }
        },
      ),
    );  
 
    if (!result.hasException) {
      resendotpstarted(false);

      AppToasts.showSuccess("OTP resent");  
        makeButtonEnable(false);
    countdownValue.value = 60;
    startCountdown();
    } else {
      resendotpstarted(false);
      print(result.exception);

      AppToasts.showError("somthing went wrong");
    }
  }

  // verify Otp

  var otp = "".obs;
  var verificationOtp = false.obs;
  void verification() async {
    verificationOtp(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(VerifyOTPMutation.otp),
        variables: <String, dynamic>{
          'object': {
            'code': otp.value,
            'email': emailContoller.value,
            'phone_number': "",
          }
        },
      ),
    );

    if (!result.hasException) {
      verificationOtp(false);

      AppToasts.showSuccess("Otp varifiyed successfully");
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    } else {
      verificationOtp(false);
      if (result.exception!.graphqlErrors[0].message
          .contains("OTP_NOT_CORRECT")) {
        AppToasts.showError("Invalid OTP");
      } else {
        print(result.exception);

        AppToasts.showError("Something went wrong");
      }
    }
  }
}
