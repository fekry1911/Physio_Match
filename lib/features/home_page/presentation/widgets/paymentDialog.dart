import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/const/const.dart';

void showPaymentDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة داخل دائرة
            CircleAvatar(
              backgroundColor: Colors.teal.withOpacity(0.1),
              radius: 30.r,
              child: Icon(Icons.payment, color: Colors.teal, size: 30.sp),
            ),
            SizedBox(height: 16.h),

            // العنوان
            Text(
              "Complete Your Payment",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: 12.h),

            // النص
            Text(
              "You're almost there! Tap the button below to securely pay and enjoy premium access.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.h),

            // زر الدفع
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // غلق الـ Dialog
                context.pushNamed(paymentData); // الانتقال
              },
              icon: Icon(Icons.lock, size: 20.sp),
              label: Text("Pay Now", style: TextStyle(fontSize: 16.sp)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
