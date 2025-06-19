import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    // بعد 3 ثواني، نعمل انتقال مع تأثير Fade Out
    Future.delayed(Duration(seconds: 3), () async {
      await _controller.reverse(); // تأثير اختفاء
      final uid = CacheHelper.getString(key: "uid");
      final submitted = CacheHelper.getBoolean(key: "submitted");

      if (uid == null) {
        context.pushAndRemoveUntil(loginScreen);
      } else if (submitted == true) {
        context.pushAndRemoveUntil(homeDeciderScreen);
      } else {
        context.pushAndRemoveUntil(studentRegisterScreen);
      }

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainTealColor,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Text(
            'PhysioMatch',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
