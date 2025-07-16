import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../../doctor/presentaion/screens/home_screen/data/models/post_model.dart';

class DoctorCard extends StatelessWidget {
  PostModel postModel;

  DoctorCard({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header Row: Logo + Center Name
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(postModel.imageUrl.trim()),
                  radius: 25.r,
                ),
                SizedBox(width: 12.h),
                Text(
                  postModel.centerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Job Title
            Text(
              postModel.content,
              textDirection: TextDirection.ltr,
              softWrap: true,

              style: TextStyle(
                fontSize: 18.sp,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),

            SizedBox(height: 8.h),

            // Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18.r,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                Text(
                  postModel.location,
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.work_outline, size: 18.r, color: Colors.white),
                SizedBox(width: 4.w),
                Text(
                  "${postModel.experienceYears} سنوات خبرة",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
