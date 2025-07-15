import 'package:add_ques/features/centers/logic/rate_logic/rate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../../core/shared_widgets/loading_hare_dialog.dart';
import '../../../../../../../core/shared_widgets/shared_button.dart';
import '../../../../../../../core/theme/colors/colors.dart';

void showBottomSheetModel(BuildContext context, String uid) {
  final rateCubit = BlocProvider.of<RateCubit>(context);

  showMaterialModalBottomSheet(
    shape: RoundedRectangleBorder(),
    backgroundColor: Colors.white,
    context: context,
    builder: (ctx) {
      return BlocProvider.value(
        value: rateCubit,
        child: Builder(
          builder: (newContext) {
            return BlocConsumer<RateCubit,RateState>(builder: (context, state){
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Write a Review", style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor)),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 100.h,
                      child: TextFormField(

                        controller: rateCubit.commet,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // default border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.mainTealColor, width: 2), // when focused
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          hintText: 'Type your review',

                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    StarRating(
                      size: 40.0.r,
                      rating: rateCubit.rateing,
                      allowHalfRating: true,
                      color: AppColors.mainTealColor,
                      onRatingChanged: (rating) {
                        rateCubit.changeRate(rating);
                      },
                    ),
                    SizedBox(height: 16.h),
                    TealButtonWithRaduis(text: 'Submit', onTab: () {
                      rateCubit.AddRate(uid);
                    },),

                  ],
                ),
              );
            }, listener: (context, state){
              if (state is AddRateSuccess) {
                Navigator.pop(context); // pop bottom sheet
                Navigator.pop(context); // pop bottom sheet
                rateCubit.rateing = 0;
                rateCubit.commet.clear();
              }

            });
          },
        ),
      );
    },
  );
}