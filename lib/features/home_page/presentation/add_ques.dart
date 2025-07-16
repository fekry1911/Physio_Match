import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/home_page/presentation/widgets/paymentDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/shared_widgets/loading_hare_dialog.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/theme/colors/colors.dart';
import '../data/data/data.dart';

class AddAllAues extends StatelessWidget {
  const AddAllAues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocListener<HomeCubit, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state is GetLoading) {
            dialogLoading(context);
          }
          if (state is GetSucc) {
            Navigator.pop(context);
            context.pushNamed(
              quizScreen,
              arguments: context.read<HomeCubit>().questions,
            );
          }
          if (state is GetFail) {
            Navigator.pop(context);
            AwesomeSnackBar(
              context: context,
              tittle: "Error",
              message: state.error,
            );
          }
          if (state is OutOfTries) {
            Navigator.pop(context);
            showPaymentDialog(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  specialization = items[index]["text"]!;
                  context.read<HomeCubit>().getRandomQues(specialization);
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          items[index]["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100.h,
                          cacheHeight: (100.h * MediaQuery.of(context).devicePixelRatio).toInt(),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.white, Colors.white.withOpacity(0.0)],
                              stops: [0.0, 0.5],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          items[index]["text"]!,
                          textAlign: TextAlign.center,
                          style: TextThemes.font16BlackBold.copyWith(
                            color: AppColors.mainTealColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().slideX(
                  duration: 500.ms,
                  begin: index.isEven ? -1.0 : 1.0,
                  end: 0.0,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.h),
          ),
        ),
      ),
    );
  }
}
