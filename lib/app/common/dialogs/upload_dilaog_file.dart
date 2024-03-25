// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';

class UploadDialogFile extends StatelessWidget {
  final VoidCallback onUpload;
  final String title;
  final List<String> contentTexts;

  UploadDialogFile({
    required this.onUpload,
    required this.title,
    required this.contentTexts,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Add the image at the top of the list

          // Map over the contentTexts to create the list tiles
          ...contentTexts.map((text) {
            return ListTile(
              dense: true,
              visualDensity: VisualDensity.comfortable,
              title: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.primary,
                          size: 9,
                        ),
                        // Add some spacing between the icon and text
                      ],
                    ),
                  ),
                  Expanded(
                    flex:
                        9, // Give more flex to the text to allow it to occupy more space
                    child: Text(text,
                        style: AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.black,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Center the buttons horizontally
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.bodySmallRegular
                    .copyWith(color: AppColors.whiteOff),
              ),
            ),
            SizedBox(width: 8), // Add spacing between the buttons
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onUpload(); // Call the provided callback function
              },
              child: Text(
                'Upload',
                style: AppTextStyles.bodySmallRegular
                    .copyWith(color: AppColors.whiteOff),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
