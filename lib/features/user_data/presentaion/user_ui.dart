import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/user_data/logic/update_user_data_cubit.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/dialog.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/list_title_data.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/name_email.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/results.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/resume.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/shared_widgets/shared_loading.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';
import '../../login_screen/logic/cubit/login_states.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
      listener: (context, state) {
        if(state is EditProfileImageUpdated){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.mainTealColor),
                  SizedBox(width: 8),
                  Text("Image Updated Successfully",style: TextThemes.font16BlackBold.copyWith(color: AppColors.mainTealColor)),
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              elevation: 6,
            ),
          );

        }
        if(state is EditProfileCvUpdated){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.mainTealColor),
                  SizedBox(width: 8),
                  Text("CV Updated Successfully",style: TextThemes.font16BlackBold.copyWith(color: AppColors.mainTealColor)),
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              elevation: 6,
            ),
          );

        }
      },
      builder: (context, state) {
        var cubit = context.read<UpdateUserDataCubit>();
        if (cubit.doctortModel == null) {
          return LoadingShared();
        }
        return Padding(
          padding:  EdgeInsets.only(top: 20.h),
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
                        cubit.doctortModel!.imageUrl!,
                        fit: BoxFit.cover,
                        height: 130.h,
                        width: 130.h,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: 120,
                    child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.mainTealColor,
                        child: IconButton(onPressed: (){
                          cubit.updateImage();
                        }, icon: Icon(Icons.edit,color: AppColors.whiteColor,))),
                  ),

                ],
              ).animate().slideY(begin: -1,end: 0,duration: 1000.ms),
              Padding(
                padding: EdgeInsets.only(top: 160.h), // لتحت الصورة بمسافة
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.h), // ✅ الحل هنا
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NameAndEmail(
                        name: cubit.doctortModel!.fullName!,
                        email: cubit.doctortModel!.email!,
                        phone: cubit.doctortModel!.phone!,
                      ).animate().slideY(begin: 1,end: 0,duration: 1000.ms),
                      SizedBox(height: 20.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 34.w),
                        child: ResumeButton().animate().slideX(begin: -1,end: 0,duration: 550.ms),
                      ),
                      SizedBox(height: 20.h),
                      IconAndInfo(
                        image: 'assets/icons/bookmark.png',
                        data: 'Saved Posts',
                        onPreesed: () {
                          context.pushNamed(savedPosts);
                        },
                        backColor: Color(0xffcddada),
                      ).animate().slideX(begin: -1,end: 0,duration: 700.ms),



                      SizedBox(height: 20.h),
                      IconAndInfo(
                        image: 'assets/icons/credit-score.png',
                        data: 'Show My Scores',
                        onPreesed: () {
                          DropDownState<String>(
                            dropDown: DropDown<String>(
                              data: <SelectedListItem<String>>[
                                SelectedListItem(data: 'Cardiopulmonary'),
                                SelectedListItem(data: 'Geriatric'),
                                SelectedListItem(data: 'ICU'),
                                SelectedListItem(data: 'Neurological'),
                                SelectedListItem(data: 'Occupational'),
                                SelectedListItem(data: 'Orthopedic'),
                                SelectedListItem(data: 'Pediatric'),
                                SelectedListItem(data: 'Women’s Health'),
                              ],
                              onSelected: (selectedItems) {
                                cubit.getUserScores(FirebaseAuth.instance.currentUser!.uid,  selectedItems.first.data).then((value) {
                                  showGradesDialog(context,cubit.scoreModel,selectedItems.first.data);
                                });
                              },
                            ),
                          ).showModal(context);

                        },
                        backColor: Color(0xfffeffea),
                      ).animate().slideX(begin: -1,end: 0,duration: 850.ms),

                      SizedBox(height: 20.h),
                      IconAndInfo(
                        image: 'assets/personalcard.png',
                        data: 'Update My Personal Data',
                        onPreesed: () {
                          showEditProfileDialog(
                            context,
                          );
                        },
                        backColor: Color(0xffEAF2FF),
                      ).animate().slideX(begin: -1,end: 0,duration: 1000.ms),

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
                        ).animate().slideY(begin: 1,end: 0,duration: 1000.ms),
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
                          color: AppColors.mainTealColor,
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
          ),
        );
      },
    );
  }
}
