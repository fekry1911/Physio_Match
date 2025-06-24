import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/shared_widgets/shared_text_form_field.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/register_screen/cubit/register_cubit.dart';
import 'package:add_ques/features/type_register/presentation/widgets/step1_name_phone.dart';
import 'package:add_ques/features/type_register/presentation/widgets/step2_year_city_uni.dart';
import 'package:add_ques/features/type_register/presentation/widgets/step3_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../logic/type_register_cubit.dart';
import '../logic/type_register_state.dart';

class TypeRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TypeRegisterCubit, TypeRegisterState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<TypeRegisterCubit>(context);
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.mainTealColor,
                  onSurface: Colors.grey, // لون الخطوات الغير نشطة
                ),
                canvasColor: Colors.white, // خلفية الـ stepper
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Stepper(
                      type: StepperType.horizontal,
                      currentStep: cubit.currentStep,
                      physics: ClampingScrollPhysics(),
                      onStepTapped: (int step) {
                        cubit.setCurrentStep(step);
                      },
                      onStepContinue: () {
                        if (cubit.formKeys[cubit.currentStep].currentState!.validate() && cubit.isSelectedGender ) {
                          cubit.nextStep();
                        }
                      },
                      onStepCancel: cubit.previousStep,

                      controlsBuilder: (
                        BuildContext context,
                        ControlsDetails details,
                      ) {
                        return Padding(
                          padding:  EdgeInsets.only(top: 20.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: details.onStepCancel,
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: details.onStepContinue,
                                child: cubit.currentStep!=2?Text('Continue'):Text("submit"),
                              ),
                            ],
                          ),
                        );
                      },
                      steps: [
                        Step(
                          title: Text(
                            'Step 1',
                            style: TextThemes.font14LightDarkRegular.copyWith(
                              color: AppColors.mainTealColor,
                            ),
                          ),
                          content: Center(child: SetNameAndPhone()),
                          isActive: cubit.currentStep >= 0,
                        ),
                        Step(
                          title: Text(
                            'Step 2',
                            style: TextThemes.font14LightDarkRegular.copyWith(
                              color:
                                  cubit.currentStep >= 1
                                      ? AppColors.mainTealColor
                                      : Colors.grey,
                            ),
                          ),
                          content: SetUniAndYearAndCity(),
                          isActive: cubit.currentStep >= 1,
                        ),
                        Step(
                          title: Text(
                            'Step 3',
                            style: TextThemes.font14LightDarkRegular.copyWith(
                              color:
                                  cubit.currentStep >= 2
                                      ? AppColors.mainTealColor
                                      : Colors.grey,
                            ),
                          ),
                          content: SetStep3ForDoctors(),
                          isActive: cubit.currentStep >= 2,
                        ),
                      ],
                    ),
                  ),
                  BlocListener<TypeRegisterCubit, TypeRegisterState>(
                    listener: (BuildContext context, state) {
                      if (state is StudentSubmitLoading) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              semanticsLabel: "loading",
                            ),
                          ),
                        );
                      }
                      if (state is StudentSubmitted) {
                        context.pushAndRemoveUntil(homeDeciderScreen);
                      }
                      if (state is StudentSubmitFailed) {
                        AwesomeSnackBar(
                          context: context,
                          tittle: "error",
                          message: state.error,
                        );
                      }
                    },
                    child: SizedBox.shrink(),
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
