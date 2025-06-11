import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/const.dart';
import '../../../../core/theme/colors/colors.dart';

Future AwesomeDialog({required context1,required correct,required widget}){
  return showDialog(
    context: context1,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.mainTealColor, size: 30),
          SizedBox(width: 8),
          Text(
            "Result",
            style: TextStyle(
              color: AppColors.mainTealColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      content: Text(
        "You got $correct / ${widget.questions.length} correct!",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainTealColor,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.of(context1).pushNamedAndRemoveUntil(
                homeScreen,
                    (route) => false, // يحذف كل الشاشات السابقة
              );

            },
            child: Text(
              "Back to Home",
              style: TextStyle(
                fontSize: 18,
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