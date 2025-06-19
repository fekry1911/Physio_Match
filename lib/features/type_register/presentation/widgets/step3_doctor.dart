import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../logic/type_register_cubit.dart';

class SetStep3ForDoctors extends StatelessWidget {
  const SetStep3ForDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TypeRegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.0.sign),
      child: Form(
        key: cubit.formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your Years of experience",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your Years of experience",
              validator: (validator){
                if(validator!.isEmpty) {
                  return  "Enter Your Years of experience";
                }
                return null;
              },
              controller: cubit.expController,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter Your Specialization ",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              hintText: "Enter Your Specialization",
              validator: (validator) {
                if(validator!.isEmpty) {
                  return "Enter Your Specialization";
                }
                return null;
              },
              controller: cubit.specializationController,
            ),
            SizedBox(height: 20.h,),
            Text(
              "Enter your Graduation year",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: (){
                cubit.selectDate(context);
              },
              child: SharedTextFormField(
                suffixIcon: Icon(Icons.calendar_today),
                hintText: "Enter your Graduation year",
                validator: (validator) {
                  if(validator!.isEmpty) {
                    return "Enter your Graduation year";
                  }
                  return null;
                },
                controller: cubit.graduationController,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
