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
import 'package:ics/app/modules/All_residency/controllers/all_residency_controller.dart';
import 'package:ics/app/modules/All_residency/data/model/residency_appliaction_model.dart';
import 'package:ics/app/modules/All_residency/views/widget/pdf_Page_residency.dart';
import 'package:ics/app/modules/All_residency/views/widget/steps/step_five_residency.dart';

import 'package:ics/app/modules/All_residency/views/widget/steps/step_four_residency.dart';
import 'package:ics/app/modules/All_residency/views/widget/steps/step_one_residency.dart';
import 'package:ics/app/modules/All_residency/views/widget/steps/step_three_residency.dart';
import 'package:ics/app/modules/All_residency/views/widget/steps/step_two_residency.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

class AllResidencyForm extends StatefulWidget {
  final IcsResidencyApplication? residencyApplicationModel;

  const AllResidencyForm({
    this.residencyApplicationModel,
  });
  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<AllResidencyForm> {
  final AllResidencyController controller = Get.find<AllResidencyController>();
  final ScrollController _scrollController = ScrollController();

  XFile? image;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    if (widget.residencyApplicationModel != null) {
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
        stoppop: false,
        title: controller.baseResidencyTypeModel.name.toString(),
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
                ? Center(child: CustomLoadingWidget())
                : SizedBox(),
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
                Icons.location_on,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.file_copy,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.delivery_dining,
                color: AppColors.whiteOff,
              ),
              Icon(
                Icons.edit_document,
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
                key: controller.residentformKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                canPop: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      if (controller.currentStep == 0)
                        Step1_residency(
                          citizenModel: widget.residencyApplicationModel,
                          controller: controller,
                        ),
                      //wal aseer enen en salalselefi uuser enelezina amenu wamainsali hayti  watable haqi watabale seber
                      if (controller.currentStep == 1)
                        Step2_Residency(
                          citizenModel: widget.residencyApplicationModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 2)
                        Step3_Residency(
                          citizenModel: widget.residencyApplicationModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 3)
                        Step4_Residency(
                          citizenModel: widget.residencyApplicationModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 4) Step5_Residency(),

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
                        text: controller.currentStep == 4 ? 'Submit' : 'Next',
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
                          if (controller.currentStep == 4) {
                            checkdoc();
                          } else {
                            if (controller.residentformKey.currentState!
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

  void checkdoc() async {
    if (controller.documents.isEmpty) {
      AppToasts.showError("Document are empty");
      return;
    } else if (controller.documents.any((element) => element.files.isEmpty)) {
      controller.networkStatus.value = NetworkStatus.ERROR;
      AppToasts.showError("Document must not be empty");
      return;
    } else {
      controller.residentformKey.currentState!.saveAndValidate()
          ? _showSummeryDiloag(context)
          : SizedBox();
    }
  }

  void finalstep(BuildContext context) {
    controller.send();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void getDataForStep1() {
    final residencyApplication = widget.residencyApplicationModel;
    final firstName = residencyApplication!.firstName;
    final fatherName = residencyApplication.fatherName;
    final grandfathername = residencyApplication.grandFatherName;
    final gender = residencyApplication.gender;
    final occupationId = residencyApplication.occupation.id;
    final email = residencyApplication.emailAddress;
    final phone = residencyApplication.phoneNumber;

    controller.firstName.text = firstName;
    controller.lastName.text = grandfathername;
    controller.middleName.text = fatherName;
    controller.gendervalue.value =
        controller.gender.firstWhere((e) => e.name == gender);

    controller.emailAdress.text = email;
    controller.occupationvalue.value =
        controller.occupations.firstWhere((e) => e.id == occupationId);

    phone.replaceAll(" ", ""); // Remove spaces
    int digitsCount =
        10; // Number of digits in the phone number excluding country code

    if (phone.length >= digitsCount) {
      String extractedNumber = phone.substring(phone.length - digitsCount);
      controller.phonenumber.text = extractedNumber;
    } else {
      // Handle the case where the phoneNumber length is less than digitsCount
      // You can throw an exception, display an error message, or handle it in any other appropriate way.
    }
  }

  void getDataForStep2() {
    final residencyApplication = widget.residencyApplicationModel;
    final citizenshipId = residencyApplication!.nationality.id;
    final abrodCountry = residencyApplication.abroadCountry.id;
    final localAddress = residencyApplication.localAddress;
    final region = residencyApplication.region.id;
    final woreda = residencyApplication.woreda;
    final keble = residencyApplication.kebele;
    controller.natinalityvalue.value =
        controller.natinality.firstWhere((e) => e.id == citizenshipId);

    controller.abrodcountryvalue.value =
        controller.allwoedCountries.firstWhere((e) => e.id == abrodCountry);

    controller.regionvalue.value =
        controller.regsions.firstWhere((e) => e.id == region);
    controller.localAddressController.text = localAddress;
    if (woreda != null) {
      controller.woredaContoller.text = woreda;
    } else {
      // Handle the case where woreda is null
    }

    if (keble != null) {
      controller.kebeleContoller.text = keble;
    } else {
      // Handle the case where keble is null
    }

    // controller.regionvalue.value =
    //     controller.region.firstWhere((e) => e.id == region);
  }

  void getDataForStep3() {
    final residencyApplication = widget.residencyApplicationModel;

    final passpornumber = residencyApplication!.passportNumber;
    final visanumber = residencyApplication.visaNumber;
    final passporissueDate = residencyApplication.passportIssuedDate;
    final passporexpiryDate = residencyApplication.passportExpiryDate;
    final workVsa = residencyApplication.visaWorkpermitIssuedDate;
    final visaRefernceNumber = residencyApplication.visaNumber;

    controller.passport_number.text = passpornumber.toString();
    controller.visa_number.text = visanumber.toString();
    controller.visa_Refernce_number.text = visaRefernceNumber.toString();

    controller.passportIssueDate.text = passporissueDate.toString();
    controller.passportexpiryDate.text = passporexpiryDate.toString();
    controller.workvisaIssueDate.text = workVsa.toString();
  }

  _showSummeryDiloag(BuildContext context) {
    Get.to(PdfPageAllResidency(
      context: context,
      controller: controller,
      onTap: () {
        finalstep(context);
      },
    ));
  }
}
