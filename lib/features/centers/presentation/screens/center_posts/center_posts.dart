import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared_widgets/shimmer_loading.dart';
import '../../../../doctor/presentaion/screens/home_screen/presentation/widgets/card.dart';
import '../../../logic/get_center_data_cubit.dart';


class CenterPosts extends StatelessWidget {
  const CenterPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text("Posts", style: TextStyle(color: AppColors.blackColor)),
      ),
      body: BlocConsumer<GetCenterDataCubit, GetCenterDataState>(
        builder: (BuildContext context, state) {
          var cubit = context.read<GetCenterDataCubit>();
          if (cubit.posts.isEmpty) {
            return LoadingShimmerWidget();

          } else {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return PostCard(postModel: cubit.posts[index],applied: true,);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1.h, color: Colors.grey);
              },
              itemCount: cubit.posts.length,
            );
          }
        },
        listener: (BuildContext context, Object? state) {

        },
      ),
    );
  }
}
