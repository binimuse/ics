import 'package:get/get.dart';
import 'package:flutter/material.dart';

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

  var isPasswordValid = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    fNameController = TextEditingController();
    lNameController = TextEditingController();
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
}
