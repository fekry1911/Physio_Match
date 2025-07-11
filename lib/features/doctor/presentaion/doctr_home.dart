import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:add_ques/core/theme/text_themes/text.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/doctor_cubit.dart';

class DoctorHomeScreen extends StatefulWidget {
  final int initialIndex;

  const DoctorHomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late final NotchBottomBarController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<DoctorCubit>(context, listen: false);
    cubit.changeIndex(widget.initialIndex);
    _controller = NotchBottomBarController(index: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<DoctorCubit>(context);
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
          ),
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: AnimatedNotchBottomBar(
            notchBottomBarController: _controller,
            bottomBarItems: [
              BottomBarItem(
                inActiveItem: const FaIcon(FontAwesomeIcons.home, color: Colors.grey),
                activeItem: FaIcon(FontAwesomeIcons.home, color: AppColors.blackColor),
                itemLabel: 'Home',
              ),
              BottomBarItem(
                inActiveItem: const FaIcon(FontAwesomeIcons.question, color: Colors.grey),
                activeItem: FaIcon(FontAwesomeIcons.question, color: AppColors.blackColor),
                itemLabel: 'Quizes',
              ),
              BottomBarItem(
                inActiveItem: const FaIcon(FontAwesomeIcons.centercode, color: Colors.grey),
                activeItem: FaIcon(FontAwesomeIcons.centercode, color: AppColors.blackColor),
                itemLabel: 'Centers',
              ),
              BottomBarItem(
                inActiveItem: const FaIcon(FontAwesomeIcons.person, color: Colors.grey),
                activeItem: FaIcon(FontAwesomeIcons.person, color: AppColors.blackColor),
                itemLabel: 'Profile',
              ),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
              _controller.jumpTo(index); // optional if you want to sync manually
            },
            kBottomRadius: 20.r,
            textAlign: TextAlign.center,
            bottomBarHeight: 60.h,
            color: AppColors.whiteColor,
            notchColor: Colors.white,
            removeMargins: false,
            showShadow: true,
            shadowElevation: 5,
            kIconSize: 24.r,
          ),
        );
      },
    );
  }
}
