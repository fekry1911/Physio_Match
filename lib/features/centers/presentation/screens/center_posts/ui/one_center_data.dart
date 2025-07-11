import 'package:add_ques/features/user_data/presentaion/widgets/list_title_data.dart';
import 'package:add_ques/features/user_data/presentaion/widgets/name_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          var cubit = context.read<GetCenterDataCubit>();
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
                          cubit.centerModel!.imageUrl!,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NameAndEmail(
                          name: cubit.centerModel!.name!,
                          email: cubit.centerModel!.email!,
                          phone: cubit.centerModel!.phone!,
                        ).animate().slideY(begin: 1, end: 0, duration: 1000.ms),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            cubit.centerModel!.description!,
                            style: TextThemes.font16BlackBold.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        IconAndInfo(
                          image: 'assets/icons/bookmark.png',
                          data: 'Show Posts',
                          onPreesed: () {
                            //context.pushNamed(savedPosts);
                          },
                          backColor: Color(0xffcddada),
                        ).animate().slideX(begin: -1, end: 0, duration: 700.ms),
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
