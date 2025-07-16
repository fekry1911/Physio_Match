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
                userName: cubit.rates[index].userName,
                reviewDate: DateFormat(
                  'dd MMM yyyy, hh:mm a',
                ).format(cubit.rates[index].timestamp),
                rating: cubit.rates[index].rating,
                reviewText: cubit.rates[index].comment!,
                userImage: cubit.rates[index].image,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h);
            },
            itemCount: cubit.rates.length,
          );
        },
        listener: (BuildContext context, RateState state) {},
      ),
    );
  }
}
