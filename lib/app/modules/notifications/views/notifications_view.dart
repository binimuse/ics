import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteOff,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SizedBox(
              height: 3.h,
            ),
            buildName(context),
            _buildCard(
              icon: Icons.notifications,
              title: 'New Message',
              subtitle: 'You have a new message',
              time: '10:30 AM',
              date: 'Aug 31, 2023',
            ),
            _buildCard(
              icon: Icons.notifications,
              title: 'New Message',
              subtitle: '2:00 PM',
              time: '1:45 PM',
              date: 'Sep 1, 2023',
            ),
// Add more notification cards here
            // Add more cards here
          ],
        ),
      ),
    );
  }

  buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            'My',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            'Notifications',
            style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16, color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required String date,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: AppColors.primary,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLargeBold.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 1.w),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 9.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 9.sp,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          size: 9.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          date,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 9.sp,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(width: 1.w),
                  ],
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            onTap: () {
              // Handle card tap
            },
          ),
        ],
      ),
    );
  }
}
