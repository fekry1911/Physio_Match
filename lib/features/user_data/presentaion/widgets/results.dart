import 'package:flutter/material.dart';

import '../../../home_page/presentation/widgets/last_scores.dart';

void showGradesDialog(BuildContext context, dummyScores,specialization) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 600,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: StaticLastScoresWidget(text: "Results of $specialization", dummyScores: dummyScores, backGround: Colors.white,),
      ),
    ),
  );
}
