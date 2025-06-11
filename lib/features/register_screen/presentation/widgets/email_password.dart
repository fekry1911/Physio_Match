import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/regexs/regexs.dart';
import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../cubit/register_cubit.dart';

class EmailAndPassword1 extends StatelessWidget {
  const EmailAndPassword1({
    super.key,
    required this.onTap,
    required this.isSecure,
  });

  final VoidCallback onTap;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          SharedTextFormField(
            prefixIcon: Icon(Icons.email, color: AppColors.mainTealColor),
            controller: context.read<RegisterCubit>().email,
            hintText: "Email",
            validator: (value) {
              if (value!.isEmpty && !isValidEmail(value)) {
                return "Please Enter Valid Email";
              }
              return null;
            },
          ),

          SizedBox(height: 16.h),
          SharedTextFormField(
            suffixIcon: IconButton(
              onPressed: onTap,
              icon:
                  !isSecure
                      ? Icon(Icons.visibility, color:AppColors.mainTealColor)
                      : Icon(Icons.visibility_off, color: AppColors.mainTealColor),
            ),
            prefixIcon: Icon(Icons.password, color: AppColors.mainTealColor),
            controller: context.read<RegisterCubit>().password,
            hintText: "Password",
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Valid Password";
              }
              return null;
            },
            isObscureText: isSecure,
          ),
          SizedBox(height: 16.h),
          SizedBox(height: 16.h),
          SharedTextFormField(
            maxLength: 11,
            prefixIcon: Icon(Icons.phone, color: AppColors.mainTealColor),
            controller: context.read<RegisterCubit>().phone,
            hintText: "phone",
            validator: (value) {
              if (value!.isEmpty && !isValidEmail(value)) {
                return "Please Enter Valid phone";
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          SharedTextFormField(
            maxLength: 22,
            prefixIcon: Icon(Icons.person, color:  AppColors.mainTealColor),
            controller: context.read<RegisterCubit>().name,
            hintText: "name",
            validator: (value) {
              if (value!.isEmpty && !isValidEmail(value)) {
                return "Please Enter Valid name";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
