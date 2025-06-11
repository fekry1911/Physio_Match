import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  State<AnimatedText> createState() =>
      _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  final List<String> texts = [
    'Welcome to PhysioMatch!',
    'Let\'s test your physiotherapy knowledge.',
    'Get started with a quick quiz!',
  ];

  List<String> displayedTexts = [];
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    startTypingLoop();
  }

  void startTypingLoop() async {
    while (_isMounted) {
      for (int i = 0; i < texts.length && _isMounted; i++) {
        await Future.delayed(Duration(milliseconds: 600));
        if (!_isMounted) break;
        setState(() {
          displayedTexts.add(texts[i]);
        });
        await Future.delayed(Duration(seconds: 2));
      }

      await Future.delayed(Duration(seconds: 3));
      if (!_isMounted) break;
      setState(() {
        displayedTexts.clear();
      });
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: displayedTexts
          .map(
            (text) => AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: AppColors.darkBBlack,
                fontWeight: FontWeight.bold,
              ),
              speed: Duration(milliseconds: 80),
            ),
          ],
          totalRepeatCount: 1,
          isRepeatingAnimation: false,
          displayFullTextOnTap: true,
        ),
      )
          .toList(),
    );
  }
}

