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
import 'package:ics/app/modules/new_origin_id/controllers/new_origin_id_controller.dart';
import 'package:ics/app/modules/new_origin_id/data/model/citizens_model_orginId.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/pdf_Page.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_five_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_four_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_one_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_seven_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_six_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_three_orginid.dart';
import 'package:ics/app/modules/new_origin_id/views/widget/steps/step_two_orginid.dart';

import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/utils/constants.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:image_picker/image_picker.dart';

class NewOrginIdForm extends StatefulWidget {
  final IcsApplicationModelOrginId? citizenModel;

  const NewOrginIdForm({
    this.citizenModel,
  });
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<NewOrginIdForm> {
  final NewOriginIdController controller = Get.find<NewOriginIdController>();

  XFile? image;

  @override
  void dispose() {
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

  final picker = ImagePicker();
  final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        stoppop: false,
        title: 'New',
        title2: "Origin ID Form",
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
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Container(
      color: AppColors.grayLighter.withOpacity(0.2),
      height: 87.h,
      child: Column(
        children: [
          IconStepper(
            activeStep: controller.currentStep,
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
                Icons.copy_all,
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
              Icon(
                Icons.payment,
                color: AppColors.whiteOff,
              ),
            ],
            onStepReached: (index) {
              setState(() {
                controller.currentStep = index;
              });
            },
            enableNextPreviousButtons: false,
            enableStepTapping: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: FormBuilder(
                key: controller.neworginIdformKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                canPop: true,
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      if (controller.currentStep == 0)
                        //Personal Detail
                        Step1OrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Personal Detail
                      if (controller.currentStep == 1)
                        Step2OrginID(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Address
                      if (controller.currentStep == 2)
                        Step3OrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Passport info
                      if (controller.currentStep == 3)
                        Step4OrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 4) Step5OrginId(),

                      if (controller.currentStep == 5) Step6Orginid(),
                      if (controller.currentStep == 6) Step7Orginid(),

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
                if (controller.currentStep > 0)
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
                        if (controller.currentStep > 0) {
                          setState(() {
                            controller.currentStep--;
                          });
                        }
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomNormalButton(
                      text: controller.currentStep == 6 ? 'Submit' : 'Next',
                      textStyle: AppTextStyles.bodyLargeBold.copyWith(
                        color: AppColors.whiteOff,
                      ),
                      textcolor: AppColors.whiteOff,
                      buttoncolor: controller.currentStep == 5
                          ? AppColors.primary
                          : AppColors.primary,
                      borderRadius: AppSizes.radius_16,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.mp_v_1,
                        horizontal: AppSizes.mp_w_6,
                      ),
                      onPressed: () async {
                        if (controller.currentStep == 1) {
                          if (controller.neworginIdformKey.currentState!
                              .saveAndValidate()) {
                            if (controller.selectedImages.isNotEmpty) {
                              setState(() {
                                controller.currentStep++;
                              });
                            } else {
                              _scrollToBottom();
                              AppToasts.showError("Please upload a photo.");
                            }
                          } else {
                            _scrollToBottom();
                          }
                        } else if (controller.currentStep == 3) {
                          if (controller.signatureController.isNotEmpty) {
                            controller.handleDrawFinish();
                            setState(() {
                              controller.currentStep++;
                            });
                          } else {
                            AppToasts.showError("Please sign your signature");
                          }
                        } else if (controller.currentStep == 4) {
                          checkdoc();
                        } else if (controller.currentStep == 5) {
                          finalstep(context);
                        } else {
                          if (controller.neworginIdformKey.currentState!
                              .saveAndValidate()) {
                            setState(() {
                              controller.currentStep++;
                            });
                          } else {
                            _scrollToBottom();
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showSummeryDiloag(BuildContext context) {
    Get.to(PdfPageNewOriginId(
      context: context,
      controller: controller,
      onTap: () {
        Navigator.pop(context);
        setState(() {
          controller.currentStep++;
        });
      },
    ));
  }

  void checkdoc() async {
    if (controller.documents.isEmpty) {
      AppToasts.showError("Document are empty");
      return;
    } else if (controller.documents.any((element) => element.files.isEmpty)) {
      controller.isSendStared.value = false;
      AppToasts.showError("Document must not be empty");
      return;
    } else {
      controller.neworginIdformKey.currentState!.saveAndValidate()
          ? _showSummeryDiloag(context)
          : SizedBox();
    }
  }

  void _scrollToBottom() {
    controller.scrollController.animateTo(
      controller.scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showAreYouSureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  "Are you sure You want to exit ",
                  style: AppTextStyles.bodyLargeBold,
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Cancel".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.danger,
                      AppColors.danger,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Center(
                  child: Text(
                    "Yes".tr,
                    style: AppTextStyles.bodyLargeBold
                        .copyWith(color: AppColors.whiteOff),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void getDataForStep1() {
    final citizenModel = widget.citizenModel;
    final firstName = citizenModel!.firstName!;
    final fatherName = citizenModel.father_name!;
    final birthplace = citizenModel.birthPlace!;
    final grandFatherName = citizenModel.grand_father_name!;
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

    if (citizenModel.embassyId.isNotEmpty) {
      embassyId = citizenModel.embassyId;
      Future.delayed(const Duration(seconds: 2), () {
        controller.embassiesvalue.value =
            controller.base_embassies.firstWhere((e) => e.id == embassyId);
      });

      currentcontry = citizenModel.currentCountryId;

      controller.currentcountryvalue.value =
          controller.allwoedCountries.firstWhere((e) => e.id == currentcontry);
    }

    controller.countryvalue.value =
        controller.allwoedCountries.firstWhere((e) => e.id == abroadCountryId);

    controller.getEmbassies(controller.countryvalue.value!.id);
    controller.addressController.text = abroadAddress;
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
    final citizenModel = widget.citizenModel;

    if (citizenModel!.newOriginIdApplications.isNotEmpty) {
      final passportNumber =
          citizenModel.newOriginIdApplications.first.current_passport_number;

      final passportExpiryDate = citizenModel
          .newOriginIdApplications.first.current_passport_expiry_date;

      final passportIssuedDate = citizenModel
          .newOriginIdApplications.first.current_passport_expiry_date;

      final visaTypeID =
          citizenModel.newOriginIdApplications.first.visa_type_id!;

      final visanumber = citizenModel.newOriginIdApplications.first.visa_number;

      controller.passportNumberContoller.text = passportNumber!;
      controller.passportExpiryDateController.text =
          passportExpiryDate.toString();

      controller.passportIssueDateController.text =
          passportIssuedDate.toString();

      controller.visatypevalue.value =
          controller.visaType.firstWhere((e) => e.id == visaTypeID);

      controller.visanumberContoller.text = visanumber.toString();
    }
  }

  void createCitizen() async {
    await controller.send(); // Wait for the send() method to complete
    if (controller.isSend.value) {
      setState(() {
        controller.currentStep++;
      });
    } else {
      AppToasts.showError("Fill all the required fields");
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
}
