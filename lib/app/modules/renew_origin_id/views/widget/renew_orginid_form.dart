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
import 'package:ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:ics/app/modules/renew_origin_id/controllers/renew_origin_id_controller.dart';
import 'package:ics/app/modules/renew_origin_id/data/model/citizens_model_renew_orginId.dart';
import 'package:ics/app/modules/renew_origin_id/views/widget/steps/step_four_renew_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/views/widget/steps/step_seven_renew_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/views/widget/steps/step_five_renew_orginid.dart';

import 'package:ics/app/modules/renew_origin_id/views/widget/steps/step_six_renew_orginid.dart';
import 'package:ics/app/modules/renew_origin_id/views/widget/steps/step_two_renew_orginid.dart';
import 'package:ics/app/modules/renew_origin_id/views/widget/summery_renew_originid.dart';

import 'package:ics/app/routes/app_pages.dart';
import 'package:ics/utils/constants.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

import 'steps/step_one_renew_orginid.dart';
import 'steps/step_three_renew_orginid.dart';

class ReNewOrginIdForm extends StatefulWidget {
  final IcsApplicationModelReNewOrginId? citizenModel;

  const ReNewOrginIdForm({
    this.citizenModel,
  });
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<ReNewOrginIdForm> {
  final RenewOriginIdController controller =
      Get.find<RenewOriginIdController>();

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
        stoppop: true,
        title: controller.renewType.name,
        title2: "Form",
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
                ? CustomLoadingWidget()
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
                key: controller.reneworginIdformKey,
                enabled: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                skipDisabled: true,
                canPop: false,
                onPopInvoked: (didPop) {
                  _showAreYouSureDialog(context);
                },
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      if (controller.currentStep == 0)
                        //Personal Detail
                        Step1RenewOrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Personal Detail
                      if (controller.currentStep == 1)
                        Step2RenewOrginID(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Address
                      if (controller.currentStep == 2)
                        Step3RenewOrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      //Passport info
                      if (controller.currentStep == 3)
                        Step4RenewOrginId(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 4) Step5RenewOrginId(),

                      if (controller.currentStep == 5) Step6RenewOrginid(),
                      if (controller.currentStep == 6) Step7RenewOrginid(),

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
                      buttoncolor: AppColors.grayLight,
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
                            if (controller.reneworginIdformKey.currentState!
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
                            //  Get.dialog(ProfileFourDialog());
                            controller.handleDrawFinish();
                            controller.reneworginIdformKey.currentState!
                                    .saveAndValidate()
                                ? _showSummeryDiloag(context)
                                : SizedBox();
                          } else if (controller.currentStep == 4) {
                            checkdoc();
                          } else if (controller.currentStep == 6) {
                            finalstep();
                          } else {
                            if (controller.reneworginIdformKey.currentState!
                                .validate()) {
                              setState(() {
                                controller.currentStep++;
                              });
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
    );
  }

  _showSummeryDiloag(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SummaryDialogReNewOriginId(
          context: context,
          controller: controller,
          onTap: () {
            Navigator.pop(context);
            createCitizen();
          },
        );
      },
    );
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
      await controller.updateNewApplication();
      if (controller.isUpdateSuccess.value) {
        setState(() {
          controller.currentStep++;
        });
      }
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
                Get.offAllNamed(Routes.MAIN_PAGE);
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
    controller.birthplace.text = birthplace;
    controller.grandFatherNameController.text = grandFatherName;
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
    final height = citizenModel.height!;
    final maritalStatus = citizenModel.maritalStatus;

    final photo = citizenModel.photo;

    controller.photoPath.add(photo!);
    controller.selectedImages.add(File(Constants.fileViewer + photo));

    controller.occupationvalue.value =
        controller.occupations.firstWhere((e) => e.id == occupationId);
    controller.haircolorvalue.value =
        controller.haircolor.firstWhere((e) => e.name == hairColour);
    controller.eyecolorvalue.value =
        controller.eyecolor.firstWhere((e) => e.name == eyeColour);
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
    final abroadPhoneNumber = citizenModel.abroadPhoneNumber!;

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
    controller.phonenumber.text = abroadPhoneNumber;
  }

  void getDataForStep4() {
    final citizenModel = widget.citizenModel;

    if (citizenModel!.renewOriginIdApplications.isNotEmpty) {
      final passportNumber =
          citizenModel.renewOriginIdApplications.first.current_passport_number;

      final passportExpiryDate = citizenModel
          .renewOriginIdApplications.first.current_passport_expiry_date;

      final passportIssuedDate = citizenModel
          .renewOriginIdApplications.first.current_passport_expiry_date;

      final visaExpiryDate =
          citizenModel.renewOriginIdApplications.first.visa_expiry_date;

      final visaIssuedDate =
          citizenModel.renewOriginIdApplications.first.visa_issued_date;

      final visaTypeID =
          citizenModel.renewOriginIdApplications.first.visa_type_id!;

      final correctionTypeID =
          citizenModel.renewOriginIdApplications.first.correction_type_id;

      if (correctionTypeID != null) {
        controller.correctionTypevalue.value = controller.correctiontyoe
            .firstWhere((e) => e.id == correctionTypeID);
      }

      final visanumber =
          citizenModel.renewOriginIdApplications.first.visa_number;
      final orginIdNumber =
          citizenModel.renewOriginIdApplications.first.origin_id_number;

      controller.passportNumberContoller.text = passportNumber!;
      controller.passportExpiryDateController.text =
          passportExpiryDate.toString();

      controller.passportIssueDateController.text =
          passportIssuedDate.toString();

      controller.visaExpiryDateController.text = visaExpiryDate.toString();
      controller.visaIssueDateController.text = visaIssuedDate.toString();

      controller.visatypevalue.value =
          controller.visaType.firstWhere((e) => e.id == visaTypeID);

      controller.visanumberContoller.text = visanumber.toString();
      controller.orginIdnumberContoller.text = orginIdNumber.toString();
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

  void finalstep() {
    AppToasts.showSuccess("orgin id request Sent successfully");
    final MyOrderController controller = Get.put(MyOrderController());
    controller.getOrginOrder();
    Get.offAllNamed(Routes.MAIN_PAGE);
  }
}
