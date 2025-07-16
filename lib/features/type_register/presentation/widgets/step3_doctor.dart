import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../../register_screen/presentation/widgets/errr_setup.dart';
import '../../logic/type_register_cubit.dart';
import '../../logic/type_register_state.dart';

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
            ClipOval(
              child: Image.network(
                cubit.uploadedImageUrl!,
                height: 150.h,
                width: 150.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              onPressed: () {
                cubit.pickAndUploadImage();
              },
              child: Text("Click to Upload Your Image"),
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              color: AppColors.mainTealColor,
              textColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(),
              onPressed: () {
                cubit.pickAndUploadCV();
              },
              child: Text("Click to Upload Your CV"),
            ),
            SizedBox(height: 10.h,),
            if (cubit.UploadedPdf.isNotEmpty) ...[
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.mainTealColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red, size: 30.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        cubit.fileName ?? "Uploaded CV",
                        style: TextThemes.font16BlackBold.copyWith(color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.open_in_new, color: AppColors.mainTealColor),
                      onPressed: () {
                        // فتح الرابط باستخدام launchUrl
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("CV URL",style: TextThemes.font16BlackBold.copyWith(color: Colors.black87),),
                            content: GestureDetector(
                                onTap: () async {
                                  cubit.openPDFLink(cubit.UploadedPdf);
                                },
                                child: Text(cubit.UploadedPdf,style: TextThemes.font16BlackBold.copyWith(color: Colors.blue),)),
                          ),
                        );
                        // أو لو عايز تستخدم url_launcher افتح الرابط مباشرة
                      },
                    ),
                  ],
                ),
              ),
            ],
            BlocListener<TypeRegisterCubit, TypeRegisterState>(listener: (BuildContext context,  state) {
              if(state is UploadImageLoad){
                showDialog(
                  context: context,
                  builder:
                      (context) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainTealColor,
                    ),
                  ),
                );
              }
              if(state is UploadImageSucc){
                Navigator.pop(context);
              }
              if(state is UploadImageFail){
                Navigator.pop(context);
                setupState(
                  context,
                  error: "Upload Image Failed",
                  icon: Icons.error,
                  color: Colors.red, onpressed: (){},);
              }
            },
            child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
