import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/common/app_toasts.dart';
import 'package:ics/app/common/button/custom_normal_button.dart';
import 'package:ics/app/config/theme/app_assets.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:ics/app/modules/signup/views/widget/terms_view.dart';
import 'package:ics/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:connectivity/connectivity.dart';
import '../controllers/on_bording_controller.dart';

class OnBordingView extends GetView<OnBordingController> {
  const OnBordingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ///BUILD BG GRADIENT
          // buildBgGradient(),

          ///BUILD BG IMAGE
          //   buildBgImage(),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_2,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppSizes.mp_v_4,
                ),

                ///BUILD HEADER

                SizedBox(
                  height: 50.h,
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.currentSlide.value = index;

                      controller.onChangedFunction(index);
                    },
                    pageSnapping: true,
                    children: <Widget>[
                      sliderItem(imaUrl: AppAssets.onbording1),
                      sliderItem(imaUrl: AppAssets.onbording2),
                      sliderItem(imaUrl: AppAssets.onbording3),
                    ],
                  ),
                ),

                SmoothPageIndicator(
                  controller: controller.pageController, // PageController
                  count: 3,
                  effect: WormEffect(
                      activeDotColor: AppColors.secondary,
                      dotColor: AppColors.grayLighter,
                      dotHeight: 1.9.w,
                      dotWidth: 2.0.w), // your preferred effect
                  onDotClicked: (index) {},
                ),

                const Expanded(
                  child: SizedBox(),
                ),

                ///BUILD TITLE AND SUB TITLE
                buildTitlAndSubTitle(context),
                SizedBox(
                  height: 2.h,
                ),
                ////BUILD ACTION BUTTONS
                buildActionButtons(),

                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildBgGradient() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter * 0.4,
          colors: [
            AppColors.whiteOff,
            AppColors.whiteOff,
          ],
        ),
      ),
    );
  }

  buildBgImage() {
    return Image.asset(
      AppAssets.splasehimage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  sliderItem({required String imaUrl}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Image.asset(
        imaUrl,
        fit: BoxFit.contain,
        height: double.infinity,
      ),
    );
  }

  buildTitlAndSubTitle(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSizes.mp_v_2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.titles[controller.currentSlide.value],
                  textAlign: TextAlign.start,
                  style: AppTextStyles.displayTwoBold.copyWith(
                    fontSize: AppSizes.font_22,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        children: [
          CustomNormalButton(
            text: 'Log in',
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
            onPressed: () async {
              navigateToLogin();
            },
          ),
          SizedBox(
            height: AppSizes.mp_v_2,
          ),
          GestureDetector(
            onTap: () {
              Get.to(TermsView());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "New to ICS? Sign up!",
                textAlign: TextAlign.start,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.grayDefault,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// ...

  Future<void> navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 400));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I have internet

      Get.toNamed(Routes.LOGIN);
    } else {
      // I don't have internet
      AppToasts.showError("Network error, try again later");
    }
  }
}
