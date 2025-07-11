import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/shared_widgets/shimmer_loading.dart';
import '../../../../../core/theme/colors/colors.dart';
import '../../../logic/get_center_data_cubit.dart';
import '../widgets/center_card.dart';

class AllCentersData extends StatelessWidget {
  const AllCentersData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCenterDataCubit, GetCenterDataState>(
      builder: (BuildContext context, state) {
        if (state is GetCenterDataLoading) {
          return LoadingShimmerWidget();
        }
        if (state is GetAllCenterDataSuccess) {
          return ListView.separated(
            itemCount: state.adminList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  context.pushNamed(center,arguments: state.adminList[index].uid);
                },
                child: HorizontalCenterCard(
                  name: state.adminList[index].name!,
                  phone: state.adminList[index].phone!,
                  imageUrl: state.adminList[index].imageUrl!,
                ).animate().slideX(duration: 500.ms, begin: index%2==0 ? -1.0 : 1.0, end: 0.0),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: AppColors.blackColor);
            },
          );
        } else {
          return (const Center(child: Text('Something went wrong')));
        }
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
