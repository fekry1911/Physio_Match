import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../logic/student_cubit.dart';

class SetUniAndYearAndCity extends StatelessWidget {
  const SetUniAndYearAndCity({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<StudentRegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.0.sign),
      child: Form(
        key: cubit.formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your university Name",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your university Name",
              validator: (validator){
                if(validator!.isEmpty) {
                  return  "Enter Your university Name";
                }
                return null;
              },
              controller: cubit.universityController,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter Your city",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your city",
              validator: (validator) {
                if(validator!.isEmpty) {
                  return "please Enter city";
                }
                return null;
              },
              controller: cubit.cityController,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter Your Birth"
                  "day",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                cubit.selectDate(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(Icons.calendar_today),
                enabled: false,
                hintText: "Enter  to pick Your BirthDay",
                validator: (validator) {
                  if(validator!.isEmpty) {
                    return "please Enter BirthDay";
                  }
                  return null;
                },
                controller: cubit.yearController,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
