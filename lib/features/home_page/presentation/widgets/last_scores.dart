import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../quiz/data/models/score_models.dart';

class StaticLastScoresWidget extends StatelessWidget {
  StaticLastScoresWidget({super.key,required this.dummyScores,required this.backGround});
  List<ScoreModel> dummyScores;
  Color backGround;

  Color getScoreColor(int score) {
    if (score >= 8) return Colors.green[700]!;
    if (score >= 5) return Colors.orange[700]!;
    return Colors.red[700]!;
  }

  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: backGround,//Colors.teal[50],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Icon(Icons.bar_chart, color: Colors.teal, size: 26.r),
                 SizedBox(width: 8.w),
                Text(
                  "Your Last Scores",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
        dummyScores.isEmpty
            ?  Center(
          child: Text(
              "Please take a quiz to see your results here....",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          ),
        )
            : Column(
          children: dummyScores.map(
                (score) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.teal[600]),
                  const SizedBox(width: 10),
                  Text(
                    "Score: ${score.correctAnswers}/${score.totalQuestions}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: getScoreColor(score.correctAnswers),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    (score.date.toIso8601String()).split("T").first,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ).toList(),
        ),
          ],
        ),
      ),
    );
  }
}
