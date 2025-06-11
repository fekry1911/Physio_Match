import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/text_themes/text.dart';
import '../../../login_screen/logic/cubit/login_cubit.dart';
import '../../../login_screen/presentation/login.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: RichText(text:TextSpan(children: [
          TextSpan(text: "Already have an account?",style: TextThemes.font13LightBlackRegular),
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {
                context.pushNamed(loginScreen);
              },
              text: "        Log in",style: TextThemes.font13BlueRegular)
        ]),),
      ),
    );
  }
}
