import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/dialog.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/list_title_data.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/name_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';
import '../../home_page/presentation/widgets/last_scores.dart';
import '../../login_screen/logic/cubit/login_states.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.pushAndRemoveUntil(homeScreen);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.mainTealColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainTealColor,
            title: Text(
              "Profile",
              style: TextThemes.font18BlackSemiBold.copyWith(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<UpdateUserDataCubit>();
            if (cubit.studentModel == null) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.whiteColor),
              );
            }
            return Stack(
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
                Positioned(
                  top: 0,
                  child: ClipOval(
                    child: Image.network(
                      cubit.studentModel!.imageUrl,
                      fit: BoxFit.cover,
                      height: 130.h,
                      width: 130.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 160.h), // لتحت الصورة بمسافة
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NameAndEmail(
                          name: cubit.studentModel!.fullName,
                          email: cubit.studentModel!.email,
                          phone: cubit.studentModel!.phone,
                        ),
                        SizedBox(height: 20.h),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: StaticLastScoresWidget(
                            dummyScores: cubit.scoreModel,
                            backGround: Colors.grey.shade100,
                            text: "Your Last Scores",
                          ),
                        ),

                        SizedBox(height: 20.h),

                        IconAndInfo(
                          image: 'assets/personalcard.png',
                          data: 'Update My Personal Data',
                          onPreesed: () {
                            showEditProfileDialog(
                              context,
                              imageUrl: cubit.studentModel!.imageUrl!,
                            );
                          },
                          backColor: Color(0xffEAF2FF),
                        ),
                        Divider(height: 25.h, endIndent: 50.w, indent: 30.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0.h),
                          child: IconAndInfo(
                            image: 'assets/logout.png',
                            data: 'Log Out',
                            onPreesed: () {
                              context.read<LoginCubit>().signOut();
                            },
                            backColor: Color(0xffFFEEEF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocListener<LoginCubit, LoginStates>(
                  listener: (BuildContext context, state) {
                    if (state is SignOutLoad) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                                semanticsLabel: "loading",
                              ),
                            ),
                      );
                    }
                    if (state is SignOutDone) {
                      context.pushAndRemoveUntil(loginScreen);
                    }
                    if (state is SignOutFail) {
                      AwesomeSnackBar(
                        context: context,
                        tittle: "SignOut Error",
                        message: state.error,
                      );
                    }
                  },
                  child: SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
