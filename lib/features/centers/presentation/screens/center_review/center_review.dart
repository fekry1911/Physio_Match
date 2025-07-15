import 'package:add_ques/core/shared_widgets/shared_loading.dart';
import 'package:add_ques/features/centers/logic/rate_logic/rate_cubit.dart';
import 'package:add_ques/features/centers/presentation/screens/center_review/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AllReviews extends StatelessWidget {
  const AllReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RateCubit, RateState>(
        builder: (BuildContext context, RateState state) {
          var cubit = context.read<RateCubit>();
          if (state is LoadingReviews) {
            return LoadingShared();
          }
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ReviewCard(
                  userImage: "https://scontent.faly8-2.fna.fbcdn.net/v/t39.30808-6/516747391_3109974565838395_5692320429463937582_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QOUe_cbvOb0Q7kNvwECnmES&_nc_oc=AdlVaR-sjnlccLU5aPlAqpcBFo39tve8kd0pfpKMP588AzTn-Ls14AUQ1MQ3IsqCHzQ&_nc_zt=23&_nc_ht=scontent.faly8-2.fna&_nc_gid=VlZ3XBAQy4WrxAA5a-tR4g&oh=00_AfS9uKhu8W_Tswe3kNc_pOFnxRagalo-Eja9dp47UlPS6Q&oe=687C06F1",
                  userName: cubit.rates[index].userName,
                  reviewDate: DateFormat('dd MMM yyyy, hh:mm a').format(cubit.rates[index].timestamp!),
                  rating: cubit.rates[index].rating,
                  reviewText: cubit.rates[index].comment!
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h);
            },
            itemCount: cubit.rates.length,);
        },
        listener: (BuildContext context, RateState state) {},
      ),
    );
  }
}
