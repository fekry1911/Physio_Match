import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UpdateUserDataCubit>();
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.picture_as_pdf, color: Colors.red, size: 30.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "${cubit.doctortModel!.fullName!} CV",
                style: TextThemes.font16BlackBold.copyWith(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: Icon(Icons.open_in_new, color: AppColors.mainTealColor),
              onPressed: () {
                // فتح الرابط باستخدام launchUrl
                cubit.openPDFLink(cubit.doctortModel!.resume!);

                // أو لو عايز تستخدم url_launcher افتح الرابط مباشرة
              },
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        TextButton(onPressed: (){
          cubit.updateCv();
        }, child:Text("click to Edit"))
      ],
    );
  }
}
