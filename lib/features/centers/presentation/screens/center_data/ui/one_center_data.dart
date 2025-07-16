import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/centers/logic/rate_logic/rate_cubit.dart';
import 'package:add_ques/features/centers/presentation/screens/center_data/ui/widgets/bottom_sheet_review.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/list_title_data.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/name_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/shared_widgets/loading_hare_dialog.dart';
import '../../../../../../core/shared_widgets/shared_loading.dart';
import '../../../../../../core/theme/colors/colors.dart';
import '../../../../../../core/theme/text_themes/text.dart';
import '../../../../logic/get_center_data_cubit.dart';

class CenterData extends StatelessWidget {
  const CenterData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<GetCenterDataCubit, GetCenterDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var globalCubit = context.read<GetCenterDataCubit>();
          if (state is GetCenterDataLoading) {
            return LoadingShared();
          }
          return Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Stack(
                  //  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: ClipOval(
                        child: Image.network(
                          globalCubit.centerModel!.imageUrl!,
                          fit: BoxFit.cover,
                          height: 130.h,
                          width: 130.h,
                        ),
                      ),
                    ),
                  ],
                ).animate().slideY(begin: -1, end: 0, duration: 1000.ms),
                Padding(
                  padding: EdgeInsets.only(top: 160.h), // لتحت الصورة بمسافة
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NameAndEmail(
                          name: globalCubit.centerModel!.name!,
                          email: globalCubit.centerModel!.email!,
                          phone: globalCubit.centerModel!.phone!,
                        ).animate().slideY(begin: 1, end: 0, duration: 1000.ms),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            globalCubit.centerModel!.description!,
                            style: TextThemes.font16BlackBold.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        IconAndInfo(
                          image: 'assets/icons/postbox.png',
                          data: '${globalCubit.centerModel!.name} Posts',
                          onPreesed: () {
                            context.pushNamed(
                              centerPosts,
                              arguments: globalCubit.centerModel!.uid,
                            );
                          },
                          backColor: Color(0xffE2C1C1),
                        ).animate().slideX(begin: -1, end: 0, duration: 700.ms),
                        SizedBox(height: 20.h),
                        IconAndInfo(
                          image: 'assets/icons/rating.png',
                          data: 'Show Reviews',
                          onPreesed: () {
                            context.pushNamed(
                              allReviews,
                              arguments: globalCubit.centerModel!.uid,
                            );
                          },
                          backColor: Color(0xffd3c6c2),
                        ).animate().slideX(begin: 1, end: 0, duration: 700.ms),

                        SizedBox(height: 20.h),
                        Text(
                          "Rate This Center",
                          style: TextThemes.font16BlackBold.copyWith(),
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<RateCubit, RateState>(
                          builder: (context, state) {
                            var cubit = context.read<RateCubit>();
                            return Column(
                              children: [
                                StarRating(
                                  size: 40.0.r,
                                  rating: cubit.rateing,
                                  allowHalfRating: true,
                                  color: AppColors.mainTealColor,
                                  onRatingChanged: (rating) {
                                    cubit.changeRate(rating);
                                  },
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Spacer(),
                                    state is! AddRateLoading
                                        ? MaterialButton(
                                          onPressed: () {
                                            cubit.AddRate(
                                              globalCubit.centerModel!.uid!,
                                            );
                                          },
                                          child: Text("Submit"),
                                        )
                                        : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    Spacer(),

                                    Text(
                                      "or",
                                      style: TextThemes.font16BlackBold
                                          .copyWith(color: Colors.red),
                                    ),
                                    Spacer(),

                                    TextButton(
                                      onPressed: () {
                                        showBottomSheetModel(
                                          context,
                                          globalCubit.centerModel!.uid!,
                                        );
                                      },
                                      child: Text(
                                        "Write Review",
                                        style: TextThemes.font16BlackBold
                                            .copyWith(
                                              color: AppColors.mainTealColor,
                                            ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                BlocListener<RateCubit, RateState>(
                                  listener: (context, state) {
                                    var cubit = context.read<RateCubit>();
                                    if (state is AddRateLoading) {
                                      dialogLoading(context);
                                    }
                                    if (state is AddRateSuccess) {
                                      Navigator.pop(context);
                                      cubit.rateing = 0;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text("Rate Added")),
                                      );
                                    }
                                    if (state is AddRateError) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Try Again Later"),
                                        ),
                                      );
                                    }
                                  },
                                  child: SizedBox(),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
