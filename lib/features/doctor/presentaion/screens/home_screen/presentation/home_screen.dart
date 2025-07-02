import 'package:add_ques/features/doctor/presentaion/screens/home_screen/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/get_posts_cubit.dart';


class DoctorDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   return BlocConsumer<GetPostsCubit, GetPostsState>(builder: (BuildContext context, state) {
     var cubit=context.read<GetPostsCubit>();
     if(cubit.posts.isEmpty){
       return Center(child: CircularProgressIndicator());
     }else{
       return ListView.separated(
         itemBuilder: (BuildContext context, int index) {
           return DoctorCard(imageUrl: cubit.posts[index].imageUrl.trim(), name: cubit.posts[index].centerName, jobTitle: cubit.posts[index].content, location: cubit.posts[index].location, experience: cubit.posts[index].experienceYears,);
         },
         separatorBuilder: (BuildContext context, int index) {
           return Divider(height: 1.h, color: Colors.grey);
         },
         itemCount: cubit.posts.length,
       );
     }
   }, listener: (BuildContext context, Object? state) {

   },);
  }
}
