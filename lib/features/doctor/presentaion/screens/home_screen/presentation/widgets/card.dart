import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  String imageUrl;
  String name;
  String jobTitle;
  String location;
  String experience;

  DoctorCard({required this.imageUrl, required this.name,required this.jobTitle,required this.location,required this.experience,});

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
                  backgroundImage: NetworkImage(imageUrl.trim()),
                  radius: 25.r,
                ),
                SizedBox(width: 12.h),
                Text(
                  name!,
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
              jobTitle!,
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
                  location!,
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.work_outline, size: 18.r, color: Colors.black),
                SizedBox(width: 4.w),
                Text(
                  "${experience!} سنوات خبرة",
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
                  "Apply Now",
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
