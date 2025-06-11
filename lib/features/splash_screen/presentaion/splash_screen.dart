import 'package:add_ques/core/const/const.dart';
import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/core/helpers/extentions/context_extention.dart';
import 'package:add_ques/features/login_screen/logic/cubit/login_cubit.dart';
import 'package:add_ques/features/login_screen/presentation/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home_page/presentation/add_ques.dart';
import '../../quiz/presentation/qui.dart';

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
      CacheHelper.getString(key: "uid")==null
          ?context.pushAndRemoveUntil(loginScreen)
          :context.pushAndRemoveUntil(homeScreen);
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
      backgroundColor: Color(0xFF008080),
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