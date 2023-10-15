import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ics/app/config/theme/app_colors.dart';
import 'package:ics/app/config/theme/app_sizes.dart';
import 'package:ics/app/config/theme/app_text_styles.dart';
import 'package:sizer/sizer.dart';

class MyFormBuilderStepper extends StatefulWidget {
  @override
  _MyFormBuilderStepperState createState() => _MyFormBuilderStepperState();
}

class _MyFormBuilderStepperState extends State<MyFormBuilderStepper> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  int _currentStep = 0;
  bool _formCompleted = false;

  List<Step> _formSteps = [
    Step(
      title: IconTheme(
        data: IconThemeData(color: Colors.red), // Change the icon color here
        child: Text('Step 1'),
      ),
      content: Column(
        children: <Widget>[
          FormBuilderTextField(
            name: 'name',
            decoration: InputDecoration(labelText: 'Name'),
            // validator: FormBuilderValidators.required(context),
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: Text(
        'Step 2',
        style: AppTextStyles.bodyLargeRegular
            .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDefault),
      ),
      content: Column(
        children: <Widget>[
          FormBuilderDateTimePicker(
            name: 'date',
            inputType: InputType.date,
            //   format: DateFormat('yyyy-MM-dd'),
            decoration: InputDecoration(labelText: 'Date'),
            //   validator: FormBuilderValidators.required(context),
          ),
        ],
      ),
      isActive: false,
    ),
    Step(
      title: Text(
        'Step 3',
        style: AppTextStyles.bodyLargeRegular
            .copyWith(fontSize: AppSizes.font_16, color: AppColors.grayDefault),
      ),
      content: Column(
        children: <Widget>[
          FormBuilderDropdown(
            name: 'gender',
            decoration: InputDecoration(labelText: 'Gender'),
            hint: Text('Select Gender'),
            //  validator: FormBuilderValidators.required(context),
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text('$gender'),
                    ))
                .toList(),
          ),
        ],
      ),
      isActive: false,
    ),
  ];

  void _submitForm() {
    if (_fbKey.currentState!.saveAndValidate()) {
      print(_fbKey.currentState!.value);
      setState(() {
        _formCompleted = true;
      });
    } else {
      print('Form validation failed');
    }
  }

  void _nextStep() {
    if (_fbKey.currentState!.saveAndValidate()) {
      setState(() {
        _currentStep++;
        _formSteps = _getSteps();
      });
    } else {
      print('Form validation failed');
    }
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
      _formSteps = _getSteps();
    });
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: IconTheme(
          data: IconThemeData(color: Colors.red), // Change the icon color here
          child: Text('Step 1'),
        ),
        content: Column(
          children: <Widget>[
            FormBuilderTextField(
              name: 'name',
              decoration: InputDecoration(labelText: 'Name'),
              // validator: FormBuilderValidators.required(context),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          'Step 2',
          style: AppTextStyles.bodyLargeRegular.copyWith(
              fontSize: AppSizes.font_16, color: AppColors.grayDefault),
        ),
        content: Column(
          children: <Widget>[
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.date,
              //   format: DateFormat('yyyy-MM-dd'),
              decoration: InputDecoration(labelText: 'Date'),
              //   validator: FormBuilderValidators.required(context),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Step 3',
          style: AppTextStyles.bodyLargeRegular.copyWith(
              fontSize: AppSizes.font_16, color: AppColors.grayDefault),
        ),
        content: Column(
          children: <Widget>[
            FormBuilderDropdown(
              name: 'gender',
              decoration: InputDecoration(labelText: 'Gender'),
              hint: Text('Select Gender'),
              //  validator: FormBuilderValidators.required(context),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                  .toList(),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 75.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                buildName(context),
                buildForm(),
              ],
            ),
          ),
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
            'New',
            style: AppTextStyles.bodyLargeBold
                .copyWith(fontSize: AppSizes.font_16, color: AppColors.primary),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            'Passport',
            style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16, color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }

  buildForm() {
    return SizedBox(
      height: 75.h,
      child: FormBuilder(
        key: _fbKey,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: _nextStep,
          onStepCancel: _previousStep,
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          steps: _formSteps,
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (_currentStep != 0)
                    ElevatedButton(
                      onPressed: controls.onStepCancel,
                      child: Text('Back'),
                    ),
                  if (_currentStep != _formSteps.length - 1)
                    ElevatedButton(
                      onPressed: controls.onStepContinue,
                      child: Text('Next'),
                    ),
                  if (_currentStep == _formSteps.length - 1)
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
