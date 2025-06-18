import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../logic/student_cubit.dart';

class SetStep3ForStudent extends StatelessWidget {
  const SetStep3ForStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<StudentRegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.0.sign),
      child: Form(
        key: cubit.formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your grade or year of graduate",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your grade or year of graduate",
              validator: (validator){
                if(validator!.isEmpty) {
                  return  "Enter Your grade or year of graduate";
                }
                return null;
              },
              controller: cubit.gradeController,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter Your Department  ",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your Department ",
              validator: (validator) {
                if(validator!.isEmpty) {
                  return "Enter Your Department ";
                }
                return null;
              },
              controller: cubit.departmentController ,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter your Gpa",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              suffixIcon: Icon(Icons.calendar_today),
              hintText: "Enter your Gpa",
              validator: (validator) {
                if(validator!.isEmpty) {
                  return "Enter your Gpa";
                }
                return null;
              },
              controller: cubit.gpaController,
            ),
          ],
        ),
      ),
    );
  }

}
