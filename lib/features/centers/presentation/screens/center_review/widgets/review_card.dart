import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String reviewDate;
  final double rating; // from 1 to 5
  final String reviewText;
  final List<String> reviewImages;

  const ReviewCard({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.reviewDate,
    required this.rating,
    this.reviewText="",
    this.reviewImages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      margin:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding:  EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                  radius: 24.r,
                ),
                 SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style:  TextStyle(fontWeight: FontWeight.bold,color: AppColors.blackColor,fontSize: 15.sp)),
                      SizedBox(height: 2.h,),
                      Text(reviewDate, style:  TextStyle(color: AppColors.greyDark, fontSize: 12.sp,)),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                        (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 17.r,
                    ),
                  ),
                ),
              ],
            ),

             SizedBox(height: 25.h),

            /// Review Text
           reviewText==""? SizedBox():Text(
              reviewText.trim(),
              style:  TextStyle(fontSize: 18.sp, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
