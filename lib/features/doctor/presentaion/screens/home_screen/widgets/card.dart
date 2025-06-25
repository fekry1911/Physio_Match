import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header Row: Logo + Center Name
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://as1.ftcdn.net/jpg/03/04/90/28/1000_F_304902822_RhvrRzzXR15rCfXfIjlNdOd0nwVX1iwI.jpg",
                  ),
                  radius: 25.r,
                ),
                SizedBox(width: 12.h),
                Text(
                  "spinal health care medical",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.more_horiz, color: Colors.black),
              ],
            ),

            SizedBox(height: 12.h),

            // Job Title
            Text(
              "مطلوب أخصائي علاج طبيعي",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),

            SizedBox(height: 8),

            // Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18.r,
                  color: Colors.black,
                ),
                SizedBox(width: 4.w),
                Text(
                  "القاهره",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.work_outline, size: 18.r, color: Colors.black),
                SizedBox(width: 4.w),
                Text(
                  " 4 سنوات خبرة",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // تنفيذ تقديم الوظيفة
                  print("✅ User applied to ");
                },
                icon: Icon(Icons.send, color: Colors.white),
                label: Text(
                  "تقديم الآن",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
