import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class BuildDocViewer extends StatefulWidget {
  final String pdfPath;

  const BuildDocViewer({required this.pdfPath});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDocViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryLighter.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.file_copy,
            color: AppColors.primary,
          ),
          SizedBox(height: 1.h),
          Text(
            'Text',
            style: AppTextStyles.bodySmallBold.copyWith(
              color: AppColors.primary,
            ),
          ),
          Container(
            height: 25.h,
            child: PDFView(
              filePath: widget.pdfPath,
            ),
          ),
        ],
      ),
    );
  }
}
