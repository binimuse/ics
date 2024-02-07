import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class ProfileFourDialog extends StatelessWidget {
  const ProfileFourDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 2.h),
              _buildTitle("Personal Detail"),
              _buildExperienceRow(
                  company: "Date of birth(GC)",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Local Phone Number",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Email",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Birth Place",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Birth Place",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Birth Place",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Birth Place",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Birth Place",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Hight",
                  position: "Wordpress Developer",
                  duration: ""),
              _buildExperienceRow(
                  company: "Eye Color",
                  position: "Wordpress Developer",
                  duration: ""),
              const SizedBox(height: 30.0),
              _buildTitle("Experience"),
              _buildExperienceRow(
                  company: "GID Nepal",
                  position: "Wordpress Developer",
                  duration: "2010 - 2012"),
              _buildExperienceRow(
                  company: "Lohani Tech",
                  position: "Laravel Developer",
                  duration: "2012 - 2015"),
              _buildExperienceRow(
                  company: "Popup Bits Pvt. Ltd.",
                  position: "Web Developer",
                  duration: "2015 - 2018"),
              _buildExperienceRow(
                  company: "Popup Bits Pvt. Ltd.",
                  position: "Flutter Developer",
                  duration: "2018 - Current"),
              const SizedBox(height: 20.0),
              _buildTitle("Education"),
              const SizedBox(height: 5.0),
              _buildExperienceRow(
                  company: "Tribhuvan University, Nepal",
                  position: "B.Sc. Computer Science and Information Technology",
                  duration: "2011 - 2015"),
              _buildExperienceRow(
                  company: "Cambridge University, UK",
                  position: "A Level",
                  duration: "2008 - 2010"),
              _buildExperienceRow(
                  company: "Nepal Board", position: "SLC", duration: "2008"),
              const SizedBox(height: 20.0),
              _buildTitle("Contact"),
              const SizedBox(height: 5.0),
              Row(
                children: const <Widget>[
                  SizedBox(width: 30.0),
                  Icon(
                    Icons.mail,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "dlohani48@gmail.com",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: const <Widget>[
                  SizedBox(width: 30.0),
                  Icon(
                    Icons.phone,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "+977-9818523107",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCancelButton(context),
                  SizedBox(width: 5.w),
                  buildYesButton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildExperienceRow({
    required String company,
    String? position,
    String? duration,
  }) {
    return ListTile(
      visualDensity:
          VisualDensity.compact, // Add this line to reduce the vertical spacing
      contentPadding: EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 5.0), // Add this line to adjust the vertical padding
      leading: Icon(
        Icons.circle,
        size: 8.0, // Adjust the size of the icon here
        color: Colors.black54,
      ),
      title: Text(
        company,
        style: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_10,
        ),
      ),
      subtitle: Text(
        "$position",
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_10,
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.black,
              fontSize: AppSizes.font_14,
            ),
          ),
          const Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        SizedBox(
            width: 80.0,
            height: 80.0,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 35.0,
                ))),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Damodar Lohani",
              style: AppTextStyles.bodyLargeBold
                  .copyWith(color: AppColors.primary),
            ),
            SizedBox(height: 1.h),
            Text(
              "Damodar Lohani",
              style: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.black,
                fontSize: AppSizes.font_14,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Kathmandu, Nepal",
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_10,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(false); // Return false if cancel is pressed
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
            style:
                AppTextStyles.bodyLargeBold.copyWith(color: AppColors.whiteOff),
          ),
        ),
      ),
    );
  }

  buildYesButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        // Get.offAllNamed(Routes.MAIN_PAGE);
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
            style:
                AppTextStyles.bodyLargeBold.copyWith(color: AppColors.whiteOff),
          ),
        ),
      ),
    );
  }
}
