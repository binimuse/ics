import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';

import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/customappbar.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/data/enums.dart';

import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/app/modules/new_passport/views/widget/pdfPage.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_five.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_four.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_one.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_six.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_three.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_two.dart';
import 'package:ics/utils/constants.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

class NewPassportForm extends StatefulWidget {
  final IcsApplicationModel? citizenModel;

  const NewPassportForm({
    this.citizenModel,
  });
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<NewPassportForm> {
  final NewPassportController controller = Get.find<NewPassportController>();
  final ScrollController _scrollController = ScrollController();

  XFile? image;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    if (widget.citizenModel != null) {
      getDataForStep1();
      getDataForStep2();
      getDataForStep3();
      getDataForStep4();
    }
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  final picker = ImagePicker();
  final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        stoppop: false,
        title: 'New',
        title2: "Passport Form",
        showLeading: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 1.h,
                ),

                buildForm(context),
                // Spacer(),
              ],
            ),
          ),
          Obx(
            () => controller.networkStatus.value == NetworkStatus.LOADING
                ? Center(child: CustomLoadingWidget())
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Obx(() => Container(
          color: AppColors.grayLighter.withOpacity(0.2),
          height: 87.h,
          child: Column(
            children: [
              IconStepper(
                activeStep: controller.currentStep.value,
                lineColor: AppColors.secondary,
                stepColor: AppColors.grayDefault,
                activeStepColor: AppColors.primary,
                icons: [
                  Icon(
                    Icons.person,
                    color: AppColors.whiteOff,
                  ),
                  Icon(
                    Icons.person,
                    color: AppColors.whiteOff,
                  ),
                  Icon(
                    Icons.location_on,
                    color: AppColors.whiteOff,
                  ),
                  Icon(
                    Icons.family_restroom,
                    color: AppColors.whiteOff,
                  ),
                  Icon(
                    Icons.edit_document,
                    color: AppColors.whiteOff,
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.whiteOff,
                  ),
                ],
                onStepReached: (index) {
                  controller.currentStep.value = index;
                },
                enableNextPreviousButtons: false,
                enableStepTapping: false,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FormBuilder(
                    key: controller.newPassportformKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    skipDisabled: true,
                    canPop: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          if (controller.currentStep.value == 0)
                            Step1(
                              citizenModel: widget.citizenModel,
                              controller: controller,
                            ),

                          if (controller.currentStep.value == 1)
                            Step2(
                              citizenModel: widget.citizenModel,
                              controller: controller,
                            ),
                          if (controller.currentStep.value == 2)
                            Step3(
                              citizenModel: widget.citizenModel,
                              controller: controller,
                            ),
                          if (controller.currentStep.value == 3)
                            Step4(
                              citizenModel: widget.citizenModel,
                              controller: controller,
                            ),

                          if (controller.currentStep.value == 4) Step5(),

                          if (controller.currentStep.value == 5) Step6(),

                          // Add more form fields as needed for each step
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: AppColors.whiteOff,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (controller.currentStep.value > 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomNormalButton(
                          text: 'Back',
                          textStyle: AppTextStyles.bodyLargeBold.copyWith(
                            color: AppColors.whiteOff,
                          ),
                          textcolor: AppColors.whiteOff,
                          buttoncolor: controller.areAllTermsSelected()
                              ? AppColors.grayLight
                              : AppColors.grayLight,
                          borderRadius: AppSizes.radius_16,
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.mp_v_1,
                            horizontal: AppSizes.mp_w_6,
                          ),
                          onPressed: () {
                            if (controller.currentStep.value > 0) {
                              controller.currentStep.value--;
                            }
                          },
                        ),
                      ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomNormalButton(
                            text: controller.currentStep.value == 5
                                ? 'Submit'
                                : 'Next',
                            textStyle: AppTextStyles.bodyLargeBold.copyWith(
                              color: AppColors.whiteOff,
                            ),
                            textcolor: AppColors.whiteOff,
                            buttoncolor: controller.currentStep.value == 5
                                ? AppColors.primary
                                : AppColors.primary,
                            borderRadius: AppSizes.radius_16,
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.mp_v_1,
                              horizontal: AppSizes.mp_w_6,
                            ),
                            onPressed: () async {
                              if (controller.currentStep.value == 1) {
                                if (controller.newPassportformKey.currentState!
                                    .saveAndValidate()) {
                                  if (controller.selectedImages.isNotEmpty) {
                                    controller.currentStep.value++;
                                  } else {
                                    _scrollToBottom();
                                    AppToasts.showError(
                                        "Please upload a photo.");
                                  }
                                } else {
                                  _scrollToBottom();
                                }
                              } else if (controller.currentStep.value == 4) {
                                checkdoc();
                              } else if (controller.currentStep.value == 5) {
                                finalstep(context);
                              } else {
                                if (controller.newPassportformKey.currentState!
                                    .saveAndValidate()) {
                                  controller.currentStep.value++;
                                } else {
                                  _scrollToBottom();
                                }
                              }
                            }))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void checkdoc() async {
    if (controller.documents.isEmpty) {
      AppToasts.showError("Document are empty");
      return;
    } else if (controller.documents.any((element) => element.files.isEmpty)) {
      controller.networkStatus.value = NetworkStatus.ERROR;
      AppToasts.showError("Document must not be empty");
      return;
    } else {
      controller.newPassportformKey.currentState!.saveAndValidate()
          ? _showSummeryDiloag(context)
          : SizedBox();
    }
  }

  void finalstep(BuildContext context) {
    if (controller.selectedDate != null ||
        controller.selectedDateTime != null) {
      controller.send();
    } else {
      AppToasts.showError("Please select both a date and a time");
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }


  void getDataForStep1() {
    final citizenModel = widget.citizenModel;
    final firstName = citizenModel!.firstName!;
    final fatherName = citizenModel.father_name!;
    final grandFatherName = citizenModel.grand_father_name!;
    final birthplace = citizenModel.birthPlace!;
    final firstNameAm = citizenModel.firstNameJson!.am!;
    final fatherNameAm = citizenModel.fatherNameJson!.am!;
    final grandFatherNameAm = citizenModel.grandFatherNameJson!.am!;
    final birthCountryId = citizenModel.birthCountryId;
    final nationalityId = citizenModel.nationality_id;
    final gender = citizenModel.gender;
    final dateOfBirth = citizenModel.dateOfBirth!;

    controller.firstNameController.text = firstName;
    controller.fatherNameController.text = fatherName;
    controller.grandFatherNameController.text = grandFatherName;
    controller.birthplace.text = birthplace;
    controller.AmfirstNameController.text = firstNameAm;
    controller.AmfatherNameController.text = fatherNameAm;
    controller.AmgrandFatherNameController.text = grandFatherNameAm;
    controller.isAdoption.value = citizenModel.is_adopted!;
    controller.birthCountryvalue.value =
        controller.bcountries.firstWhere((e) => e.id == birthCountryId);
    controller.natinalityvalue.value =
        controller.natinality.firstWhere((e) => e.id == nationalityId);
    controller.gendervalue.value =
        controller.gender.firstWhere((e) => e.name == gender);
    controller.dayController.text = dateOfBirth.day.toString();
    controller.monthController.text = dateOfBirth.month.toString();
    controller.yearController.text = dateOfBirth.year.toString();
  }

  void getDataForStep2() {
    final citizenModel = widget.citizenModel;
    final occupationId = citizenModel!.occupation_id;
    final hairColour = citizenModel.hairColour;
    final eyeColour = citizenModel.eyeColour;
    final skinColour = citizenModel.skinColour!;
    final height = citizenModel.height;
    final maritalStatus = citizenModel.maritalStatus;
    final photo = citizenModel.photo;

    controller.photoPath.add(photo!);
    controller.selectedImages.add(File(Constants.fileViewer + photo));
    // controller.selectedImages.add(photo!);

    if (occupationId != null) {
      controller.occupationvalue.value =
          controller.occupations.firstWhere((e) => e.id == occupationId);
    }

    if (hairColour != null) {
      controller.haircolorvalue.value =
          controller.haircolor.firstWhere((e) => e.name == hairColour);
    }

    if (eyeColour != null) {
      controller.eyecolorvalue.value =
          controller.eyecolor.firstWhere((e) => e.name == eyeColour);
    }
    controller.skincolorvalue.value = skinColour.toString();
    controller.height.text = height.toString();
    controller.maritalstatusvalue.value =
        controller.martial.firstWhere((e) => e.name == maritalStatus);
  }

  void getDataForStep3() {
    var embassyId;
    var currentcontry;
    final citizenModel = widget.citizenModel;
    final abroadCountryId = citizenModel!.abroadCountryId;

    final abroadAddress = citizenModel.abroadAddress!;
    var abroadPhoneNumber = citizenModel.abroadPhoneNumber!;

    if (citizenModel.embassy_id.isNotEmpty) {
      embassyId = citizenModel.embassy_id;
      Future.delayed(const Duration(seconds: 2), () {
        controller.embassiesvalue.value =
            controller.base_embassies.firstWhere((e) => e.id == embassyId);
      });

      currentcontry = citizenModel.current_country_id;

      controller.currentcountryvalue.value =
          controller.allwoedCountries.firstWhere((e) => e.id == currentcontry);
    }

    controller.countryvalue.value =
        controller.allwoedCountries.firstWhere((e) => e.id == abroadCountryId);

    controller.getEmbassies(controller.countryvalue.value!.id);

    controller.addressController.text = abroadAddress;
    controller.phonenumber.text = abroadPhoneNumber;

    abroadPhoneNumber = abroadPhoneNumber.replaceAll(" ", ""); // Remove spaces
    int digitsCount =
        10; // Number of digits in the phone number excluding country code

    if (abroadPhoneNumber.length >= digitsCount) {
      String extractedNumber =
          abroadPhoneNumber.substring(abroadPhoneNumber.length - digitsCount);
      controller.phonenumber.text = extractedNumber;
    } else {
      // Handle the case where the phoneNumber length is less than digitsCount
      // You can throw an exception, display an error message, or handle it in any other appropriate way.
    }
  }

  void getDataForStep4() {
    controller.familyModelvalue.value = widget.citizenModel!.familyModel!;
  }

  _showSummeryDiloag(BuildContext context) {
    Get.to(PdfPage(
      context: context,
      controller: controller,
      onTap: () {
        Navigator.pop(context);

        controller.currentStep.value++;
      },
    ));
  }
}
