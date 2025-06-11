import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/home_page/presentation/widgets/animated_text.dart';
import 'package:add_ques/features/home_page/presentation/widgets/drawer.dart';
import 'package:add_ques/features/home_page/presentation/widgets/last_scores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/theme/colors/colors.dart';
import '../../register_screen/presentation/widgets/errr_setup.dart';

class AddAllAues extends StatelessWidget {
  AddAllAues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.h),
            child: Center(
              child: Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 25.r),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
              ),
            ),
          ),
          backgroundColor: Colors.teal,
          title: Center(
            child: Text(
              "Add All Questions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hi ${CacheHelper.getString(key: "name")}",
              style: TextThemes.font22BlackMedium.copyWith(
                color: AppColors.mainTealColor,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
              ),
            ),
            SizedBox(height: 16.h),
            AnimatedText(),
            Spacer(),
            StaticLastScoresWidget(),
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 70.h,
                child: MaterialButton(
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () async {
                    context.read<HomeCubit>().getRandomQues();
                    // Action here
                  },
                  color: Colors.teal,
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if(state is GetLoading){
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
                if(state is GetSucc){
                  Navigator.pop(context);
                  context.pushNamed(quizScreen,arguments: context.read<HomeCubit>().questions).then((value) {
                    context.read<HomeCubit>().resetState();

                  });
                }
                if(state is GetFail){
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

          ],
        ),
      ),
    );
  }
}
