import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors/colors.dart';
import '../theme/text_themes/text.dart';

class TealButtonWithRaduis extends StatelessWidget {
   TealButtonWithRaduis({super.key,required this.text,required this.onTab});
   String? text;
   void Function() onTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311.w,
      height: 52.h,
      child: MaterialButton(onPressed: onTab,
          color: AppColors.mainTealColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)

          ),
          child: Text("$text",style: TextThemes.textWhiteSemi16,)
      ),
    )
    ;
  }
}
