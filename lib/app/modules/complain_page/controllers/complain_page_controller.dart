import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';

class ComplainPageController extends GetxController {
  final TextEditingController complaint = TextEditingController();
  List<String> icons = [
    'assets/icons/passport.svg',
    'assets/icons/profile_default.svg',
    'assets/icons/paper.svg',
    'assets/icons/memo.svg',
    'assets/icons/question.svg'
  ];
  List<String> labels = [
    'Passport',
    'Origin ID',
    'Resident Permit',
    'Visa Service',
    'Other\nComplaints'
  ];
  final List<Color> color = [
    AppColors.success,
    AppColors.warning,
    AppColors.accent,
    AppColors.secondary,
    AppColors.primaryDark,
  ];

  List<String> complaintType = [
    'Visa Application Error',
    'Passport Issuance Delay',
    'Document Requirement Misunderstanding',
    'Service Center Accessibility',
    'Online Application Interface Issue',
    'Visa Interview Process',
    'Other Service-Related Concerns',
  ];

  final RxString complaintypevalue = ''.obs;
}

enum ComplainType { passport, originId, residentPermit, visa, other }
