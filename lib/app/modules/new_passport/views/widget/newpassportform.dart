import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import 'package:ics/app/common/app_icon_button.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/common/loading/custom_loading_widget.dart';

import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:ics/app/modules/new_passport/data/model/citizens_model.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_five.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_four.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_one.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_three.dart';
import 'package:ics/app/modules/new_passport/views/widget/steps/step_two.dart';
import 'package:ics/app/routes/app_pages.dart';

import 'package:ics/gen/assets.gen.dart';

import 'package:im_stepper/stepper.dart';

import 'package:sizer/sizer.dart';

import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';

class NewPassportForm extends StatefulWidget {
  final IcsCitizenModel? citizenModel;

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                buildName(context),
                buildForm(context),
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
                onWillPop: () async {
                  _showAreYouSureDialog(context);
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      if (controller.currentStep == 0)
                        Step1(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 1)
                        Step2(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 2)
                        Step3(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),
                      if (controller.currentStep == 3)
                        Step4(
                          citizenModel: widget.citizenModel,
                          controller: controller,
                        ),

                      if (controller.currentStep == 4) Step5(),

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
                          ? AppColors.primary
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
                      text: controller.currentStep == 4 ? 'Submit' : 'Next',
                      textStyle: AppTextStyles.bodyLargeBold.copyWith(
                        color: AppColors.whiteOff,
                      ),
                      textcolor: AppColors.whiteOff,
                      buttoncolor: controller.currentStep == 4
                          ? AppColors.primary
                          : AppColors.grayLight,
                      borderRadius: AppSizes.radius_16,
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizes.mp_v_1,
                        horizontal: AppSizes.mp_w_6,
                      ),
                      onPressed: () async {
                        if (controller.currentStep == 3) {
                          controller.send();
                          await Future.delayed(const Duration(seconds: 1));
                          // Handle form submission
                          if (controller.isSend.value) {
                            setState(() {
                              controller.currentStep++;
                            });
                          }
                        } else if (controller.currentStep == 4) {
                          controller.checkdoc();
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
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  buildName(BuildContext context) {
    return Row(
      children: [
        AppSvgButton(
          imagePath: Assets.icons.arrowleft,
          onPressed: () {
            _showAreYouSureDialog(context);
          },
          size: AppSizes.icon_size_8 * 0.7,
        ),
        Text(
          'New Passport',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
        ),
        SizedBox(
          width: 1.w,
        ),
        Text(
          'Application',
          style: AppTextStyles.bodyLargeBold
              .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDark),
        ),
      ],
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
    controller.firstNameController.text = widget.citizenModel!.firstName!;
    controller.fatherNameController.text = widget.citizenModel!.father_name!;
    controller.grandFatherNameController.text =
        widget.citizenModel!.grand_father_name!;

    //amharic

    controller.AmfirstNameController.text =
        widget.citizenModel!.firstNameJson!.am!;
    controller.AmfatherNameController.text =
        widget.citizenModel!.fatherNameJson!.am!;
    controller.AmgrandFatherNameController.text =
        widget.citizenModel!.grandFatherNameJson!.am!;
    print(widget.citizenModel!.is_adopted);
    controller.isAdoption.value = widget.citizenModel!.is_adopted!;

    //country
    controller.birthCountryvalue.value = controller.bcountries
        .firstWhere((e) => e.id == widget.citizenModel!.birthCountryId);

    //country
    controller.natinalityvalue.value = controller.natinality
        .firstWhere((e) => e.id == widget.citizenModel!.birthCountryId);

    controller.gendervalue.value = controller.gender
        .firstWhere((e) => e.name == widget.citizenModel!.gender);

    // day
    controller.dayController.text =
        widget.citizenModel!.dateOfBirth!.day.toString();
    // month
    controller.monthController.text =
        widget.citizenModel!.dateOfBirth!.month.toString();
    // year
    controller.yearController.text =
        widget.citizenModel!.dateOfBirth!.year.toString();
  }

  void getDataForStep2() {
    controller.occupationvalue.value = controller.occupations
        .firstWhere((e) => e.id == widget.citizenModel!.occupation_id);
    controller.haircolorvalue.value = controller.haircolor
        .firstWhere((e) => e.name == widget.citizenModel!.hairColour);
    controller.eyecolorvalue.value = controller.eyecolor
        .firstWhere((e) => e.name == widget.citizenModel!.eyeColour);

    controller.skincolorvalue.value =
        widget.citizenModel!.skinColour!.toString();

    controller.height.text = widget.citizenModel!.height!.toString();

    controller.maritalstatusvalue.value = controller.martial
        .firstWhere((e) => e.name == widget.citizenModel!.maritalStatus);
  }

  void getDataForStep3() {
    controller.countryvalue.value = controller.allwoedCountries
        .firstWhere((e) => e.id == widget.citizenModel!.abroadCountryId);
    controller.getEmbassies(controller.countryvalue.value!.id);
    controller.addressController.text = widget.citizenModel!.abroadAddress!;
    controller.phonenumber.text = widget.citizenModel!.abroadPhoneNumber!;

    //   for emabassiy
    Future.delayed(const Duration(seconds: 2), () {
      controller.embassiesvalue.value = controller.base_embassies.firstWhere(
          (e) =>
              e.id ==
              widget.citizenModel!.newApplicationModel!.first.embassy_id);
    });
  }

  void getDataForStep4() {
    controller.familyModelvalue.value = widget.citizenModel!.familyModel!;
  }
}
