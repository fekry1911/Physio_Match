import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/const.dart';
import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/shared_widgets/snack_bar.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../logic/update_user_data_cubit.dart';

void showEditProfileDialog(BuildContext context) {
  final cubit = context.read<UpdateUserDataCubit>();

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<UpdateUserDataCubit, UpdateUserDataState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
            // 👈 تقليل الهامش
            backgroundColor: Colors.white,
            child: SizedBox(
              width: ScreenUtil().screenWidth, // 👈 Full width فعليًا
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Edit Profile',
                          style: TextThemes.font18BlackSemiBold.copyWith(
                            color: AppColors.mainTealColor,
                          ),
                        ),
                        SharedTextFormField(
                          controller: cubit.name,
                          maxLength: 22,
                          hintText: "name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter phone";
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        SharedTextFormField(
                          controller: cubit.phone,
                          maxLength: 11,
                          hintText: "phone",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter phone";
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: TextThemes.font16BlackBold.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Spacer(),
                            MaterialButton(
                              color: Colors.teal,
                              shape: RoundedRectangleBorder(),
                              onPressed: () {
                               if(cubit.formKey.currentState!.validate()){
                                 cubit.updateData();
                               }
                              },
                              child: Text(
                                'Save',
                                style: TextThemes.font16BlackBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocListener<UpdateUserDataCubit, UpdateUserDataState>(
                          listener: (BuildContext context, state) {
                            if (state is UpdateUserDataLoad) {
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
                            if (state is UpdateUserDataDone) {
                              context.pushNamed(doctorHomeScreen,arguments: 2);
                            }
                            if (state is UpdateUserDataFail) {
                              AwesomeSnackBar(
                                context: context,
                                tittle: "SignOut Error",
                                message: state.error,
                              );
                            }
                          },
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
