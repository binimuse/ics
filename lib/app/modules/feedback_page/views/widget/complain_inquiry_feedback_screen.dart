import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/forms/reusableDropdown.dart';
import 'package:ics/app/common/forms/text_input_with_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/modules/feedback_page/controllers/feedback_page_controller.dart';
import 'package:sizer/sizer.dart';

class ComplainFeedBackInquiryScreen extends StatefulWidget {
  final ComplainType complainType;
  const ComplainFeedBackInquiryScreen({required this.complainType, super.key});

  @override
  State<ComplainFeedBackInquiryScreen> createState() =>
      _ComplainInquiryScreenState();
}

class _ComplainInquiryScreenState extends State<ComplainFeedBackInquiryScreen> {
  final FeedbackPageController controller = Get.find<FeedbackPageController>();
  List<String> meFile = [];
  bool uploaded = false;
  bool clicked = false;
  List<double> fileSize = [];
  // String? filePath;
  List<String> fileExtension = [];
  List<String> fileName = [];
  String capitalizeFirstLetter(String text, bool isResident) {
    if (text.isEmpty) {
      return text;
    }
    return isResident
        ? "${text[0].toUpperCase()}${text.substring(1, 8)} ${text.substring(8)}"
        : text[0].toUpperCase() + text.substring(1);
  }

  void removeAttachment(int index) {
    meFile.removeAt(index);
    fileName.removeAt(index);
    fileSize.removeAt(index);
  }

  void getFileType(File file) {
    final String fileN = file.path;
    final String fileExt = fileN.split('.').last.toLowerCase();
    setState(() {
      fileExtension.add(fileExt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            '${capitalizeFirstLetter(widget.complainType.name, widget.complainType == ComplainType.residentPermit)} ',
        title2: 'Services',
        showActions: false,
        showLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(7.w, 7.w, 7.w, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 85.w,
                    child: Text(
                      'Your feedback is important for our service improvement. Please pick the service you have an issue with.',
                      style: AppTextStyles.captionRegular.copyWith(
                          fontSize: AppSizes.font_12,
                          color: AppColors.grayDark),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  buildDropDown(),
                  SizedBox(
                    height: 2.h,
                  ),
                  buildTextFieald(),
                  SizedBox(
                    height: 2.h,
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    tapOnlyMode: false,
                    glow: false,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      //   controller.rating = rating.toInt();
                    },
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            )),
          ),
          buildSubmitButton(),
        ],
      ),
    );
  }

  buildDropDown() {
    return FormBuilderDropdown(
      validator: ValidationBuilder().required('feedback Type').build(),
      decoration: ReusableInputDecoration.getDecoration('feedback Type',
          isMandatory: true),
      items: controller.complaintType.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style:
                AppTextStyles.captionBold.copyWith(color: AppColors.grayDark),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.complaintypevalue.value = value!;
      },
      name: 'feedback',
    );
  }

  buildTextFieald() {
    return TextFormBuilder(
      isMandatory: false,
      maxline: 3,
      maxlength: 100,
      controller: controller.complaint,
      hint: 'State your feedback',
      labelText: 'feedbacks',
      validator: ValidationBuilder().required('feedback required').build(),
      showClearButton: false,
      autoFocus: false,
    );
  }

  buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomNormalButton(
        text: 'Submit',
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor: AppColors.primary,
        borderRadius: AppSizes.radius_8,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_2,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: () {},
      ),
    );
  }
}
