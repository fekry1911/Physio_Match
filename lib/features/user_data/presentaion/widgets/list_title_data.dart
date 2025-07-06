import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_themes/text.dart';

class IconAndInfo extends StatelessWidget {
   IconAndInfo({super.key,required this.image,required this.data,required this.onPreesed,required this.backColor});
   String image;
   String data;
   void Function()? onPreesed;
   Color backColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: onPreesed,
        child: CircleAvatar(
          backgroundColor: backColor,//Color(0xffEAF2FF),
          radius: 40.r,child: Image.asset(image,fit: BoxFit.cover,height: 20.h,width: 20.h,),
        ),
      ),
      title: Text(data,style: TextThemes.font18BlackSemiBold.copyWith(color: Color(0xff242424)),),

    );
  }
}
