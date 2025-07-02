import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:add_ques/features/home_page/logic/home_cubit.dart';
import 'package:add_ques/features/home_page/presentation/widgets/paymentDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/const.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/theme/colors/colors.dart';
import '../data/data/data.dart';

class AddAllAues extends StatelessWidget {
  AddAllAues({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              specialization = items[index]["text"]!;
              print(specialization);
              print(items[index]["text"]);
              print("1222222222222222222222223333333333333333333");

              context.read<HomeCubit>().getRandomQues(items[index]["text"]!);
            },
            child: Card(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    items[index]["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100.h,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.white, Colors.white.withOpacity(0.0)],
                          stops: [0.0, 0.5],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      items[index]["text"]!,
                      style: TextThemes.font16BlackBold.copyWith(
                        color: AppColors.mainTealColor,
                      ),
                    ),
                  ),
                  BlocListener<HomeCubit, HomeState>(
                    listener: (BuildContext context, HomeState state) {
                      if (state is GetLoading) {
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
                      if (state is GetSucc) {
                        Navigator.pop(context);
                        context.pushNamed(
                          quizScreen,
                          arguments: context.read<HomeCubit>().questions,
                        );
                      }
                      if (state is GetFail) {
                        Navigator.pop(context);
                        AwesomeSnackBar(
                          context: context,
                          tittle: "error",
                          message: state.error,
                        );
                      }
                      if (state is OutOfTries) {
                        Navigator.pop(context);
                        showPaymentDialog(context);
                      }
                    },
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
      ),
    );
  }
}
