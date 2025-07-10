import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/const/const.dart';
import '../../../../core/theme/text_themes/text.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(

          text: TextSpan(
              children: [
        TextSpan(text: "By logging, you agree to our  ",style: TextThemes.font13GreyRegular),
        TextSpan(text: "Terms & Conditions  ",style: TextThemes.font13LightBlackRegular),
        TextSpan(text: "and  ",style: TextThemes.font13GreyRegular.copyWith(height: 2)),
        TextSpan(text: "PrivacyPolicy.",style: TextThemes.font13LightBlackRegular),

      ])).animate().slideX(duration: durationAnimate.ms,begin: 1,end: 0),
    );
  }
}
