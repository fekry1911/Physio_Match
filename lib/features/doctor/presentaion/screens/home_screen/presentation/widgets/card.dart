import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/post_model.dart';
import '../../logic/get_posts_cubit.dart';

class DoctorCard extends StatelessWidget {
  PostModel postModel;
  bool applied = false;

  DoctorCard({required this.postModel,this.applied=false});

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
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.read<GetPostsCubit>().savePost(
                      PostModel(
                        id: postModel.id,
                        centerName: postModel.centerName,
                        imageUrl: postModel.imageUrl,
                        content: postModel.content,
                        experienceYears: postModel.experienceYears,
                        location: postModel.location,
                        imagePostUrl: postModel.imagePostUrl,
                        date: postModel.date,
                        isSaved: true,
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/icons/saved.png",
                    height: 40.h,
                    width: 40.w,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Job Title
            Text(
              postModel.content,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),

            SizedBox(height: 12.h),

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
                  postModel.location!,
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.work_outline, size: 18.r, color: Colors.black),
                SizedBox(width: 4.w),
                Text(
                  "${postModel.experienceYears!} سنوات خبرة",
                  style: TextThemes.font16BlackBold.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),

            !applied! ?SizedBox(height: 16.h):SizedBox(),

            // Apply Button
            !applied! ?
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<GetPostsCubit>().applyNow(postModel);
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
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
