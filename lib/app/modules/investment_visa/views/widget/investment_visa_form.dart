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
import 'package:ics/app/modules/investment_visa/controllers/investment_visa_controller.dart';
import 'package:ics/app/modules/investment_visa/views/widget/steps/step_five_i_visa.dart';
import 'package:ics/app/modules/investment_visa/views/widget/steps/step_four_i_visa.dart';
import 'package:ics/app/modules/investment_visa/views/widget/steps/step_one_i_visa.dart';
import 'package:ics/app/modules/investment_visa/views/widget/steps/step_three_I_Visa.dart';
import 'package:ics/app/modules/investment_visa/views/widget/steps/step_two_i_visa.dart';

import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_six.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

class InvestmentVisaForm extends StatefulWidget {
  final IcsApplicationModel? citizenModel;

  const InvestmentVisaForm({
    this.citizenModel,
  });
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<InvestmentVisaForm> {
  final InvestmentVisaController controller =
      Get.find<InvestmentVisaController>();
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
        title: 'Investment',
        title2: "Visa Form",
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

                Obx(() =>
                    controller.networkStatus.value == NetworkStatus.LOADING
                        ? Center(child: CustomLoadingWidget())
                        : buildForm(context)),
                // Spacer(),
              ],
            ),
          ),
          Obx(
            () => controller.isSendStared.value
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
                key: controller.newPassportformKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                canPop: false,
                onPopInvoked: (didPop) {
                  _showAreYouSureDialog(context);
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      if (controller.currentStep == 0)
                        Step1_I_Visa(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 1)
                        Step2_I_Visa(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 2)
                        Step3_I_Visa(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 3)
                        Step4_I_Visa(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 4) Step5_I_Visa(),

                      if (controller.currentStep == 5) Step6(),

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
                        text: controller.currentStep == 5 ? 'Submit' : 'Next',
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
                          if (controller.currentStep == 3) {
                            // controller.handleDrawFinish();
                            controller.newPassportformKey.currentState!
                                    .saveAndValidate()
                                ? _showSummeryDiloag(context)
                                : SizedBox();
                          } else if (controller.currentStep == 4) {
                            checkdoc();
                          } else if (controller.currentStep == 5) {
                            finalstep(context);
                          } else {
                            if (controller.newPassportformKey.currentState!
                                .saveAndValidate()) {
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

  void finalstep(BuildContext context) {
    if (controller.selectedDate != null ||
        controller.selectedDateTime != null) {
      controller.sendBookedDates(context);
    } else {
      AppToasts.showError("Please select both a date and a time");
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

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
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
    final occupationId = citizenModel.occupation_id;
    final birthplace = citizenModel.birthPlace!;

    final birthCountryId = citizenModel.birthCountryId;
    final nationalityId = citizenModel.nationality_id;
    final gender = citizenModel.gender;
    final dateOfBirth = citizenModel.dateOfBirth!;

    controller.givenNameController.text = firstName;
    controller.surNameController.text = fatherName;
    controller.gendervalue.value =
        controller.gender.firstWhere((e) => e.name == gender);

    controller.birthplace.text = birthplace;

    controller.birthCountryvalue.value =
        controller.bcountries.firstWhere((e) => e.id == birthCountryId);
    controller.natinalityvalue.value =
        controller.natinality.firstWhere((e) => e.id == nationalityId);

    controller.dayController.text = dateOfBirth.day.toString();
    controller.monthController.text = dateOfBirth.month.toString();
    controller.yearController.text = dateOfBirth.year.toString();

    controller.occupationvalue.value =
        controller.occupations.firstWhere((e) => e.id == occupationId);
  }

  void getDataForStep2() {
    final citizenModel = widget.citizenModel;
    final address = citizenModel!.abroadAddress!;
    final phoneNumber = citizenModel.abroadPhoneNumber!;
    var addresscontry;
    // controller.adresscountryvalue.value =
    //     controller.allwoedCountries.firstWhere((e) => e.id == addresscontry);

    controller.addresscityController.text = address;
    controller.streetaddressController.text = address;
    controller.phonenumber.text = phoneNumber;
  }

  void getDataForStep3() {
    final citizenModel = widget.citizenModel;
  }

  _showSummeryDiloag(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox();
        // return SummaryDialogNewPassport(
        //   context: context,
        //   controller: controller,
        //   onTap: () {
        //     Navigator.pop(context);
        //     createCitizen();
        //   },
        // );
      },
    );
  }
}
