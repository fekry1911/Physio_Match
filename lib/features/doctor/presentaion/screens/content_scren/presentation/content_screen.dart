import 'package:add_ques/core/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/text_themes/text.dart';
import '../../../../../home_page/data/data/data.dart';

class DoctorFilesScreen extends StatelessWidget {
  const DoctorFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  items[index]["image"]!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100.h,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.white, Colors.white.withOpacity(0.0)],
                        stops: [0.0, 0.5],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    items[index]["text"]!,
                    style: TextThemes.font16BlackBold.copyWith(
                      color: AppColors.mainTealColor,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().slideX(
            duration: 500.ms,
            begin: index.isEven ? -1.0 : 1.0,
            end: 0.0,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
      ),
    );
  }
}
