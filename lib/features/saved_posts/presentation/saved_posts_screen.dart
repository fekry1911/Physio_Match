import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared_widgets/shimmer_loading.dart';
import '../../doctor/presentaion/screens/home_screen/presentation/widgets/card.dart';
import '../logic/get_saved_posts_cubit.dart';

class MySavedPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Your Saved Posts", style: TextStyle(color: AppColors.mainTealColor)),
      ),
      body: BlocBuilder<GetSavedPostsCubit, GetSavedPostsState>(
        builder: (context, state) {
          if (state is GetPostsLoading) {
            return LoadingShimmerWidget();
          } else if (state is GetPostsFailure) {
            return Center(child: Text(state.error,));
          } else if (state is GetPostsSuccess) {
            if (state.posts.isEmpty) {
              return Center(child: Text("No Posts Yet", ));
            }
            return ListView.separated(
              itemBuilder: (context, index) => PostCard(postModel: state.posts[index],applied: true,),
              separatorBuilder: (context, index) => Divider(height: 1.h),
              itemCount: state.posts.length,
            );
          } else {
            return SizedBox(); // لحالة غير متوقعة
          }
        },
      ),
    );
  }
}
