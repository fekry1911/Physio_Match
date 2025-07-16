import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import '../../../../core/theme/text_themes/text.dart';

class AlreadyHaveAccount1 extends StatelessWidget {
  const AlreadyHaveAccount1({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?",
            style: TextThemes.font13LightBlackRegular,
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(registerScreen);
                  },
            text: "  Sign up",
            style: TextThemes.font13BlueRegular,
          ),
        ],
      ),
    );
  }
}
