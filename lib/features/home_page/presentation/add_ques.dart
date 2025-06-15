import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/home_page/presentation/widgets/animated_text.dart';
import 'package:add_ques/features/home_page/presentation/widgets/last_scores.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../test.dart';
import '../../register_screen/presentation/widgets/errr_setup.dart';

class AddAllAues extends StatelessWidget {
  AddAllAues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: IconButton(
                onPressed: () {
                  context.pushNamed(userData);
                },
                icon: Icon(Icons.settings, color: Colors.white, size: 30.r),
              ),
            ),
          ], //

          backgroundColor: Colors.teal,
          title: Text(
            "Home",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<LoginCubit, LoginStates>(
                builder: (context, state) {
                  var cubit = context.read<LoginCubit>();

                  return cubit.model == null
                      ? CircularProgressIndicator(
                        color: AppColors.mainTealColor,
                      )
                      : Text(
                        "Hi ${cubit.model!.name}",
                        style: TextThemes.font22BlackMedium.copyWith(
                          color: AppColors.mainTealColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                        ),
                      );
                },
                listener: (BuildContext context, LoginStates state) {},
              ),
              SizedBox(height: 16.h),
              AnimatedText(),
              SizedBox(height: 30.h),
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = context.read<LoginCubit>();

                  return StaticLastScoresWidget(
                    dummyScores: cubit.scoreModel,
                    backGround: Colors.teal[50]!,
                  );
                },
              ),
              SizedBox(height: 30.h),
              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  var cubit = context.read<LoginCubit>();
                  return Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 70.h,
                      child:
                          cubit.model != null
                              ? MaterialButton(
                                disabledColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed:
                                    cubit.model!.tries <= 0
                                        ? null
                                        : () async {
                                          print(cubit.model!.tries);
                                          print(
                                            """"""
                                            """"""
                                            """"""
                                            """"""
                                            """"""
                                            """"""
                                            """dd""ddddddddddddddddddddddddddddd""",
                                          );

                                          context
                                              .read<HomeCubit>()
                                              .getRandomQues();

                                          // Action here
                                        },
                                color: Colors.teal,
                                child: Text(
                                  cubit.model!.tries <= 0
                                      ? "You Haven\'t any tries  "
                                      : "Start Quiz",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              )
                              : Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainTealColor,
                                ),
                              ),
                    ),
                  );
                },
              ),
              BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is GetLoading) {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainTealColor,
                            ),
                          ),
                    );
                  }
                  if (state is GetSucc) {
                    Navigator.pop(context);
                    context
                        .pushNamed(
                          quizScreen,
                          arguments: context.read<HomeCubit>().questions,
                        )
                        .then((value) {
                          context.read<HomeCubit>().resetState();
                        });
                  }
                  if (state is GetFail) {
                    setupState(
                      context,
                      error: state.error,
                      icon: Icons.error,
                      color: Colors.red,
                      onpressed: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                child: SizedBox.shrink(),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.view_in_ar),
                label: Text("عرض ثلاثي الأبعاد"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Anatomy3DView(
                        title: 'العضلة ذات الرأسين (Biceps)',
                        url: 'https://sketchfab.com/3d-models/biceps-brachii-40b94cb7af854a669f0d6123bc7b7540',
                      ),
                    ),
                  );
                },
              )

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: AppColors.mainTealColor,
        onPressed: () {
          context.pushNamed(chatScreen);
        },
        child: Icon(Icons.assistant,size: 25.r,color: Colors.white,),
      ),
    );
  }
}
