import 'package:add_ques/core/shared_widgets/shared_text_form_field.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/type_register_cubit.dart';

class SetNameAndPhone extends StatelessWidget {
  const SetNameAndPhone({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TypeRegisterCubit>(context);
    return Padding(
      padding: EdgeInsets.all(20.0.sign),
      child: Form(
        key: cubit.formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your Name",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              enabled: false,
              hintText: "Enter Your Name",
              validator: (validator){
                if(validator!.isEmpty) {
                 return "please Enter Your Name";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              controller: cubit.nameController,
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter Your Phone Number",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            SharedTextFormField(
              enabled: false,
              maxLength: 11,
              hintText: "Enter Your Phone Number",
              validator: (validator) {
                if(validator!.isEmpty) {
                 return "please Enter Your Phone Number";
                }
                return null;
              },
              controller: cubit.phoneController,
                keyboardType: TextInputType.phone
            ),

            SizedBox(height: 25.h),

            SizedBox(height: 25.h),
            Text(
              "Select your Gender",
              style: TextThemes.font16BlackBold.copyWith(
                color: AppColors.mainTealColor,
              ),
            ),
            SizedBox(height: 15.h),
            ListTile(
              title: Text("male"),
              leading: Radio<String>(
                value: "male",
                groupValue: cubit.selectedGender,
                onChanged: (value) {
                  cubit.changeGender(value!);
                },
              ),
            ),
            ListTile(
              title: Text("female"),
              leading: Radio<String>(
                value: "female",
                groupValue: cubit.selectedGender,
                onChanged: (value) {
                  cubit.changeGender(value!);
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
