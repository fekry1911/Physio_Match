import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/const.dart';
import '../../../../core/regexs/regexs.dart';
import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/colors/colors.dart';
import '../../logic/cubit/login_cubit.dart';

class EmailAndPassword extends StatelessWidget {
   const EmailAndPassword({super.key,required this.onTap,required this.isSecure});
   final VoidCallback onTap;
   final bool isSecure;


   @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          SharedTextFormField(
            prefixIcon: Icon(Icons.email,color:  AppColors.mainTealColor),
            controller: context.read<LoginCubit>().emailController,
            hintText: "Email",
            validator: (value) {
              if (value!.isEmpty && !isValidEmail(value)) {
                return "Please Enter Valid Email";
              }
              return null;
            }, keyboardType: TextInputType.emailAddress,
          ).animate().slideX(duration: durationAnimate.ms, begin: -1.0, end: 0.0),
          SizedBox(height: 16.h),
          SharedTextFormField(
            suffixIcon: IconButton(onPressed: onTap, icon:!isSecure?Icon(Icons.visibility,color: AppColors.mainTealColor,):Icon(Icons.visibility_off,color: AppColors.mainTealColor,),),
            prefixIcon: Icon(Icons.password,color:  AppColors.mainTealColor,),
            controller: context.read<LoginCubit>().passwordController,
            hintText: "Password",
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Valid Email";
              }
              return null;
            },
            isObscureText: isSecure, keyboardType: TextInputType.text,
          ).animate().slideX(duration: durationAnimate.ms, begin: 1.0, end: 0.0),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
