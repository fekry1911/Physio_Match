import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainTealColor,
      body: Center(
        child: Text("Doctor Home"),
      ),
    );
  }
}
