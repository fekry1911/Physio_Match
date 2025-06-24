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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(200.r),
                child: Image.network(cubit.uploadedImageUrl!,height: 150.h,width: 150.w,fit: BoxFit.cover)),
            SizedBox(height: 10.h),
            MaterialButton(onPressed: (){
              cubit.pickAndUploadImage();
            },child: Text("Click to Upload Your Image"),),
            SizedBox(height: 10.h),
            MaterialButton(
              color: AppColors.mainTealColor,
              textColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(),
              onPressed: (){
              cubit.pickAndUploadCV();
            },child: Text("Click to Upload Your CV"),),
            cubit.UploadedPdf==""?Text("${cubit.UploadedPdf}",style: TextThemes.font16BlackBold.copyWith(color: AppColors.mainTealColor),):SizedBox(),
          ],
        ),
      ),
    );
  }

}
