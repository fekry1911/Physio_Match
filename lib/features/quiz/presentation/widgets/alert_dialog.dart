
import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors.dart';
import '../../logic/save_score_cubit.dart';

void AwesomeDialog({required context,required correct,required widget,required SaveScoreCubit cubit}){
   showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.mainTealColor, size: 30.r),
          SizedBox(width: 8.w),
          Text(
            "Result",
            style: TextStyle(
              color: AppColors.mainTealColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
      content: Text(
        "You got $correct / ${widget.questions.length} correct!",
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black87,
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainTealColor,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () {
              cubit.saveScore(
                correctAnswers: correct,
                totalQuestions: widget.questions.length, uid: CacheHelper.getString(key: "uid"),
              );
              },
            child: Text(
              "Save and Back to Home",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );

}