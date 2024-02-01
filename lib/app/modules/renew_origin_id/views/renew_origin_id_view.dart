import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:ics/app/common/app_icon_button.dart';


import 'package:ics/app/common/customappbar.dart';


import 'package:ics/app/config/theme/app_colors.dart';


import 'package:ics/app/config/theme/app_sizes.dart';


import 'package:ics/app/config/theme/app_text_styles.dart';


import 'package:ics/app/modules/renew_origin_id/data/model/confirmation_model_orginid.dart';


import 'package:ics/app/modules/renew_origin_id/views/widget/renew_origin_id_type.dart';


import 'package:ics/gen/assets.gen.dart';


import 'package:sizer/sizer.dart';


import 'package:flutter_svg/flutter_svg.dart';


import '../controllers/renew_origin_id_controller.dart';


class RenewOriginIdView extends GetView<RenewOriginIdController> {

  const RenewOriginIdView({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(

        title: 'ReNew',

        title2: "Origin ID Type",

        showLeading: true,

      ),

      backgroundColor: AppColors.whiteOff,

      body: Padding(

        padding: const EdgeInsets.all(12.0),

        child: ListView(

          children: [

            SizedBox(

              height: 1.h,

            ),


            buildAdditionalCard(),


            // Spacer(),

          ],

        ),

      ),

    );

  }


  Widget buildAdditionalCard() {

    return GestureDetector(

      onTap: () {

        // controller.toggleTerm(index);

      },

      child: Padding(

        padding: const EdgeInsets.all(8.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text('Applicant Type',

                style: AppTextStyles.bodySmallRegular.copyWith(

                  color: AppColors.grayDark,

                )),

            SizedBox(height: 2.h),

            FutureBuilder<List<ReNewOrginIdConfirmationModel>>(

              future: controller.fetchorginId(),

              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {

                  return Center(

                    child: CircularProgressIndicator(

                      color: AppColors.primary,

                    ),

                  );

                } else if (snapshot.hasError) {

                  return Text('Error: ${snapshot.error}');

                } else if (snapshot.hasData) {

                  final List<ReNewOrginIdConfirmationModel> confirmationList =

                      snapshot.data!;


                  return ListView.builder(

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: confirmationList.length,

                    itemBuilder: (context, index) {

                      final confirmation = confirmationList[index];


                      return Obx(() => GestureDetector(

                            onTap: () {

                              Get.to(() => ReNewOriginIdViewType());

                            },

                            child: Container(

                              margin: const EdgeInsets.symmetric(vertical: 8.0),

                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(12.0),

                                  border: Border.all(

                                    color: AppColors.grayLight.withOpacity(0.9),

                                    width: 1.0,

                                  ),

                                  color: Colors.transparent),

                              child: Row(

                                crossAxisAlignment: CrossAxisAlignment.center,

                                mainAxisAlignment:

                                    MainAxisAlignment.spaceBetween,

                                children: [

                                  Padding(

                                    padding: const EdgeInsets.all(8.0),

                                    child: Row(

                                      crossAxisAlignment:

                                          CrossAxisAlignment.start,

                                      mainAxisAlignment:

                                          MainAxisAlignment.center,

                                      children: [

                                        SvgPicture.asset(

                                          confirmation.image,

                                          color:

                                              !controller.isTermChecked(index)

                                                  ? AppColors.grayLight

                                                  : AppColors.primary,

                                        ),

                                        SizedBox(width: 3.w),

                                        Column(

                                          crossAxisAlignment:

                                              CrossAxisAlignment.start,

                                          mainAxisAlignment:

                                              MainAxisAlignment.center,

                                          children: [

                                            Text(

                                              confirmation.name,

                                              style: AppTextStyles.bodySmallBold

                                                  .copyWith(

                                                fontSize: 12.sp,

                                                color: AppColors.black,

                                              ),

                                            ),

                                            SizedBox(

                                              width: 25.h,

                                              child: Text(

                                                overflow: TextOverflow.fade,

                                                maxLines: 6,

                                                confirmation.description,

                                                style: AppTextStyles

                                                    .captionRegular

                                                    .copyWith(

                                                  color: AppColors.black,

                                                  fontSize: 9.sp,

                                                ),

                                              ),

                                            ),

                                          ],

                                        ),

                                      ],

                                    ),

                                  ),

                                  Padding(

                                    padding: const EdgeInsets.all(12.0),

                                    child: Container(

                                      width: 8.w,

                                      height: 8.w,

                                      decoration: BoxDecoration(

                                        color: AppColors

                                            .primary, // Specify the color of the background


                                        borderRadius: BorderRadius.circular(

                                            40), // Make the container circular

                                      ),

                                      child: ClipOval(

                                        child: AppSvgButton(

                                          iconColor: AppColors.whiteOff,

                                          imagePath: Assets.icons.arrowright,

                                          onPressed: () {

                                            Get.back();

                                          },

                                          size: AppSizes.icon_size_8 * 0.7,

                                        ),

                                      ),

                                    ),

                                  )

                                ],

                              ),

                            ),

                          ));

                    },

                  );

                } else {

                  return Container();

                }

              },

            ),

          ],

        ),

      ),

    );

  }

}

