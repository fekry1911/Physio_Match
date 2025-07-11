import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalCenterCard extends StatelessWidget {
  final String name;
  final String phone;
  final String imageUrl;

  const HorizontalCenterCard({
    super.key,
    required this.name,
    required this.phone,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding:  EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          // صورة دائرية
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl.trim(),
              width: 70.w,
              height: 70.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70.w,
                height: 70.h,
                color: Colors.grey[800],
                child:  Icon(Icons.person, color: AppColors.blackColor, size: 32.r),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // البيانات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:  TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16.r, color: Colors.grey),
        ],
      ),
    );
  }
}
