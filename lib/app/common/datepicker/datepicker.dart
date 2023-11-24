// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:ics/app/config/theme/app_colors.dart';
// import 'package:ics/app/config/theme/app_sizes.dart';
// import 'package:ics/app/config/theme/app_text_styles.dart';
// import 'package:ics/app/modules/new_passport/controllers/new_passport_controller.dart';

// import 'package:sizer/sizer.dart';

// class LinearDatePicker extends StatefulWidget {
//   @override
//   _LinearDatePickerState createState() => _LinearDatePickerState();
// }

// class _LinearDatePickerState extends State<LinearDatePicker> {
//   final NewPassportController controller = Get.find<NewPassportController>();
//   List<String> months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Month Picker Widget
//           Container(
//             width: 42.w,
//             height: 20.h,
//             child: CupertinoPicker(
//               useMagnifier: true,
//               selectionOverlay: Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.grayLighter.withOpacity(0.2),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(35),
//                         bottomLeft: Radius.circular(35))),
//               ),
//               itemExtent: 45.0,
//               squeeze: 1,

//               magnification: 1.0,
//               diameterRatio: 10.0, // Remove magnification effect
//               scrollController: FixedExtentScrollController(
//                 initialItem: controller.selectedMonth.value -
//                     1, // Set initial selected month
//               ),
//               onSelectedItemChanged: (int index) {
//                 setState(() {
//                   controller.selectedMonth.value =
//                       index + 1; // Example: 1 + index
//                 });
//               },
//               children: List<Widget>.generate(12, (int index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 60.0,
//                       vertical: 8.0), // Add vertical spacing here
//                   child: Text(
//                     months[index],
//                     style: index == controller.selectedMonth.value - 1
//                         ? AppTextStyles.titleBold.copyWith(
//                             fontSize:
//                                 AppSizes.font_16) // Selected month text style
//                         : AppTextStyles.titleRegular.copyWith(
//                             fontSize: AppSizes
//                                 .font_14), // Unselected month text style
//                   ),
//                 );
//               }),
//             ),
//           ),
//           // Year Picker Widget
//           Container(
//             width: 40.w,
//             height: 20.h,
//             child: Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: CupertinoPicker(
//                 useMagnifier: false,
//                 selectionOverlay: Container(
//                   decoration: BoxDecoration(
//                       color: AppColors.grayLighter.withOpacity(0.2),
//                       backgroundBlendMode: BlendMode.darken,
//                       borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(35),
//                           topRight: Radius.circular(35))),
//                 ),
//                 itemExtent: 45.0, // Adjust this value
//                 squeeze: 1,
//                 magnification: 1.0,
//                 diameterRatio: 10.0, // Adjust this value
//                 scrollController: FixedExtentScrollController(
//                   initialItem: controller.selectedYear.value -
//                       2000, // Set initial selected year
//                 ),
//                 onSelectedItemChanged: (int index) {
//                   setState(() {
//                     controller.selectedYear.value =
//                         index + 2000; // Example: 2000 + index
//                   });
//                 },
//                 children: List<Widget>.generate(50, (int index) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 1.0, vertical: 8.0), // Add padding here
//                     child: Text(
//                       (2000 + index).toString(),
//                       style: index == controller.selectedYear.value - 2000
//                           ? AppTextStyles.titleBold.copyWith(
//                               fontSize:
//                                   AppSizes.font_16) // Selected year text style
//                           : AppTextStyles.titleRegular.copyWith(
//                               fontSize: AppSizes
//                                   .font_14), // Unselected year text style
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
