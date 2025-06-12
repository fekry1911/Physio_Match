import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/quiz/logic/save_score_cubit.dart';
import 'package:add_ques/features/quiz/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/theme/colors/colors.dart';
import '../../../core/theme/text_themes/text.dart';

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  bool showResult = false;
  late List<int?> selectedAnswers;

  int? get selectedIndex => selectedAnswers[currentIndex];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(widget.questions.length, null);
  }

  void checkAnswer(int index) {
    setState(() {
      selectedAnswers[currentIndex] = index;
    });
  }

  void calculateResult() {
    int correct = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedAnswers[i] == widget.questions[i]['correctAnswerIndex']) {
        correct++;
      }
    }
    setState(() {
      showResult = true;
    });
    final saveCubit = context.read<SaveScoreCubit>(); // ✅
    AwesomeDialog(
      context: context,
      correct: correct,
      widget: widget,
      cubit: saveCubit, // ✅ مرر cubit
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) {
      return Scaffold(
        body: Column(
          children: [
            Center(
              child: Text('You got your result!', style: TextStyle(fontSize: 24)),
            ),
            BlocListener<SaveScoreCubit, SaveScoreState>(
              listener: (BuildContext context, SaveScoreState state) {
                if(state is SaveScoreSucc){
                  context.pushAndRemoveUntil(homeScreen);
                }
                if(state is SaveScoreLoad){
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
                if(state is SaveScoreFail){
                  AwesomeSnackBar(
                    context: context,
                    tittle: "Save Score Error",
                    message: state.error,
                  );
                }


              },
              child: SizedBox.shrink(),
            ),

          ],
        )
      );
    }

    final question = widget.questions[currentIndex];

    return WillPopScope(
      onWillPop: () {
        context.pushAndRemoveUntil(homeScreen);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('MCQ Quiz'),
        ),

        body: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Q${currentIndex + 1}: ${question['questionText']}',
                style: TextStyle(
                  letterSpacing: 2,
                  height: 1.4,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainTealColor,
                ),
              ),
              SizedBox(height: 20.h),
              ...List.generate(question['options'].length, (index) {
                bool isSelected = selectedIndex == index;

                return Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 6.dg),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected
                                ? AppColors.mainTealColor
                                : Colors.grey[200],
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                      ),
                      onPressed: () => checkAnswer(index),
                      child: Text(
                        question['options'][index],
                        style: TextStyle(
                          fontSize: 16.sp,
                          letterSpacing: 2,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              Container(
                margin: EdgeInsets.all(30.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${currentIndex + 1}  /  10",
                      style: TextThemes.font22BlackMedium.copyWith(
                        color:
                            currentIndex == widget.questions.length - 1
                                ? AppColors.mainTealColor
                                : Colors.red,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50.h,
                          width: 100.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed:
                                currentIndex > 0
                                    ? () {
                                      setState(() {
                                        currentIndex--;
                                      });
                                    }
                                    : null,
                            child: Text(
                              'Previous',
                              style: TextStyle(
                                color:
                                    currentIndex > 0
                                        ? Colors.white
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50.h,
                          width: 100.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                            ),
                            onPressed:
                                selectedIndex != null
                                    ? () {
                                      if (currentIndex <
                                          widget.questions.length - 1) {
                                        setState(() {
                                          currentIndex++;
                                        });
                                      } else {
                                        calculateResult();
                                      }
                                    }
                                    : null,
                            child: Text(
                              currentIndex == widget.questions.length - 1
                                  ? 'Finish'
                                  : 'Next',
                              style: TextStyle(
                                color:
                                    selectedIndex != null
                                        ? Colors.white
                                        : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
